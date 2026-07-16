unit uContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask, Data.DB,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet, IBX.IBUpdateSQL;

type
  TfrmContasPagar = class(TForm)
    pFiltros: TPanel;
    pEdicao: TPanel;
    pBotoes: TPanel;
    lPeriodo: TLabel;
    lAte: TLabel;
    lSituacao: TLabel;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    cbSituacao: TComboBox;
    btnConsultar: TButton;
    dbgTitulos: TDBGrid;
    lFornecedor: TLabel;
    lCentroCusto: TLabel;
    lDescricao: TLabel;
    lVencimento: TLabel;
    lValor: TLabel;
    lSaldo: TLabel;
    lSit: TLabel;
    lNomeFornecedor: TLabel;
    lNomeCentroCusto: TLabel;
    dbeCodigoFornecedor: TDBEdit;
    dbeCodigoCentroCusto: TDBEdit;
    dbeDescricao: TDBEdit;
    dbeVencimento: TDBEdit;
    dbeValor: TDBEdit;
    dbeSaldo: TDBEdit;
    dbeSituacao: TDBEdit;
    btnInserir: TButton;
    btnEditar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnBaixar: TButton;
    btnFechar: TButton;
    dsTitulos: TDataSource;
    IBTransactionPag: TIBTransaction;
    ibqTitulos: TIBQuery;
    IBUpdateSQLPag: TIBUpdateSQL;
    ibqTitulosCODIGO: TIntegerField;
    ibqTitulosCODIGO_FORNECEDOR: TIntegerField;
    ibqTitulosNOME_FORNECEDOR: TIBStringField;
    ibqTitulosCODIGO_CENTRO_CUSTO: TIntegerField;
    ibqTitulosNOME_CENTRO_CUSTO: TIBStringField;
    ibqTitulosDESCRICAO: TIBStringField;
    ibqTitulosVENCIMENTO: TDateField;
    ibqTitulosVALOR: TIBBCDField;
    ibqTitulosVALOR_SALDO: TIBBCDField;
    ibqTitulosSITUACAO: TIBStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure dsTitulosDataChange(Sender: TObject; Field: TField);
    procedure dbeCodigoFornecedorExit(Sender: TObject);
    procedure dbeCodigoCentroCustoExit(Sender: TObject);
  strict private
    procedure MontarSQL;
    procedure HabilitaBotoes;
    procedure AtualizarLookups;
    function BuscarNome(const pTabela, pCampoNome: string; pCodigo: Integer): string;
    function ValidarAntesGravar: Boolean;
    function GetSituacaoFiltro: string;
  public
    { Public declarations }
  end;

var
  frmContasPagar: TfrmContasPagar;

implementation

{$R *.dfm}

uses
  System.DateUtils, uConexao, uServicoFinanceiro;

procedure TfrmContasPagar.FormActivate(Sender: TObject);
begin
  if dtpDataInicial.Tag = 0 then
  begin
    dtpDataInicial.Date := StartOfTheMonth(Date);
    dtpDataFinal.Date := Date;
    cbSituacao.Items.Clear;
    cbSituacao.Items.Add('Todos');
    cbSituacao.Items.Add('A - Aberto');
    cbSituacao.Items.Add('Q - Quitado');
    cbSituacao.Items.Add('C - Cancelado');
    cbSituacao.ItemIndex := 1;
    dtpDataInicial.Tag := 1;
  end;
  MontarSQL;
  HabilitaBotoes;
end;

procedure TfrmContasPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmContasPagar := Nil;
end;

procedure TfrmContasPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F5: btnConsultar.Click;
  end;
end;

function TfrmContasPagar.GetSituacaoFiltro: string;
begin
  case cbSituacao.ItemIndex of
    1: Result := 'A';
    2: Result := 'Q';
    3: Result := 'C';
  else
    Result := '';
  end;
end;

function TfrmContasPagar.BuscarNome(const pTabela, pCampoNome: string;
  pCodigo: Integer): string;
var
  lQ: TIBQuery;
begin
  Result := '';
  if pCodigo <= 0 then
    Exit;
  lQ := TIBQuery.Create(nil);
  try
    lQ.Database := dmConexao.IBDConexao;
    lQ.Transaction := IBTransactionPag;
    lQ.SQL.Text := Format('SELECT %s AS NOME FROM %s WHERE CODIGO = :CODIGO',
      [pCampoNome, pTabela]);
    lQ.ParamByName('CODIGO').AsInteger := pCodigo;
    lQ.Open;
    if not lQ.IsEmpty then
      Result := lQ.FieldByName('NOME').AsString;
  finally
    lQ.Free;
  end;
end;

