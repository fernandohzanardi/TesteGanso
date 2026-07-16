unit uVendaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, IBX.IBUpdateSQL, uConexao, uServicoFinanceiro;

type
  TPagamentoLinha = record
    CodigoForma: Integer;
    Valor: Currency;
    Parcelas: Integer;
    Vencimento: TDateTime;
    TemVencimento: Boolean;
  end;

  TfrmVendaPagamento = class(TForm)
    pTopo: TPanel;
    pBotoes: TPanel;
    lTotalVendaCaption: TLabel;
    lTotalVendaValor: TLabel;
    lSomaPagamentosCaption: TLabel;
    lSomaPagamentosValor: TLabel;
    dbgPagamento: TDBGrid;
    btnAdicionar: TButton;
    btnRemover: TButton;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    ibqPagamento: TIBQuery;
    dsPagamento: TDataSource;
    IBUpdateSQLPagamento: TIBUpdateSQL;
    ibqFormas: TIBQuery;
    dsFormas: TDataSource;
    ibqPagamentoCODIGO: TIntegerField;
    ibqPagamentoCODIGO_VENDA: TIntegerField;
    ibqPagamentoCODIGO_FORMA_PAGAMENTO: TIntegerField;
    ibqPagamentoVALOR: TIBBCDField;
    ibqPagamentoPARCELAS: TIntegerField;
    ibqPagamentoVENCIMENTO: TDateField;
    ibqFormasCODIGO: TIntegerField;
    ibqFormasDESCRICAO: TIBStringField;
    ibqFormasGERA_TITULO: TIBStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dsPagamentoDataChange(Sender: TObject; Field: TField);
    procedure ibqPagamentoNewRecord(DataSet: TDataSet);
  private
    FCodigoVenda: Integer;
    FTotalLiquido: Currency;
    FCodigoCliente: Integer;
    FTrans: TIBTransaction;
    procedure ConfigurarConexao;
    procedure AbrirConsultas;
    procedure AtualizarSomaPagamentos;
    function SomaPagamentos: Currency;
    function SomaPrazo: Currency;
    function FormaGeraTitulo(pCodigoForma: Integer): Boolean;
    function ValidarAntesDeGravar: Boolean;
    procedure GravarPagamentos;
    { Private declarations }
  public
    class function Executar(pCodigoVenda: Integer; pTotalLiquido: Currency;
      pCodigoCliente: Integer; pTrans: TIBTransaction): Boolean;
    { Public declarations }
  end;

var
  frmVendaPagamento: TfrmVendaPagamento;

implementation

{$R *.dfm}

const
  CTolerancia = 0.01;

class function TfrmVendaPagamento.Executar(pCodigoVenda: Integer;
  pTotalLiquido: Currency; pCodigoCliente: Integer;
  pTrans: TIBTransaction): Boolean;
begin
  frmVendaPagamento := TfrmVendaPagamento.Create(nil);
  try
    frmVendaPagamento.FCodigoVenda := pCodigoVenda;
    frmVendaPagamento.FTotalLiquido := pTotalLiquido;
    frmVendaPagamento.FCodigoCliente := pCodigoCliente;
    frmVendaPagamento.FTrans := pTrans;
    frmVendaPagamento.ConfigurarConexao;
    Result := frmVendaPagamento.ShowModal = mrOk;
  finally
    frmVendaPagamento.Free;
    frmVendaPagamento := nil;
  end;
end;

procedure TfrmVendaPagamento.ConfigurarConexao;
begin
  ibqPagamento.Database := dmConexao.IBDConexao;
  ibqPagamento.Transaction := FTrans;
  ibqFormas.Database := dmConexao.IBDConexao;
  ibqFormas.Transaction := FTrans;
end;

procedure TfrmVendaPagamento.AbrirConsultas;
begin
  ibqFormas.Close;
  ibqFormas.Open;

  ibqPagamento.Close;
  ibqPagamento.ParamByName('COD').AsInteger := FCodigoVenda;
  ibqPagamento.Open;
end;

procedure TfrmVendaPagamento.FormShow(Sender: TObject);
begin
  lTotalVendaValor.Caption := FormatCurr('#,##0.00', FTotalLiquido);
  try
    AbrirConsultas;
  except
    ShowMessage('Falha ao abrir pagamentos da venda!');
  end;
  AtualizarSomaPagamentos;
end;

procedure TfrmVendaPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not ibqPagamento.Active then
    Exit;

  if ibqPagamento.State in [dsEdit, dsInsert] then
    ibqPagamento.Cancel;
  if ibqPagamento.CachedUpdates and ibqPagamento.UpdatesPending then
    ibqPagamento.CancelUpdates;
end;

procedure TfrmVendaPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
    begin
      ModalResult := mrCancel;
      Key := 0;
    end;
  end;
end;

