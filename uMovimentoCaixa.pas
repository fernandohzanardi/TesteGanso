unit uMovimentoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask, Data.DB,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet, IBX.IBUpdateSQL;

type
  TfrmMovimentoCaixa = class(TForm)
    pFiltros: TPanel;
    pEdicao: TPanel;
    pBotoes: TPanel;
    lPeriodo: TLabel;
    lAte: TLabel;
    lTipoFiltro: TLabel;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    cbTipoFiltro: TComboBox;
    btnConsultar: TButton;
    dbgMovimento: TDBGrid;
    lData: TLabel;
    lTipo: TLabel;
    lValor: TLabel;
    lHistorico: TLabel;
    lForma: TLabel;
    lConta: TLabel;
    lCentroCusto: TLabel;
    dbeData: TDBEdit;
    dbcTipo: TDBComboBox;
    dbeValor: TDBEdit;
    dbeHistorico: TDBEdit;
    dbeCodigoForma: TDBEdit;
    dbeCodigoConta: TDBEdit;
    dbeCodigoCentroCusto: TDBEdit;
    btnInserir: TButton;
    btnEditar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    btnExcluir: TButton;
    btnFechar: TButton;
    dsMovimento: TDataSource;
    IBTransactionMov: TIBTransaction;
    ibqMovimento: TIBQuery;
    IBUpdateSQLMov: TIBUpdateSQL;
    ibqMovimentoCODIGO: TIntegerField;
    ibqMovimentoDATA: TDateField;
    ibqMovimentoTIPO: TIBStringField;
    ibqMovimentoVALOR: TIBBCDField;
    ibqMovimentoHISTORICO: TIBStringField;
    ibqMovimentoCODIGO_FORMA_PAGAMENTO: TIntegerField;
    ibqMovimentoCODIGO_CONTA: TIntegerField;
    ibqMovimentoCODIGO_CENTRO_CUSTO: TIntegerField;
    ibqMovimentoORIGEM: TIBStringField;
    ibqMovimentoCODIGO_ORIGEM: TIntegerField;
    ibqMovimentoCONCILIADO: TIBStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure dsMovimentoDataChange(Sender: TObject; Field: TField);
  strict private
    procedure MontarSQL;
    procedure HabilitaBotoes;
    function ValidarAntesGravar: Boolean;
    function DiaBloqueado(const pData: TDateTime): Boolean;
  public
    { Public declarations }
  end;

var
  frmMovimentoCaixa: TfrmMovimentoCaixa;

implementation

{$R *.dfm}

uses
  System.DateUtils, uConexao, uServicoFinanceiro;

procedure TfrmMovimentoCaixa.FormActivate(Sender: TObject);
begin
  if dtpDataInicial.Tag = 0 then
  begin
    dtpDataInicial.Date := StartOfTheMonth(Date);
    dtpDataFinal.Date := Date;
    cbTipoFiltro.Items.Clear;
    cbTipoFiltro.Items.Add('Todos');
    cbTipoFiltro.Items.Add('E - Entrada');
    cbTipoFiltro.Items.Add('S - Saida');
    cbTipoFiltro.ItemIndex := 0;
    dtpDataInicial.Tag := 1;
  end;
  MontarSQL;
  HabilitaBotoes;
end;

procedure TfrmMovimentoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmMovimentoCaixa := Nil;
end;

procedure TfrmMovimentoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F5: btnConsultar.Click;
  end;
end;

procedure TfrmMovimentoCaixa.MontarSQL;
var
  lSQL: TStringList;
begin
  lSQL := TStringList.Create;
  try
    lSQL.Add('SELECT CODIGO, DATA, TIPO, VALOR, HISTORICO,');
    lSQL.Add('       CODIGO_FORMA_PAGAMENTO, CODIGO_CONTA,');
    lSQL.Add('       CODIGO_CENTRO_CUSTO, ORIGEM, CODIGO_ORIGEM, CONCILIADO');
    lSQL.Add('FROM MOVIMENTO_CAIXA');
    lSQL.Add('WHERE DATA BETWEEN :DATA_INICIAL AND :DATA_FINAL');
    case cbTipoFiltro.ItemIndex of
      1: lSQL.Add('  AND TIPO = ''E''');
      2: lSQL.Add('  AND TIPO = ''S''');
    end;
    lSQL.Add('ORDER BY DATA, CODIGO');

    ibqMovimento.Close;
    ibqMovimento.SQL.Assign(lSQL);
    ibqMovimento.ParamByName('DATA_INICIAL').AsDateTime := DateOf(dtpDataInicial.DateTime);
    ibqMovimento.ParamByName('DATA_FINAL').AsDateTime := DateOf(dtpDataFinal.DateTime);
    try
      ibqMovimento.Open;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao consultar: ' + E.Message);
        Exit;
      end;
    end;
  finally
    lSQL.Free;
  end;
end;

procedure TfrmMovimentoCaixa.HabilitaBotoes;
var
  lEditando: Boolean;
