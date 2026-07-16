unit uServicoFinanceiro;

interface

uses
  System.SysUtils, System.Classes, System.DateUtils, Data.DB,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet;

type
  TServicoFinanceiro = class
  private
    class function CriarQuery(pTrans: TIBTransaction): TIBQuery; static;
    class function InserirMovimento(pTrans: TIBTransaction;
      const pData: TDateTime; const pTipo: Char; const pValor: Currency;
      const pHistorico, pOrigem: string; pCodigoOrigem, pCodigoForma,
      pCodigoConta, pCodigoCentroCusto: Integer): Integer; static;
  public
    class procedure GerarFinanceiroVenda(pTrans: TIBTransaction;
      pCodigoVenda: Integer); static;
    class procedure EstornarFinanceiroVenda(pTrans: TIBTransaction;
      pCodigoVenda: Integer); static;
    class procedure BaixarTituloReceber(pTrans: TIBTransaction;
      pCodigoTitulo: Integer; const pDataBaixa: TDateTime;
      const pValor: Currency; pCodigoForma, pCodigoConta: Integer); static;
    class procedure BaixarTituloPagar(pTrans: TIBTransaction;
      pCodigoTitulo: Integer; const pDataBaixa: TDateTime;
      const pValor: Currency; pCodigoForma, pCodigoConta: Integer); static;
    class function CalcularSaldoDia(pTrans: TIBTransaction;
      const pData: TDateTime): Currency; static;
    class procedure CalcularSaldoPorForma(pTrans: TIBTransaction;
      const pData: TDateTime; pDestino: TIBQuery); static;
    class function ConciliarAutomatico(pTrans: TIBTransaction;
      pCodigoConta: Integer; const pDataIni, pDataFim: TDateTime): Integer; static;
    class function ValidarLimiteCredito(pTrans: TIBTransaction;
      pCodigoCliente: Integer; const pValorPrazo: Currency): Boolean; static;
    class function DiaCaixaFechado(pTrans: TIBTransaction;
      const pData: TDateTime): Boolean; static;
    class procedure CarregarProjecaoFluxo(pTrans: TIBTransaction;
      const pDataIni, pDataFim: TDateTime; pDestino: TIBQuery); static;
  end;

implementation

uses
  uConexao;

class function TServicoFinanceiro.CriarQuery(pTrans: TIBTransaction): TIBQuery;
begin
  Result := TIBQuery.Create(nil);
  Result.Database := dmConexao.IBDConexao;
  Result.Transaction := pTrans;
end;

class function TServicoFinanceiro.InserirMovimento(pTrans: TIBTransaction;
  const pData: TDateTime; const pTipo: Char; const pValor: Currency;
  const pHistorico, pOrigem: string; pCodigoOrigem, pCodigoForma,
  pCodigoConta, pCodigoCentroCusto: Integer): Integer;
var
  lQ: TIBQuery;
