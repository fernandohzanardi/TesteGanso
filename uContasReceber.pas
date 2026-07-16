unit uContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet;

type
  TfrmContasReceber = class(TForm)
    pFiltros: TPanel;
    pRodape: TPanel;
    lPeriodo: TLabel;
    lAte: TLabel;
    lSituacao: TLabel;
    lCliente: TLabel;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    cbSituacao: TComboBox;
    eCodigoCliente: TEdit;
    btnConsultar: TButton;
    btnBaixar: TButton;
    btnFechar: TButton;
    dbgTitulos: TDBGrid;
    dsTitulos: TDataSource;
    IBTransactionRec: TIBTransaction;
    ibqTitulos: TIBQuery;
    ibqTitulosCODIGO: TIntegerField;
    ibqTitulosNOME_CLIENTE: TIBStringField;
    ibqTitulosCODIGO_VENDA: TIntegerField;
    ibqTitulosPARCELA: TIntegerField;
    ibqTitulosVENCIMENTO: TDateField;
    ibqTitulosVALOR: TIBBCDField;
    ibqTitulosVALOR_SALDO: TIBBCDField;
    ibqTitulosSITUACAO: TIBStringField;
    ibqTitulosFORMA: TIBStringField;
    ibqTitulosCODIGO_CLIENTE: TIntegerField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  strict private
    procedure MontarSQL;
    function GetSituacaoFiltro: string;
  public
    { Public declarations }
  end;

var
  frmContasReceber: TfrmContasReceber;

implementation

{$R *.dfm}

uses
  System.DateUtils, uConexao, uServicoFinanceiro;

procedure TfrmContasReceber.FormActivate(Sender: TObject);
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
end;

procedure TfrmContasReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmContasReceber := Nil;
end;

procedure TfrmContasReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F5: btnConsultar.Click;
  end;
end;

function TfrmContasReceber.GetSituacaoFiltro: string;
begin
  case cbSituacao.ItemIndex of
    1: Result := 'A';
    2: Result := 'Q';
    3: Result := 'C';
  else
    Result := '';
  end;
end;

procedure TfrmContasReceber.MontarSQL;
var
  lSQL: TStringList;
  lSit: string;
begin
  lSQL := TStringList.Create;
  try
    lSQL.Add('SELECT T.CODIGO, C.NOME AS NOME_CLIENTE, T.CODIGO_VENDA,');
    lSQL.Add('       T.PARCELA, T.VENCIMENTO, T.VALOR, T.VALOR_SALDO,');
    lSQL.Add('       T.SITUACAO, FP.DESCRICAO AS FORMA, T.CODIGO_CLIENTE');
    lSQL.Add('FROM TITULO_RECEBER T');
    lSQL.Add('JOIN CLIENTE C ON C.CODIGO = T.CODIGO_CLIENTE');
    lSQL.Add('LEFT JOIN FORMA_PAGAMENTO FP ON FP.CODIGO = T.CODIGO_FORMA_PAGAMENTO');
    lSQL.Add('WHERE T.VENCIMENTO BETWEEN :DATA_INICIAL AND :DATA_FINAL');

    lSit := GetSituacaoFiltro;
    if lSit <> '' then
      lSQL.Add('  AND T.SITUACAO = :SITUACAO');
    if Trim(eCodigoCliente.Text) <> '' then
      lSQL.Add('  AND T.CODIGO_CLIENTE = :CODIGO_CLIENTE');
    lSQL.Add('ORDER BY T.VENCIMENTO, T.CODIGO');

    ibqTitulos.Close;
    ibqTitulos.SQL.Assign(lSQL);
    ibqTitulos.ParamByName('DATA_INICIAL').AsDateTime := DateOf(dtpDataInicial.DateTime);
    ibqTitulos.ParamByName('DATA_FINAL').AsDateTime := DateOf(dtpDataFinal.DateTime);
    if lSit <> '' then
      ibqTitulos.ParamByName('SITUACAO').AsString := lSit;
    if Trim(eCodigoCliente.Text) <> '' then
      ibqTitulos.ParamByName('CODIGO_CLIENTE').AsInteger :=
        StrToIntDef(Trim(eCodigoCliente.Text), 0);

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

procedure TfrmContasReceber.btnConsultarClick(Sender: TObject);
begin
  MontarSQL;
end;

procedure TfrmContasReceber.btnBaixarClick(Sender: TObject);
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
  if not InputQuery('Baixa titulo a receber', 'Valor da baixa:', lValorStr) then
    Exit;

  lValor := StrToCurrDef(StringReplace(lValorStr, '.', '', [rfReplaceAll]), 0);
  if lValor <= 0 then
  begin
    ShowMessage('Valor invalido!');
    Exit;
  end;

  if not IBTransactionRec.InTransaction then
    IBTransactionRec.StartTransaction;

  try
    TServicoFinanceiro.BaixarTituloReceber(IBTransactionRec,
      ibqTitulosCODIGO.AsInteger, Date, lValor, 1, 1);
    IBTransactionRec.CommitRetaining;
    ShowMessage('Baixa realizada com sucesso!');
    MontarSQL;
  except
    on E: Exception do
    begin
      IBTransactionRec.RollbackRetaining;
      ShowMessage('Erro ao baixar: ' + E.Message);
    end;
  end;
end;

procedure TfrmContasReceber.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