procedure TfrmVendaPagamento.ibqPagamentoNewRecord(DataSet: TDataSet);
begin
  ibqPagamentoCODIGO_VENDA.AsInteger := FCodigoVenda;
  ibqPagamentoPARCELAS.AsInteger := 1;
  ibqPagamentoVALOR.AsCurrency := 0;
end;

procedure TfrmVendaPagamento.btnAdicionarClick(Sender: TObject);
var
  lRestante: Currency;
begin
  try
    if ibqPagamento.State in [dsEdit, dsInsert] then
      ibqPagamento.Post;

    lRestante := FTotalLiquido - SomaPagamentos;
    if lRestante < 0 then
      lRestante := 0;

    ibqPagamento.Append;
    ibqPagamentoVALOR.AsCurrency := lRestante;
    if not dbgPagamento.Focused then
      dbgPagamento.SetFocus;
  except
    ShowMessage('Falha ao adicionar pagamento!');
  end;
  AtualizarSomaPagamentos;
end;

procedure TfrmVendaPagamento.btnRemoverClick(Sender: TObject);
begin
  if ibqPagamento.IsEmpty then
    Exit;

  if not (MessageDlg('Confirma remocao da linha?', mtConfirmation,
    [mbYes, mbNo], 0, mbYes) = mrYes) then
    Exit;

  try
    if ibqPagamento.State in [dsEdit, dsInsert] then
      ibqPagamento.Cancel;
    ibqPagamento.Delete;
  except
    ShowMessage('Falha ao remover pagamento!');
  end;
  AtualizarSomaPagamentos;
end;

procedure TfrmVendaPagamento.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmVendaPagamento.btnConfirmarClick(Sender: TObject);
begin
  try
    if ibqPagamento.State in [dsEdit, dsInsert] then
      ibqPagamento.Post;
  except
    ShowMessage('Falha ao validar linha de pagamento!');
    Exit;
  end;

  if not ValidarAntesDeGravar then
    Exit;

  try
    GravarPagamentos;
    ModalResult := mrOk;
  except
    ShowMessage('Erro ao gravar pagamentos!');
  end;
end;

procedure TfrmVendaPagamento.dsPagamentoDataChange(Sender: TObject; Field: TField);
begin
  AtualizarSomaPagamentos;
end;

function TfrmVendaPagamento.SomaPagamentos: Currency;
var
  lBook: TBookmark;
begin
  Result := 0;
  if (not ibqPagamento.Active) or ibqPagamento.IsEmpty then
    Exit;

  ibqPagamento.DisableControls;
  lBook := ibqPagamento.GetBookmark;
  try
    ibqPagamento.First;
    while not ibqPagamento.Eof do
    begin
      Result := Result + ibqPagamentoVALOR.AsCurrency;
      ibqPagamento.Next;
    end;
  finally
    if ibqPagamento.BookmarkValid(lBook) then
      ibqPagamento.GotoBookmark(lBook);
    ibqPagamento.FreeBookmark(lBook);
    ibqPagamento.EnableControls;
  end;
end;

function TfrmVendaPagamento.FormaGeraTitulo(pCodigoForma: Integer): Boolean;
begin
  Result := False;
  if pCodigoForma <= 0 then
    Exit;
  if ibqFormas.Locate('CODIGO', pCodigoForma, []) then
    Result := ibqFormasGERA_TITULO.AsString = 'S';
end;

function TfrmVendaPagamento.SomaPrazo: Currency;
var
  lBook: TBookmark;
begin
  Result := 0;
  if (not ibqPagamento.Active) or ibqPagamento.IsEmpty then
    Exit;

  ibqPagamento.DisableControls;
  lBook := ibqPagamento.GetBookmark;
  try
    ibqPagamento.First;
    while not ibqPagamento.Eof do
    begin
      if FormaGeraTitulo(ibqPagamentoCODIGO_FORMA_PAGAMENTO.AsInteger) then
        Result := Result + ibqPagamentoVALOR.AsCurrency;
      ibqPagamento.Next;
    end;
  finally
    if ibqPagamento.BookmarkValid(lBook) then
      ibqPagamento.GotoBookmark(lBook);
    ibqPagamento.FreeBookmark(lBook);
    ibqPagamento.EnableControls;
  end;
end;

procedure TfrmVendaPagamento.AtualizarSomaPagamentos;
begin
  lSomaPagamentosValor.Caption := FormatCurr('#,##0.00', SomaPagamentos);
end;

function TfrmVendaPagamento.ValidarAntesDeGravar: Boolean;
var
  lSoma: Currency;
  lSomaPrazo: Currency;
  lBook: TBookmark;
