unit uFechamentoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet;

type
  TfrmFechamentoCaixa = class(TForm)
    pTopo: TPanel;
    pRodape: TPanel;
    lData: TLabel;
    lObservacao: TLabel;
    lSaldoDia: TLabel;
    dtpData: TDateTimePicker;
    btnCalcular: TButton;
    btnFecharCaixa: TButton;
    btnFechar: TButton;
    eObservacao: TEdit;
    eSaldoDia: TEdit;
    dbgItens: TDBGrid;
    dsItens: TDataSource;
    cdsItens: TClientDataSet;
    cdsItensCODIGO_FORMA: TIntegerField;
    cdsItensDESCRICAO: TStringField;
    cdsItensVALOR_SISTEMA: TCurrencyField;
    cdsItensVALOR_INFORMADO: TCurrencyField;
    cdsItensDIFERENCA: TCurrencyField;
    IBTransactionFec: TIBTransaction;
    ibqAux: TIBQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCalcularClick(Sender: TObject);
    procedure btnFecharCaixaClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure cdsItensVALOR_INFORMADOChange(Sender: TField);
  strict private
    procedure GarantirCds;
    function ExisteFechamento: Boolean;
  public
    { Public declarations }
  end;

var
  frmFechamentoCaixa: TfrmFechamentoCaixa;

implementation

{$R *.dfm}

uses
  uConexao, uServicoFinanceiro;

procedure TfrmFechamentoCaixa.FormActivate(Sender: TObject);
begin
  if dtpData.Tag = 0 then
  begin
    dtpData.Date := Date;
    GarantirCds;
    dtpData.Tag := 1;
  end;
end;

procedure TfrmFechamentoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmFechamentoCaixa := Nil;
end;

procedure TfrmFechamentoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure TfrmFechamentoCaixa.GarantirCds;
begin
  if not cdsItens.Active then
    cdsItens.CreateDataSet;
end;

procedure TfrmFechamentoCaixa.cdsItensVALOR_INFORMADOChange(Sender: TField);
begin
  cdsItensDIFERENCA.ReadOnly := False;
  try
    cdsItensDIFERENCA.AsCurrency :=
      cdsItensVALOR_INFORMADO.AsCurrency - cdsItensVALOR_SISTEMA.AsCurrency;
  finally
    cdsItensDIFERENCA.ReadOnly := True;
  end;
end;

function TfrmFechamentoCaixa.ExisteFechamento: Boolean;
begin
  if not IBTransactionFec.InTransaction then
    IBTransactionFec.StartTransaction;
  Result := TServicoFinanceiro.DiaCaixaFechado(IBTransactionFec, dtpData.Date);
end;

procedure TfrmFechamentoCaixa.btnCalcularClick(Sender: TObject);
var
  lSaldo: Currency;
begin
  GarantirCds;
  if not IBTransactionFec.InTransaction then
    IBTransactionFec.StartTransaction;

  try
    TServicoFinanceiro.CalcularSaldoPorForma(IBTransactionFec, dtpData.Date, ibqAux);
    lSaldo := TServicoFinanceiro.CalcularSaldoDia(IBTransactionFec, dtpData.Date);
    eSaldoDia.Text := FormatFloat('#,##0.00', lSaldo);

    cdsItens.EmptyDataSet;
    ibqAux.First;
    while not ibqAux.Eof do
    begin
      cdsItens.Append;
      cdsItensCODIGO_FORMA.AsInteger := ibqAux.FieldByName('CODIGO').AsInteger;
      cdsItensDESCRICAO.AsString := ibqAux.FieldByName('DESCRICAO').AsString;
      cdsItensVALOR_SISTEMA.AsCurrency := ibqAux.FieldByName('SALDO').AsCurrency;
      cdsItensVALOR_INFORMADO.AsCurrency := ibqAux.FieldByName('SALDO').AsCurrency;
      cdsItensDIFERENCA.AsCurrency := 0;
      cdsItens.Post;
      ibqAux.Next;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao calcular: ' + E.Message);
  end;
end;

procedure TfrmFechamentoCaixa.btnFecharCaixaClick(Sender: TObject);
var
  lSaldoSis, lSaldoInf, lDif: Currency;
  lCodFec: Integer;
  lQ: TIBQuery;