begin
  Result := 0;
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'INSERT INTO MOVIMENTO_CAIXA ' +
      '  (DATA, TIPO, VALOR, HISTORICO, CODIGO_FORMA_PAGAMENTO, ' +
      '   CODIGO_CONTA, CODIGO_CENTRO_CUSTO, ORIGEM, CODIGO_ORIGEM, CONCILIADO) ' +
      'VALUES ' +
      '  (:DATA, :TIPO, :VALOR, :HISTORICO, :CODIGO_FORMA_PAGAMENTO, ' +
      '   :CODIGO_CONTA, :CODIGO_CENTRO_CUSTO, :ORIGEM, :CODIGO_ORIGEM, ''N'')';
    lQ.ParamByName('DATA').AsDateTime := Trunc(pData);
    lQ.ParamByName('TIPO').AsString := pTipo;
    lQ.ParamByName('VALOR').AsCurrency := pValor;
    lQ.ParamByName('HISTORICO').AsString := Copy(pHistorico, 1, 200);
    if pCodigoForma > 0 then
      lQ.ParamByName('CODIGO_FORMA_PAGAMENTO').AsInteger := pCodigoForma
    else
      lQ.ParamByName('CODIGO_FORMA_PAGAMENTO').Clear;
    if pCodigoConta > 0 then
      lQ.ParamByName('CODIGO_CONTA').AsInteger := pCodigoConta
    else
      lQ.ParamByName('CODIGO_CONTA').Clear;
    if pCodigoCentroCusto > 0 then
      lQ.ParamByName('CODIGO_CENTRO_CUSTO').AsInteger := pCodigoCentroCusto
    else
      lQ.ParamByName('CODIGO_CENTRO_CUSTO').Clear;
    lQ.ParamByName('ORIGEM').AsString := Copy(pOrigem, 1, 30);
    if pCodigoOrigem > 0 then
      lQ.ParamByName('CODIGO_ORIGEM').AsInteger := pCodigoOrigem
    else
      lQ.ParamByName('CODIGO_ORIGEM').Clear;
    lQ.ExecSQL;

    lQ.Close;
    lQ.SQL.Text := 'SELECT GEN_ID(GEN_MOVIMENTO_CAIXA_ID, 0) AS COD FROM RDB$DATABASE';
    lQ.Open;
    Result := lQ.FieldByName('COD').AsInteger;
  finally
    lQ.Free;
  end;
end;

class procedure TServicoFinanceiro.GerarFinanceiroVenda(pTrans: TIBTransaction;
  pCodigoVenda: Integer);
var
  lPag, lForma, lVenda, lIns: TIBQuery;
  lValorParcela, lResto, lValorTit: Currency;
  lParcelas, lI, lDias: Integer;
  lVenc: TDateTime;
  lHistorico: string;
  lCodigoCliente, lCodigoForma: Integer;
  lImediato, lGeraTitulo: Boolean;