procedure TfrmContasPagar.AtualizarLookups;
begin
  if ibqTitulos.Active and (not ibqTitulos.IsEmpty) then
  begin
    lNomeFornecedor.Caption := BuscarNome('FORNECEDOR', 'NOME',
      ibqTitulosCODIGO_FORNECEDOR.AsInteger);
    lNomeCentroCusto.Caption := BuscarNome('CENTRO_CUSTO', 'DESCRICAO',
      ibqTitulosCODIGO_CENTRO_CUSTO.AsInteger);
  end
  else
  begin
    lNomeFornecedor.Caption := '';
    lNomeCentroCusto.Caption := '';
  end;
end;

procedure TfrmContasPagar.MontarSQL;
var
  lSQL: TStringList;
  lSit: string;
begin
  lSQL := TStringList.Create;
  try
    lSQL.Add('SELECT T.CODIGO, T.CODIGO_FORNECEDOR, F.NOME AS NOME_FORNECEDOR,');
    lSQL.Add('       T.CODIGO_CENTRO_CUSTO, CC.DESCRICAO AS NOME_CENTRO_CUSTO,');
    lSQL.Add('       T.DESCRICAO, T.VENCIMENTO, T.VALOR, T.VALOR_SALDO, T.SITUACAO');
    lSQL.Add('FROM TITULO_PAGAR T');
    lSQL.Add('JOIN FORNECEDOR F ON F.CODIGO = T.CODIGO_FORNECEDOR');
    lSQL.Add('JOIN CENTRO_CUSTO CC ON CC.CODIGO = T.CODIGO_CENTRO_CUSTO');
    lSQL.Add('WHERE T.VENCIMENTO BETWEEN :DATA_INICIAL AND :DATA_FINAL');

    lSit := GetSituacaoFiltro;
    if lSit <> '' then
      lSQL.Add('  AND T.SITUACAO = :SITUACAO');
    lSQL.Add('ORDER BY T.VENCIMENTO, T.CODIGO');

    ibqTitulos.Close;
    ibqTitulos.SQL.Assign(lSQL);
    ibqTitulos.ParamByName('DATA_INICIAL').AsDateTime := DateOf(dtpDataInicial.DateTime);
    ibqTitulos.ParamByName('DATA_FINAL').AsDateTime := DateOf(dtpDataFinal.DateTime);
    if lSit <> '' then
      ibqTitulos.ParamByName('SITUACAO').AsString := lSit;

    try
      ibqTitulos.Open;
    except
      on E: Exception do
        ShowMessage('Erro ao consultar: ' + E.Message);
    end;
  finally
    lSQL.Free;
  end;
end;

procedure TfrmContasPagar.HabilitaBotoes;
var
  lEditando: Boolean;
begin
  lEditando := ibqTitulos.State in [dsInsert, dsEdit];
  btnInserir.Enabled := not lEditando;
  btnEditar.Enabled := (not lEditando) and (not ibqTitulos.IsEmpty) and
    (ibqTitulosSITUACAO.AsString = 'A');
  btnExcluir.Enabled := (not lEditando) and (not ibqTitulos.IsEmpty) and
    (ibqTitulosSITUACAO.AsString = 'A');
  btnBaixar.Enabled := (not lEditando) and (not ibqTitulos.IsEmpty) and
    (ibqTitulosSITUACAO.AsString = 'A');
  btnGravar.Enabled := lEditando;
  btnCancelar.Enabled := lEditando;
  btnConsultar.Enabled := not lEditando;
  dbgTitulos.Enabled := not lEditando;
  pFiltros.Enabled := not lEditando;
  dbeSaldo.ReadOnly := True;
  dbeSituacao.ReadOnly := True;
end;

function TfrmContasPagar.ValidarAntesGravar: Boolean;
begin
  Result := False;
  if (ibqTitulosCODIGO_FORNECEDOR.IsNull) or
     (ibqTitulosCODIGO_FORNECEDOR.AsInteger <= 0) then
  begin
    ShowMessage('Informe o fornecedor!');
    Exit;
  end;
  if (ibqTitulosCODIGO_CENTRO_CUSTO.IsNull) or
     (ibqTitulosCODIGO_CENTRO_CUSTO.AsInteger <= 0) then
  begin
    ShowMessage('Centro de custo obrigatorio!');
    Exit;
  end;
  if ibqTitulosVENCIMENTO.IsNull then
  begin
    ShowMessage('Informe o vencimento!');
    Exit;
  end;
  if ibqTitulosVALOR.AsCurrency <= 0 then
  begin
    ShowMessage('Informe um valor maior que zero!');
    Exit;
  end;
  Result := True;
end;

procedure TfrmContasPagar.dsTitulosDataChange(Sender: TObject; Field: TField);
begin
  HabilitaBotoes;
  if Field = nil then
    AtualizarLookups;
end;