begin
  if not cdsItens.Active or cdsItens.IsEmpty then
  begin
    ShowMessage('Calcule o saldo antes de fechar!');
    Exit;
  end;

  if ExisteFechamento then
  begin
    ShowMessage('Ja existe fechamento para esta data!');
    Exit;
  end;

  lSaldoSis := 0;
  lSaldoInf := 0;
  cdsItens.DisableControls;
  try
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      lSaldoSis := lSaldoSis + cdsItensVALOR_SISTEMA.AsCurrency;
      lSaldoInf := lSaldoInf + cdsItensVALOR_INFORMADO.AsCurrency;
      cdsItens.Next;
    end;
    cdsItens.First;
  finally
    cdsItens.EnableControls;
  end;

  lDif := lSaldoInf - lSaldoSis;
  if (lDif <> 0) and (Trim(eObservacao.Text) = '') then
  begin
    ShowMessage('Diferenca diferente de zero exige observacao!');
    Exit;
  end;

  if MessageDlg('Confirma fechamento do caixa?', mtConfirmation,
    [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not IBTransactionFec.InTransaction then
    IBTransactionFec.StartTransaction;

  lQ := TIBQuery.Create(nil);
  try
    try
      lQ.Database := dmConexao.IBDConexao;
      lQ.Transaction := IBTransactionFec;
      lQ.SQL.Text :=
        'INSERT INTO FECHAMENTO_CAIXA ' +
        '  (DATA, SALDO_SISTEMA, SALDO_INFORMADO, DIFERENCA, OBSERVACAO, SITUACAO) ' +
        'VALUES ' +
        '  (:DATA, :SALDO_SISTEMA, :SALDO_INFORMADO, :DIFERENCA, :OBSERVACAO, ''F'')';
      lQ.ParamByName('DATA').AsDateTime := Trunc(dtpData.Date);
      lQ.ParamByName('SALDO_SISTEMA').AsCurrency := lSaldoSis;
      lQ.ParamByName('SALDO_INFORMADO').AsCurrency := lSaldoInf;
      lQ.ParamByName('DIFERENCA').AsCurrency := lDif;
      lQ.ParamByName('OBSERVACAO').AsString := Copy(Trim(eObservacao.Text), 1, 200);
      lQ.ExecSQL;

      lQ.Close;
      lQ.SQL.Text := 'SELECT GEN_ID(GEN_FECHAMENTO_CAIXA_ID, 0) AS COD FROM RDB$DATABASE';
      lQ.Open;
      lCodFec := lQ.FieldByName('COD').AsInteger;

      cdsItens.First;
      while not cdsItens.Eof do
      begin
        lQ.Close;
        lQ.SQL.Text :=
          'INSERT INTO FECHAMENTO_CAIXA_ITEM ' +
          '  (CODIGO_FECHAMENTO, CODIGO_FORMA_PAGAMENTO, ' +
          '   VALOR_SISTEMA, VALOR_INFORMADO, DIFERENCA) ' +
          'VALUES ' +
          '  (:CODIGO_FECHAMENTO, :CODIGO_FORMA_PAGAMENTO, ' +
          '   :VALOR_SISTEMA, :VALOR_INFORMADO, :DIFERENCA)';
        lQ.ParamByName('CODIGO_FECHAMENTO').AsInteger := lCodFec;
        lQ.ParamByName('CODIGO_FORMA_PAGAMENTO').AsInteger := cdsItensCODIGO_FORMA.AsInteger;
        lQ.ParamByName('VALOR_SISTEMA').AsCurrency := cdsItensVALOR_SISTEMA.AsCurrency;
        lQ.ParamByName('VALOR_INFORMADO').AsCurrency := cdsItensVALOR_INFORMADO.AsCurrency;
        lQ.ParamByName('DIFERENCA').AsCurrency := cdsItensDIFERENCA.AsCurrency;
        lQ.ExecSQL;
        cdsItens.Next;
      end;

      IBTransactionFec.CommitRetaining;
      ShowMessage('Caixa fechado com sucesso!');
    except
      on E: Exception do
      begin
        IBTransactionFec.RollbackRetaining;
        ShowMessage('Erro ao fechar caixa: ' + E.Message);
      end;
    end;
  finally
    lQ.Free;
  end;
end;

procedure TfrmFechamentoCaixa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