begin
  lVenda := CriarQuery(pTrans);
  lPag := CriarQuery(pTrans);
  lForma := CriarQuery(pTrans);
  lIns := CriarQuery(pTrans);
  try
    lVenda.SQL.Text :=
      'SELECT CODIGO, CODIGO_CLIENTE, DATA_HORA_VENDA, TOTAL_LIQUIDO ' +
      'FROM VENDA WHERE CODIGO = :CODIGO';
    lVenda.ParamByName('CODIGO').AsInteger := pCodigoVenda;
    lVenda.Open;
    if lVenda.IsEmpty then
      Exit;

    lCodigoCliente := lVenda.FieldByName('CODIGO_CLIENTE').AsInteger;

    lPag.SQL.Text :=
      'SELECT CODIGO, CODIGO_FORMA_PAGAMENTO, VALOR, PARCELAS, VENCIMENTO ' +
      'FROM VENDA_PAGAMENTO WHERE CODIGO_VENDA = :CODIGO_VENDA';
    lPag.ParamByName('CODIGO_VENDA').AsInteger := pCodigoVenda;
    lPag.Open;

    while not lPag.Eof do
    begin
      lCodigoForma := lPag.FieldByName('CODIGO_FORMA_PAGAMENTO').AsInteger;
      lParcelas := lPag.FieldByName('PARCELAS').AsInteger;
      if lParcelas < 1 then
        lParcelas := 1;

      lForma.Close;
      lForma.SQL.Text :=
        'SELECT ENTRA_CAIXA_IMEDIATO, GERA_TITULO, DIAS_COMPENSACAO, DESCRICAO ' +
        'FROM FORMA_PAGAMENTO WHERE CODIGO = :CODIGO';
      lForma.ParamByName('CODIGO').AsInteger := lCodigoForma;
      lForma.Open;

      lImediato := lForma.FieldByName('ENTRA_CAIXA_IMEDIATO').AsString = 'S';
      lGeraTitulo := lForma.FieldByName('GERA_TITULO').AsString = 'S';
      lDias := lForma.FieldByName('DIAS_COMPENSACAO').AsInteger;
      lHistorico := Format('Venda %d - %s',
        [pCodigoVenda, Trim(lForma.FieldByName('DESCRICAO').AsString)]);

      if lImediato then
      begin
        InserirMovimento(pTrans, lVenda.FieldByName('DATA_HORA_VENDA').AsDateTime,
          'E', lPag.FieldByName('VALOR').AsCurrency, lHistorico, 'VENDA',
          pCodigoVenda, lCodigoForma, 0, 0);
      end
      else if lGeraTitulo then
      begin
        lValorParcela := Trunc((lPag.FieldByName('VALOR').AsCurrency / lParcelas) * 100) / 100;
        lResto := lPag.FieldByName('VALOR').AsCurrency - (lValorParcela * lParcelas);

        if not lPag.FieldByName('VENCIMENTO').IsNull then
          lVenc := Trunc(lPag.FieldByName('VENCIMENTO').AsDateTime)
        else
          lVenc := Trunc(lVenda.FieldByName('DATA_HORA_VENDA').AsDateTime) + lDias;

        for lI := 1 to lParcelas do
        begin
          if lI = lParcelas then
            lValorTit := lValorParcela + lResto
          else
            lValorTit := lValorParcela;

          lIns.SQL.Text :=
            'INSERT INTO TITULO_RECEBER ' +
            '  (CODIGO_VENDA, CODIGO_CLIENTE, CODIGO_FORMA_PAGAMENTO, ' +
            '   PARCELA, TOTAL_PARCELAS, VENCIMENTO, VALOR, VALOR_SALDO, SITUACAO) ' +
            'VALUES ' +
            '  (:CODIGO_VENDA, :CODIGO_CLIENTE, :CODIGO_FORMA_PAGAMENTO, ' +
            '   :PARCELA, :TOTAL_PARCELAS, :VENCIMENTO, :VALOR, :VALOR_SALDO, ''A'')';
          lIns.ParamByName('CODIGO_VENDA').AsInteger := pCodigoVenda;
          lIns.ParamByName('CODIGO_CLIENTE').AsInteger := lCodigoCliente;
          lIns.ParamByName('CODIGO_FORMA_PAGAMENTO').AsInteger := lCodigoForma;
          lIns.ParamByName('PARCELA').AsInteger := lI;
          lIns.ParamByName('TOTAL_PARCELAS').AsInteger := lParcelas;
          lIns.ParamByName('VENCIMENTO').AsDateTime := IncMonth(lVenc, lI - 1);
          lIns.ParamByName('VALOR').AsCurrency := lValorTit;
          lIns.ParamByName('VALOR_SALDO').AsCurrency := lValorTit;
          lIns.ExecSQL;
        end;
      end;

      lPag.Next;
    end;
  finally
    lIns.Free;
    lForma.Free;
    lPag.Free;
    lVenda.Free;
  end;
end;

class procedure TServicoFinanceiro.EstornarFinanceiroVenda(pTrans: TIBTransaction;
  pCodigoVenda: Integer);
var
  lQ: TIBQuery;
begin
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'UPDATE TITULO_RECEBER SET SITUACAO = ''C'', VALOR_SALDO = 0 ' +
      'WHERE CODIGO_VENDA = :CODIGO_VENDA AND SITUACAO = ''A''';
    lQ.ParamByName('CODIGO_VENDA').AsInteger := pCodigoVenda;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'DELETE FROM MOVIMENTO_CAIXA ' +
      'WHERE ORIGEM = ''VENDA'' AND CODIGO_ORIGEM = :CODIGO_VENDA ' +
      '  AND CONCILIADO = ''N''';
    lQ.ParamByName('CODIGO_VENDA').AsInteger := pCodigoVenda;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'DELETE FROM VENDA_PAGAMENTO WHERE CODIGO_VENDA = :CODIGO_VENDA';
    lQ.ParamByName('CODIGO_VENDA').AsInteger := pCodigoVenda;
    lQ.ExecSQL;
  finally
    lQ.Free;
  end;
