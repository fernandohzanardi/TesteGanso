unit uFluxoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet;

type
  TfrmFluxoCaixa = class(TForm)
    pFiltros: TPanel;
    pRodape: TPanel;
    lPeriodo: TLabel;
    lAte: TLabel;
    lPreset: TLabel;
    lTotEntradas: TLabel;
    lTotSaidas: TLabel;
    lTotSaldo: TLabel;
    lSaldoAcum: TLabel;
    eTotEntradas: TEdit;
    eTotSaidas: TEdit;
    eTotSaldo: TEdit;
    eSaldoAcum: TEdit;
    cbPreset: TComboBox;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    btnConsultar: TButton;
    btnImprimir: TButton;
    btnFechar: TButton;
    dbgFluxo: TDBGrid;
    dsFluxo: TDataSource;
    cdsFluxo: TClientDataSet;
    cdsFluxoDATA_REF: TDateField;
    cdsFluxoENTRADAS: TCurrencyField;
    cdsFluxoSAIDAS: TCurrencyField;
    cdsFluxoSALDO_DIA: TCurrencyField;
    cdsFluxoSALDO_ACUM: TCurrencyField;
    IBTransactionFluxo: TIBTransaction;
    ibqFluxo: TIBQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure cbPresetChange(Sender: TObject);
  strict private
    procedure GarantirCds;
    procedure AplicarPreset;
    procedure Consultar;
  public
    { Public declarations }
  end;

var
  frmFluxoCaixa: TfrmFluxoCaixa;

implementation

{$R *.dfm}

uses
  System.DateUtils, uConexao, uServicoFinanceiro;

procedure TfrmFluxoCaixa.FormActivate(Sender: TObject);
begin
  if dtpDataInicial.Tag = 0 then
  begin
    cbPreset.Items.Clear;
    cbPreset.Items.Add('7 dias');
    cbPreset.Items.Add('15 dias');
    cbPreset.Items.Add('30 dias');
    cbPreset.Items.Add('90 dias');
    cbPreset.ItemIndex := 2;
    AplicarPreset;
    GarantirCds;
    dtpDataInicial.Tag := 1;
  end;
end;

procedure TfrmFluxoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmFluxoCaixa := Nil;
end;

procedure TfrmFluxoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F5: btnConsultar.Click;
  end;
end;

procedure TfrmFluxoCaixa.GarantirCds;
begin
  if not cdsFluxo.Active then
    cdsFluxo.CreateDataSet;
end;

procedure TfrmFluxoCaixa.AplicarPreset;
var
  lDias: Integer;
begin
  case cbPreset.ItemIndex of
    0: lDias := 7;
    1: lDias := 15;
    2: lDias := 30;
    3: lDias := 90;
  else
    lDias := 30;
  end;
  dtpDataInicial.Date := Date;
  dtpDataFinal.Date := Date + lDias;
end;

procedure TfrmFluxoCaixa.cbPresetChange(Sender: TObject);
begin
  AplicarPreset;
end;

procedure TfrmFluxoCaixa.Consultar;
var
  lEnt, lSai, lAcum: Currency;
begin
  GarantirCds;
  if not IBTransactionFluxo.InTransaction then
    IBTransactionFluxo.StartTransaction;

  try
    TServicoFinanceiro.CarregarProjecaoFluxo(IBTransactionFluxo,
      dtpDataInicial.Date, dtpDataFinal.Date, ibqFluxo);

    cdsFluxo.EmptyDataSet;
    lEnt := 0;
    lSai := 0;
    lAcum := 0;

    ibqFluxo.First;
    while not ibqFluxo.Eof do
    begin
      lAcum := lAcum + ibqFluxo.FieldByName('SALDO_DIA').AsCurrency;
      lEnt := lEnt + ibqFluxo.FieldByName('ENTRADAS').AsCurrency;
      lSai := lSai + ibqFluxo.FieldByName('SAIDAS').AsCurrency;

      cdsFluxo.Append;
      cdsFluxoDATA_REF.AsDateTime := ibqFluxo.FieldByName('DATA_REF').AsDateTime;
      cdsFluxoENTRADAS.AsCurrency := ibqFluxo.FieldByName('ENTRADAS').AsCurrency;
      cdsFluxoSAIDAS.AsCurrency := ibqFluxo.FieldByName('SAIDAS').AsCurrency;
      cdsFluxoSALDO_DIA.AsCurrency := ibqFluxo.FieldByName('SALDO_DIA').AsCurrency;
      cdsFluxoSALDO_ACUM.AsCurrency := lAcum;
      cdsFluxo.Post;

      ibqFluxo.Next;
    end;

    eTotEntradas.Text := FormatFloat('#,##0.00', lEnt);
    eTotSaidas.Text := FormatFloat('#,##0.00', lSai);
    eTotSaldo.Text := FormatFloat('#,##0.00', lEnt - lSai);
    eSaldoAcum.Text := FormatFloat('#,##0.00', lAcum);
  except
    on E: Exception do
      ShowMessage('Erro ao consultar fluxo: ' + E.Message);
  end;
end;

procedure TfrmFluxoCaixa.btnConsultarClick(Sender: TObject);
begin
  Consultar;
end;

procedure TfrmFluxoCaixa.btnImprimirClick(Sender: TObject);
begin
  ShowMessage('Relatorio em desenvolvimento');
end;

procedure TfrmFluxoCaixa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