procedure TfrmContasPagar.dbeCodigoFornecedorExit(Sender: TObject);
begin
  if ibqTitulos.State in [dsInsert, dsEdit] then
    lNomeFornecedor.Caption := BuscarNome('FORNECEDOR', 'NOME',
      StrToIntDef(dbeCodigoFornecedor.Text, 0));
end;

procedure TfrmContasPagar.dbeCodigoCentroCustoExit(Sender: TObject);
begin
  if ibqTitulos.State in [dsInsert, dsEdit] then
    lNomeCentroCusto.Caption := BuscarNome('CENTRO_CUSTO', 'DESCRICAO',
      StrToIntDef(dbeCodigoCentroCusto.Text, 0));
end;

procedure TfrmContasPagar.btnConsultarClick(Sender: TObject);
begin
  MontarSQL;
  HabilitaBotoes;
end;

procedure TfrmContasPagar.btnInserirClick(Sender: TObject);
begin
  try
    ibqTitulos.Append;
    ibqTitulosVENCIMENTO.AsDateTime := Date;
    ibqTitulosVALOR.AsCurrency := 0;
    ibqTitulosVALOR_SALDO.AsCurrency := 0;
    ibqTitulosSITUACAO.AsString := 'A';
    HabilitaBotoes;
    if dbeCodigoFornecedor.CanFocus then
      dbeCodigoFornecedor.SetFocus;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmContasPagar.btnEditarClick(Sender: TObject);
begin
  if ibqTitulos.IsEmpty then
    Exit;
  if ibqTitulosSITUACAO.AsString <> 'A' then
  begin
    ShowMessage('Somente titulos abertos podem ser editados!');
    Exit;
  end;
  try
    ibqTitulos.Edit;
    HabilitaBotoes;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmContasPagar.btnGravarClick(Sender: TObject);
begin
  if not ValidarAntesGravar then
    Exit;

  if not IBTransactionPag.InTransaction then
    IBTransactionPag.StartTransaction;

  try
    if ibqTitulos.State = dsInsert then
    begin
      ibqTitulosVALOR_SALDO.AsCurrency := ibqTitulosVALOR.AsCurrency;
      ibqTitulosSITUACAO.AsString := 'A';
    end;
    ibqTitulos.UpdateRecord;
    if ibqTitulos.State in [dsInsert, dsEdit] then
      ibqTitulos.Post;
    IBTransactionPag.CommitRetaining;
    MontarSQL;
    HabilitaBotoes;
  except
    IBTransactionPag.RollbackRetaining;
    ShowMessage('Erro ao salvar!');
  end;
end;

procedure TfrmContasPagar.btnCancelarClick(Sender: TObject);
begin
  try
    if ibqTitulos.State in [dsInsert, dsEdit] then
      ibqTitulos.Cancel;
    HabilitaBotoes;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmContasPagar.btnExcluirClick(Sender: TObject);
begin
  if ibqTitulos.IsEmpty then
    Exit;
  if ibqTitulosSITUACAO.AsString <> 'A' then
  begin
    ShowMessage('Somente titulos abertos podem ser excluidos!');
    Exit;
  end;
  if MessageDlg('Confirma exclusao?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not IBTransactionPag.InTransaction then
    IBTransactionPag.StartTransaction;

  try
    ibqTitulos.Delete;
    IBTransactionPag.CommitRetaining;
    HabilitaBotoes;
  except
    IBTransactionPag.RollbackRetaining;
    ShowMessage('Erro ao excluir!');
  end;
end;

procedure TfrmContasPagar.btnBaixarClick(Sender: TObject);
var
  lValorStr: string;
  lValor: Currency;
begin
  if ibqTitulos.IsEmpty then
    Exit;
  if ibqTitulosSITUACAO.AsString <> 'A' then
  begin
    ShowMessage('Titulo nao esta em aberto!');
    Exit;
  end;

  lValorStr := FormatFloat('0.00', ibqTitulosVALOR_SALDO.AsCurrency);
  if not InputQuery('Baixa titulo a pagar', 'Valor da baixa:', lValorStr) then
    Exit;

  lValor := StrToCurrDef(StringReplace(lValorStr, '.', '', [rfReplaceAll]), 0);
  if lValor <= 0 then
  begin
    ShowMessage('Valor invalido!');
    Exit;
  end;

  if not IBTransactionPag.InTransaction then
    IBTransactionPag.StartTransaction;

  try
    TServicoFinanceiro.BaixarTituloPagar(IBTransactionPag,
      ibqTitulosCODIGO.AsInteger, Date, lValor, 1, 1);
    IBTransactionPag.CommitRetaining;
    ShowMessage('Baixa realizada com sucesso!');
    MontarSQL;
    HabilitaBotoes;
  except
    on E: Exception do
    begin
      IBTransactionPag.RollbackRetaining;
      ShowMessage('Erro ao baixar: ' + E.Message);
    end;
  end;
end;

procedure TfrmContasPagar.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