end;

class procedure TServicoFinanceiro.BaixarTituloReceber(pTrans: TIBTransaction;
  pCodigoTitulo: Integer; const pDataBaixa: TDateTime;
  const pValor: Currency; pCodigoForma, pCodigoConta: Integer);
var
  lQ: TIBQuery;
  lSaldo: Currency;
  lCodMov: Integer;
begin
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'SELECT VALOR_SALDO, SITUACAO FROM TITULO_RECEBER WHERE CODIGO = :CODIGO';
    lQ.ParamByName('CODIGO').AsInteger := pCodigoTitulo;
    lQ.Open;
    if lQ.IsEmpty or (lQ.FieldByName('SITUACAO').AsString <> 'A') then
      raise Exception.Create('Titulo a receber nao esta em aberto.');

    lSaldo := lQ.FieldByName('VALOR_SALDO').AsCurrency;
    if (pValor <= 0) or (pValor > lSaldo) then
      raise Exception.Create('Valor de baixa invalido.');

    lCodMov := InserirMovimento(pTrans, pDataBaixa, 'E', pValor,
      Format('Baixa titulo receber %d', [pCodigoTitulo]),
      'BAIXA_RECEBER', pCodigoTitulo, pCodigoForma, pCodigoConta, 0);

    lQ.Close;
    lQ.SQL.Text :=
      'INSERT INTO BAIXA_RECEBER (CODIGO_TITULO, DATA_BAIXA, VALOR, CODIGO_MOVIMENTO) ' +
      'VALUES (:CODIGO_TITULO, :DATA_BAIXA, :VALOR, :CODIGO_MOVIMENTO)';
    lQ.ParamByName('CODIGO_TITULO').AsInteger := pCodigoTitulo;
    lQ.ParamByName('DATA_BAIXA').AsDateTime := Trunc(pDataBaixa);
    lQ.ParamByName('VALOR').AsCurrency := pValor;
    lQ.ParamByName('CODIGO_MOVIMENTO').AsInteger := lCodMov;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'UPDATE TITULO_RECEBER SET VALOR_SALDO = VALOR_SALDO - :VALOR ' +
      'WHERE CODIGO = :CODIGO';
    lQ.ParamByName('VALOR').AsCurrency := pValor;
    lQ.ParamByName('CODIGO').AsInteger := pCodigoTitulo;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'UPDATE TITULO_RECEBER SET SITUACAO = ''Q'' ' +
      'WHERE CODIGO = :CODIGO AND VALOR_SALDO <= 0';
    lQ.ParamByName('CODIGO').AsInteger := pCodigoTitulo;
    lQ.ExecSQL;
  finally
    lQ.Free;
  end;
end;

class procedure TServicoFinanceiro.BaixarTituloPagar(pTrans: TIBTransaction;
  pCodigoTitulo: Integer; const pDataBaixa: TDateTime;
  const pValor: Currency; pCodigoForma, pCodigoConta: Integer);
var
  lQ: TIBQuery;
  lSaldo: Currency;
  lCodMov, lCentro: Integer;