begin
  lEditando := ibqMovimento.State in [dsInsert, dsEdit];
  btnInserir.Enabled := not lEditando;
  btnEditar.Enabled := (not lEditando) and (not ibqMovimento.IsEmpty);
  btnExcluir.Enabled := (not lEditando) and (not ibqMovimento.IsEmpty);
  btnGravar.Enabled := lEditando;
  btnCancelar.Enabled := lEditando;
  btnConsultar.Enabled := not lEditando;
  dbgMovimento.Enabled := not lEditando;
  pFiltros.Enabled := not lEditando;
end;

function TfrmMovimentoCaixa.DiaBloqueado(const pData: TDateTime): Boolean;
begin
  if not IBTransactionMov.InTransaction then
    IBTransactionMov.StartTransaction;
  Result := TServicoFinanceiro.DiaCaixaFechado(IBTransactionMov, pData);
end;

function TfrmMovimentoCaixa.ValidarAntesGravar: Boolean;
begin
  Result := False;
  if ibqMovimentoDATA.IsNull then
  begin
    ShowMessage('Informe a data!');
    Exit;
  end;
  if Trim(ibqMovimentoTIPO.AsString) = '' then
  begin
    ShowMessage('Informe o tipo (E/S)!');
    Exit;
  end;
  if ibqMovimentoVALOR.AsCurrency <= 0 then
  begin
    ShowMessage('Informe um valor maior que zero!');
    Exit;
  end;
  if (ibqMovimentoTIPO.AsString = 'S') and
     ((ibqMovimentoCODIGO_CENTRO_CUSTO.IsNull) or
      (ibqMovimentoCODIGO_CENTRO_CUSTO.AsInteger <= 0)) then
  begin
    ShowMessage('Centro de custo obrigatorio para saida!');
    Exit;
  end;
  if DiaBloqueado(ibqMovimentoDATA.AsDateTime) then
  begin
    ShowMessage('Caixa fechado para esta data!');
    Exit;
  end;
  Result := True;
end;

procedure TfrmMovimentoCaixa.dsMovimentoDataChange(Sender: TObject; Field: TField);
begin
  HabilitaBotoes;
end;

procedure TfrmMovimentoCaixa.btnConsultarClick(Sender: TObject);
begin
  MontarSQL;
  HabilitaBotoes;
end;

procedure TfrmMovimentoCaixa.btnInserirClick(Sender: TObject);
begin
  try
    ibqMovimento.Append;
    ibqMovimentoDATA.AsDateTime := Date;
    ibqMovimentoTIPO.AsString := 'E';
    ibqMovimentoVALOR.AsCurrency := 0;
    ibqMovimentoORIGEM.AsString := 'MANUAL';
    ibqMovimentoCONCILIADO.AsString := 'N';
    HabilitaBotoes;
    if dbeValor.CanFocus then
      dbeValor.SetFocus;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmMovimentoCaixa.btnEditarClick(Sender: TObject);
begin
  if ibqMovimento.IsEmpty then
    Exit;
  if DiaBloqueado(ibqMovimentoDATA.AsDateTime) then
  begin
    ShowMessage('Caixa fechado para esta data!');
    Exit;
  end;
  try
    ibqMovimento.Edit;
    HabilitaBotoes;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmMovimentoCaixa.btnGravarClick(Sender: TObject);
begin
  if not ValidarAntesGravar then
    Exit;

  if not IBTransactionMov.InTransaction then
    IBTransactionMov.StartTransaction;

  try
    if ibqMovimento.State = dsInsert then
    begin
      ibqMovimentoORIGEM.AsString := 'MANUAL';
      ibqMovimentoCONCILIADO.AsString := 'N';
    end;
    ibqMovimento.UpdateRecord;
    if ibqMovimento.State in [dsInsert, dsEdit] then
      ibqMovimento.Post;
    IBTransactionMov.CommitRetaining;
    ibqMovimento.Refresh;
    HabilitaBotoes;
  except
    IBTransactionMov.RollbackRetaining;
    ShowMessage('Erro ao salvar!');
  end;
end;

procedure TfrmMovimentoCaixa.btnCancelarClick(Sender: TObject);
begin
  try
    if ibqMovimento.State in [dsInsert, dsEdit] then
      ibqMovimento.Cancel;
    HabilitaBotoes;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmMovimentoCaixa.btnExcluirClick(Sender: TObject);
begin
  if ibqMovimento.IsEmpty then
    Exit;
  if DiaBloqueado(ibqMovimentoDATA.AsDateTime) then
  begin
    ShowMessage('Caixa fechado para esta data!');
    Exit;
  end;
  if MessageDlg('Confirma exclusao?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not IBTransactionMov.InTransaction then
    IBTransactionMov.StartTransaction;

  try
    ibqMovimento.Delete;
    IBTransactionMov.CommitRetaining;
    HabilitaBotoes;
  except
    IBTransactionMov.RollbackRetaining;
    ShowMessage('Erro ao excluir!');
  end;
end;

procedure TfrmMovimentoCaixa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