begin
  Result := False;

  if (not ibqPagamento.Active) or ibqPagamento.IsEmpty then
  begin
    ShowMessage('Informe ao menos um pagamento!');
    Exit;
  end;

  ibqPagamento.DisableControls;
  lBook := ibqPagamento.GetBookmark;
  try
    ibqPagamento.First;
    while not ibqPagamento.Eof do
    begin
      if ibqPagamentoCODIGO_FORMA_PAGAMENTO.AsInteger <= 0 then
      begin
        ShowMessage('Informe a forma de pagamento em todas as linhas!');
        Exit;
      end;
      if ibqPagamentoVALOR.AsCurrency <= 0 then
      begin
        ShowMessage('Valor do pagamento deve ser maior que zero!');
        Exit;
      end;
      if ibqPagamentoPARCELAS.AsInteger < 1 then
      begin
        ShowMessage('Parcelas deve ser maior ou igual a 1!');
        Exit;
      end;
      if not ibqFormas.Locate('CODIGO',
        ibqPagamentoCODIGO_FORMA_PAGAMENTO.AsInteger, []) then
      begin
        ShowMessage('Forma de pagamento invalida ou inativa!');
        Exit;
      end;
      ibqPagamento.Next;
    end;
  finally
    if ibqPagamento.BookmarkValid(lBook) then
      ibqPagamento.GotoBookmark(lBook);
    ibqPagamento.FreeBookmark(lBook);
    ibqPagamento.EnableControls;
  end;

  lSoma := SomaPagamentos;
  if Abs(lSoma - FTotalLiquido) > CTolerancia then
  begin
    ShowMessage('Soma dos pagamentos deve igualar o total liquido da venda!');
    Exit;
  end;

  lSomaPrazo := SomaPrazo;
  if lSomaPrazo > 0 then
  begin
    if not TServicoFinanceiro.ValidarLimiteCredito(FTrans, FCodigoCliente,
      lSomaPrazo) then
    begin
      ShowMessage('Cliente sem limite de credito suficiente para o valor a prazo!');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmVendaPagamento.GravarPagamentos;
var
  lLinhas: array of TPagamentoLinha;
  lQ: TIBQuery;
  lCount: Integer;
  lI: Integer;
  lBook: TBookmark;
begin
  SetLength(lLinhas, 0);
  lCount := 0;

  ibqPagamento.DisableControls;
  lBook := ibqPagamento.GetBookmark;
  try
    ibqPagamento.First;
    while not ibqPagamento.Eof do
    begin
      Inc(lCount);
      SetLength(lLinhas, lCount);
      lLinhas[lCount - 1].CodigoForma :=
        ibqPagamentoCODIGO_FORMA_PAGAMENTO.AsInteger;
      lLinhas[lCount - 1].Valor := ibqPagamentoVALOR.AsCurrency;
      lLinhas[lCount - 1].Parcelas := ibqPagamentoPARCELAS.AsInteger;
      lLinhas[lCount - 1].TemVencimento := not ibqPagamentoVENCIMENTO.IsNull;
      if lLinhas[lCount - 1].TemVencimento then
        lLinhas[lCount - 1].Vencimento := ibqPagamentoVENCIMENTO.AsDateTime;
      ibqPagamento.Next;
    end;
  finally
    if ibqPagamento.BookmarkValid(lBook) then
      ibqPagamento.GotoBookmark(lBook);
    ibqPagamento.FreeBookmark(lBook);
    ibqPagamento.EnableControls;
  end;

  if ibqPagamento.CachedUpdates then
    ibqPagamento.CancelUpdates;

  ibqPagamento.Close;

  lQ := TIBQuery.Create(nil);
  try
    lQ.Database := dmConexao.IBDConexao;
    lQ.Transaction := FTrans;

    lQ.SQL.Text :=
      'DELETE FROM VENDA_PAGAMENTO WHERE CODIGO_VENDA = :CODIGO_VENDA';
    lQ.ParamByName('CODIGO_VENDA').AsInteger := FCodigoVenda;
    lQ.ExecSQL;

    lQ.SQL.Text :=
      'INSERT INTO VENDA_PAGAMENTO ' +
      '  (CODIGO_VENDA, CODIGO_FORMA_PAGAMENTO, VALOR, PARCELAS, VENCIMENTO) ' +
      'VALUES ' +
      '  (:CODIGO_VENDA, :CODIGO_FORMA_PAGAMENTO, :VALOR, :PARCELAS, :VENCIMENTO)';

    for lI := 0 to lCount - 1 do
    begin
      lQ.ParamByName('CODIGO_VENDA').AsInteger := FCodigoVenda;
      lQ.ParamByName('CODIGO_FORMA_PAGAMENTO').AsInteger :=
        lLinhas[lI].CodigoForma;
      lQ.ParamByName('VALOR').AsCurrency := lLinhas[lI].Valor;
      lQ.ParamByName('PARCELAS').AsInteger := lLinhas[lI].Parcelas;
      if lLinhas[lI].TemVencimento then
        lQ.ParamByName('VENCIMENTO').AsDateTime := lLinhas[lI].Vencimento
      else
        lQ.ParamByName('VENCIMENTO').Clear;
      lQ.ExecSQL;
    end;
  finally
    lQ.Free;
  end;
end;

end.