begin
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'SELECT VALOR_SALDO, SITUACAO, CODIGO_CENTRO_CUSTO, DESCRICAO ' +
      'FROM TITULO_PAGAR WHERE CODIGO = :CODIGO';
    lQ.ParamByName('CODIGO').AsInteger := pCodigoTitulo;
    lQ.Open;
    if lQ.IsEmpty or (lQ.FieldByName('SITUACAO').AsString <> 'A') then
      raise Exception.Create('Titulo a pagar nao esta em aberto.');

    lSaldo := lQ.FieldByName('VALOR_SALDO').AsCurrency;
    lCentro := lQ.FieldByName('CODIGO_CENTRO_CUSTO').AsInteger;
    if (pValor <= 0) or (pValor > lSaldo) then
      raise Exception.Create('Valor de baixa invalido.');

    lCodMov := InserirMovimento(pTrans, pDataBaixa, 'S', pValor,
      Format('Baixa titulo pagar %d', [pCodigoTitulo]),
      'BAIXA_PAGAR', pCodigoTitulo, pCodigoForma, pCodigoConta, lCentro);

    lQ.Close;
    lQ.SQL.Text :=
      'INSERT INTO BAIXA_PAGAR (CODIGO_TITULO, DATA_BAIXA, VALOR, CODIGO_MOVIMENTO) ' +
      'VALUES (:CODIGO_TITULO, :DATA_BAIXA, :VALOR, :CODIGO_MOVIMENTO)';
    lQ.ParamByName('CODIGO_TITULO').AsInteger := pCodigoTitulo;
    lQ.ParamByName('DATA_BAIXA').AsDateTime := Trunc(pDataBaixa);
    lQ.ParamByName('VALOR').AsCurrency := pValor;
    lQ.ParamByName('CODIGO_MOVIMENTO').AsInteger := lCodMov;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'UPDATE TITULO_PAGAR SET VALOR_SALDO = VALOR_SALDO - :VALOR ' +
      'WHERE CODIGO = :CODIGO';
    lQ.ParamByName('VALOR').AsCurrency := pValor;
    lQ.ParamByName('CODIGO').AsInteger := pCodigoTitulo;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'UPDATE TITULO_PAGAR SET SITUACAO = ''Q'' ' +
      'WHERE CODIGO = :CODIGO AND VALOR_SALDO <= 0';
    lQ.ParamByName('CODIGO').AsInteger := pCodigoTitulo;
    lQ.ExecSQL;
  finally
    lQ.Free;
  end;
end;

class function TServicoFinanceiro.CalcularSaldoDia(pTrans: TIBTransaction;
  const pData: TDateTime): Currency;
var
  lQ: TIBQuery;
begin
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'SELECT ' +
      '  COALESCE(SUM(CASE WHEN TIPO = ''E'' THEN VALOR ELSE 0 END), 0) - ' +
      '  COALESCE(SUM(CASE WHEN TIPO = ''S'' THEN VALOR ELSE 0 END), 0) AS SALDO ' +
      'FROM MOVIMENTO_CAIXA WHERE DATA = :DATA';
    lQ.ParamByName('DATA').AsDateTime := Trunc(pData);
    lQ.Open;
    Result := lQ.FieldByName('SALDO').AsCurrency;
  finally
    lQ.Free;
  end;
end;

class procedure TServicoFinanceiro.CalcularSaldoPorForma(pTrans: TIBTransaction;
  const pData: TDateTime; pDestino: TIBQuery);
begin
  pDestino.Close;
  pDestino.SQL.Clear;
  pDestino.SQL.Add('SELECT FP.CODIGO, FP.DESCRICAO,');
  pDestino.SQL.Add('  COALESCE(SUM(CASE WHEN M.TIPO = ''E'' THEN M.VALOR ELSE 0 END), 0) -');
  pDestino.SQL.Add('  COALESCE(SUM(CASE WHEN M.TIPO = ''S'' THEN M.VALOR ELSE 0 END), 0) AS SALDO');
  pDestino.SQL.Add('FROM FORMA_PAGAMENTO FP');
  pDestino.SQL.Add('LEFT JOIN MOVIMENTO_CAIXA M ON M.CODIGO_FORMA_PAGAMENTO = FP.CODIGO');
  pDestino.SQL.Add('  AND M.DATA = :DATA');
  pDestino.SQL.Add('WHERE FP.ATIVO = ''A''');
  pDestino.SQL.Add('GROUP BY FP.CODIGO, FP.DESCRICAO');
  pDestino.SQL.Add('ORDER BY FP.CODIGO');
  pDestino.ParamByName('DATA').AsDateTime := Trunc(pData);
  pDestino.Open;
end;

class function TServicoFinanceiro.ConciliarAutomatico(pTrans: TIBTransaction;
  pCodigoConta: Integer; const pDataIni, pDataFim: TDateTime): Integer;
var
  lExt, lMov, lUpd: TIBQuery;
begin
  Result := 0;
  lExt := CriarQuery(pTrans);
  lMov := CriarQuery(pTrans);
  lUpd := CriarQuery(pTrans);
  try
    lExt.SQL.Text :=
      'SELECT CODIGO, DATA, VALOR FROM EXTRATO_BANCARIO ' +
      'WHERE CODIGO_CONTA = :CODIGO_CONTA AND CONCILIADO = ''N'' ' +
      '  AND DATA BETWEEN :DATA_INI AND :DATA_FIM';
    lExt.ParamByName('CODIGO_CONTA').AsInteger := pCodigoConta;
    lExt.ParamByName('DATA_INI').AsDateTime := Trunc(pDataIni);
    lExt.ParamByName('DATA_FIM').AsDateTime := Trunc(pDataFim);
    lExt.Open;

    while not lExt.Eof do
    begin
      lMov.Close;
      lMov.SQL.Text :=
        'SELECT FIRST 1 CODIGO FROM MOVIMENTO_CAIXA ' +
        'WHERE CONCILIADO = ''N'' ' +
        '  AND CODIGO_CONTA = :CODIGO_CONTA ' +
        '  AND VALOR = :VALOR ' +
        '  AND DATA BETWEEN :D1 AND :D2';
      lMov.ParamByName('CODIGO_CONTA').AsInteger := pCodigoConta;
      lMov.ParamByName('VALOR').AsCurrency := lExt.FieldByName('VALOR').AsCurrency;
      lMov.ParamByName('D1').AsDateTime := Trunc(lExt.FieldByName('DATA').AsDateTime) - 1;
      lMov.ParamByName('D2').AsDateTime := Trunc(lExt.FieldByName('DATA').AsDateTime) + 1;
      lMov.Open;

      if not lMov.IsEmpty then
      begin
        lUpd.SQL.Text :=
          'UPDATE EXTRATO_BANCARIO SET CONCILIADO = ''S'', CODIGO_MOVIMENTO = :MOV ' +
          'WHERE CODIGO = :CODIGO';
        lUpd.ParamByName('MOV').AsInteger := lMov.FieldByName('CODIGO').AsInteger;
        lUpd.ParamByName('CODIGO').AsInteger := lExt.FieldByName('CODIGO').AsInteger;
        lUpd.ExecSQL;

        lUpd.SQL.Text :=
          'UPDATE MOVIMENTO_CAIXA SET CONCILIADO = ''S'', CODIGO_EXTRATO = :EXT ' +
          'WHERE CODIGO = :CODIGO';
        lUpd.ParamByName('EXT').AsInteger := lExt.FieldByName('CODIGO').AsInteger;
        lUpd.ParamByName('CODIGO').AsInteger := lMov.FieldByName('CODIGO').AsInteger;
        lUpd.ExecSQL;

        Inc(Result);
      end;

      lExt.Next;
    end;
  finally
    lUpd.Free;
    lMov.Free;
    lExt.Free;
  end;
end;

class function TServicoFinanceiro.ValidarLimiteCredito(pTrans: TIBTransaction;
  pCodigoCliente: Integer; const pValorPrazo: Currency): Boolean;
var
  lQ: TIBQuery;
  lLimite, lAberto: Currency;
begin
  Result := True;
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'SELECT COALESCE(LIMITE_CREDITO, 0) AS LIMITE FROM CLIENTE WHERE CODIGO = :CODIGO';
    lQ.ParamByName('CODIGO').AsInteger := pCodigoCliente;
    lQ.Open;
    if lQ.IsEmpty then
      Exit(False);

    lLimite := lQ.FieldByName('LIMITE').AsCurrency;
    if lLimite <= 0 then
      Exit(True);

    lQ.Close;
    lQ.SQL.Text :=
      'SELECT COALESCE(SUM(VALOR_SALDO), 0) AS ABERTO ' +
      'FROM TITULO_RECEBER WHERE CODIGO_CLIENTE = :CODIGO AND SITUACAO = ''A''';
    lQ.ParamByName('CODIGO').AsInteger := pCodigoCliente;
    lQ.Open;
    lAberto := lQ.FieldByName('ABERTO').AsCurrency;

    Result := (lAberto + pValorPrazo) <= lLimite;
  finally
    lQ.Free;
  end;
end;

class function TServicoFinanceiro.DiaCaixaFechado(pTrans: TIBTransaction;
  const pData: TDateTime): Boolean;
var
  lQ: TIBQuery;
begin
  lQ := CriarQuery(pTrans);
  try
    lQ.SQL.Text :=
      'SELECT CODIGO FROM FECHAMENTO_CAIXA ' +
      'WHERE DATA = :DATA AND SITUACAO = ''F''';
    lQ.ParamByName('DATA').AsDateTime := Trunc(pData);
    lQ.Open;
    Result := not lQ.IsEmpty;
  finally
    lQ.Free;
  end;
end;

class procedure TServicoFinanceiro.CarregarProjecaoFluxo(pTrans: TIBTransaction;
  const pDataIni, pDataFim: TDateTime; pDestino: TIBQuery);
begin
  pDestino.Close;
  pDestino.SQL.Clear;
  pDestino.SQL.Add('SELECT DATA_REF, SUM(ENTRADAS) AS ENTRADAS, SUM(SAIDAS) AS SAIDAS,');
  pDestino.SQL.Add('  SUM(ENTRADAS) - SUM(SAIDAS) AS SALDO_DIA');
  pDestino.SQL.Add('FROM (');
  pDestino.SQL.Add('  SELECT M.DATA AS DATA_REF,');
  pDestino.SQL.Add('    CASE WHEN M.TIPO = ''E'' THEN M.VALOR ELSE 0 END AS ENTRADAS,');
  pDestino.SQL.Add('    CASE WHEN M.TIPO = ''S'' THEN M.VALOR ELSE 0 END AS SAIDAS');
  pDestino.SQL.Add('  FROM MOVIMENTO_CAIXA M');
  pDestino.SQL.Add('  WHERE M.DATA BETWEEN :DATA_INI AND :DATA_FIM');
  pDestino.SQL.Add('  UNION ALL');
  pDestino.SQL.Add('  SELECT T.VENCIMENTO, T.VALOR_SALDO, 0');
  pDestino.SQL.Add('  FROM TITULO_RECEBER T');
  pDestino.SQL.Add('  WHERE T.SITUACAO = ''A''');
  pDestino.SQL.Add('    AND T.VENCIMENTO BETWEEN :DATA_INI2 AND :DATA_FIM2');
  pDestino.SQL.Add('  UNION ALL');
  pDestino.SQL.Add('  SELECT P.VENCIMENTO, 0, P.VALOR_SALDO');
  pDestino.SQL.Add('  FROM TITULO_PAGAR P');
  pDestino.SQL.Add('  WHERE P.SITUACAO = ''A''');
  pDestino.SQL.Add('    AND P.VENCIMENTO BETWEEN :DATA_INI3 AND :DATA_FIM3');
  pDestino.SQL.Add(') X');
  pDestino.SQL.Add('GROUP BY DATA_REF');
  pDestino.SQL.Add('ORDER BY DATA_REF');
  pDestino.ParamByName('DATA_INI').AsDateTime := Trunc(pDataIni);
  pDestino.ParamByName('DATA_FIM').AsDateTime := Trunc(pDataFim);
  pDestino.ParamByName('DATA_INI2').AsDateTime := Trunc(pDataIni);
  pDestino.ParamByName('DATA_FIM2').AsDateTime := Trunc(pDataFim);
  pDestino.ParamByName('DATA_INI3').AsDateTime := Trunc(pDataIni);
  pDestino.ParamByName('DATA_FIM3').AsDateTime := Trunc(pDataFim);
  pDestino.Open;
end;

end.
