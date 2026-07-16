unit uConciliacaoBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB,
  IBX.IBDatabase, IBX.IBQuery, IBX.IBCustomDataSet;

type
  TfrmConciliacaoBancaria = class(TForm)
    pFiltros: TPanel;
    pRodape: TPanel;
    pSplit: TPanel;
    lConta: TLabel;
    lPeriodo: TLabel;
    lAte: TLabel;
    lExtrato: TLabel;
    lMovimentos: TLabel;
    eCodigoConta: TEdit;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    btnConsultar: TButton;
    btnImportarCSV: TButton;
    btnConciliarManual: TButton;
    btnConciliarAuto: TButton;
    btnFechar: TButton;
    dbgExtrato: TDBGrid;
    dbgMovimento: TDBGrid;
    OpenDialogCSV: TOpenDialog;
    dsExtrato: TDataSource;
    dsMovimento: TDataSource;
    IBTransactionConc: TIBTransaction;
    ibqExtrato: TIBQuery;
    ibqMovimento: TIBQuery;
    ibqExtratoCODIGO: TIntegerField;
    ibqExtratoDATA: TDateField;
    ibqExtratoVALOR: TIBBCDField;
    ibqExtratoHISTORICO: TIBStringField;
    ibqMovimentoCODIGO: TIntegerField;
    ibqMovimentoDATA: TDateField;
    ibqMovimentoTIPO: TIBStringField;
    ibqMovimentoVALOR: TIBBCDField;
    ibqMovimentoHISTORICO: TIBStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnImportarCSVClick(Sender: TObject);
    procedure btnConciliarManualClick(Sender: TObject);
    procedure btnConciliarAutoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  strict private
    function GetCodigoConta: Integer;
    procedure MontarSQL;
  public
    { Public declarations }
  end;

var
  frmConciliacaoBancaria: TfrmConciliacaoBancaria;

implementation

{$R *.dfm}

uses
  System.DateUtils, uConexao, uServicoFinanceiro;

procedure TfrmConciliacaoBancaria.FormActivate(Sender: TObject);
begin
  if dtpDataInicial.Tag = 0 then
  begin
    dtpDataInicial.Date := StartOfTheMonth(Date);
    dtpDataFinal.Date := Date;
    eCodigoConta.Text := '1';
    dtpDataInicial.Tag := 1;
  end;
  MontarSQL;
end;

procedure TfrmConciliacaoBancaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmConciliacaoBancaria := Nil;
end;

procedure TfrmConciliacaoBancaria.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_F5: btnConsultar.Click;
  end;
end;

function TfrmConciliacaoBancaria.GetCodigoConta: Integer;
begin
  Result := StrToIntDef(Trim(eCodigoConta.Text), 0);
end;

procedure TfrmConciliacaoBancaria.MontarSQL;
var
  lConta: Integer;
begin
  lConta := GetCodigoConta;
  if lConta <= 0 then
  begin
    ShowMessage('Informe o codigo da conta bancaria!');
    Exit;
  end;

  ibqExtrato.Close;
  ibqExtrato.SQL.Clear;
  ibqExtrato.SQL.Add('SELECT CODIGO, DATA, VALOR, HISTORICO');
  ibqExtrato.SQL.Add('FROM EXTRATO_BANCARIO');
  ibqExtrato.SQL.Add('WHERE CODIGO_CONTA = :CODIGO_CONTA');
  ibqExtrato.SQL.Add('  AND CONCILIADO = ''N''');
  ibqExtrato.SQL.Add('  AND DATA BETWEEN :DATA_INI AND :DATA_FIM');
  ibqExtrato.SQL.Add('ORDER BY DATA, CODIGO');
  ibqExtrato.ParamByName('CODIGO_CONTA').AsInteger := lConta;
  ibqExtrato.ParamByName('DATA_INI').AsDateTime := DateOf(dtpDataInicial.DateTime);
  ibqExtrato.ParamByName('DATA_FIM').AsDateTime := DateOf(dtpDataFinal.DateTime);

  ibqMovimento.Close;
  ibqMovimento.SQL.Clear;
  ibqMovimento.SQL.Add('SELECT CODIGO, DATA, TIPO, VALOR, HISTORICO');
  ibqMovimento.SQL.Add('FROM MOVIMENTO_CAIXA');
  ibqMovimento.SQL.Add('WHERE CODIGO_CONTA = :CODIGO_CONTA');
  ibqMovimento.SQL.Add('  AND CONCILIADO = ''N''');
  ibqMovimento.SQL.Add('  AND DATA BETWEEN :DATA_INI AND :DATA_FIM');
  ibqMovimento.SQL.Add('ORDER BY DATA, CODIGO');
  ibqMovimento.ParamByName('CODIGO_CONTA').AsInteger := lConta;
  ibqMovimento.ParamByName('DATA_INI').AsDateTime := DateOf(dtpDataInicial.DateTime);
  ibqMovimento.ParamByName('DATA_FIM').AsDateTime := DateOf(dtpDataFinal.DateTime);

  try
    ibqExtrato.Open;
    ibqMovimento.Open;
  except
    on E: Exception do
      ShowMessage('Erro ao consultar: ' + E.Message);
  end;
end;

procedure TfrmConciliacaoBancaria.btnConsultarClick(Sender: TObject);
begin
  MontarSQL;
end;

procedure TfrmConciliacaoBancaria.btnImportarCSVClick(Sender: TObject);
var
  lArquivo: TStringList;
  lI, lJ: Integer;
  lLinha, lDataStr, lValorStr, lHist: string;
  lParts: TArray<string>;
  lData: TDateTime;
  lValor: Currency;
  lConta: Integer;
  lQ: TIBQuery;
  lImportados: Integer;
begin
  lConta := GetCodigoConta;
  if lConta <= 0 then
  begin
    ShowMessage('Informe o codigo da conta bancaria!');
    Exit;
  end;

  OpenDialogCSV.Filter := 'Arquivo CSV|*.csv|Todos|*.*';
  OpenDialogCSV.DefaultExt := 'csv';
  if not OpenDialogCSV.Execute then
    Exit;

  lArquivo := TStringList.Create;
  lQ := TIBQuery.Create(nil);
  lImportados := 0;
  try
    lArquivo.LoadFromFile(OpenDialogCSV.FileName);
    if not IBTransactionConc.InTransaction then
      IBTransactionConc.StartTransaction;

    lQ.Database := dmConexao.IBDConexao;
    lQ.Transaction := IBTransactionConc;

    try
      for lI := 0 to lArquivo.Count - 1 do
      begin
        lLinha := Trim(lArquivo[lI]);
        if lLinha = '' then
          Continue;

        lParts := lLinha.Split([';']);
        if Length(lParts) < 3 then
          Continue;

        lDataStr := Trim(lParts[0]);
        lValorStr := Trim(lParts[1]);
        lHist := Trim(lParts[2]);
        if Length(lParts) > 3 then
        begin
          for lJ := 3 to High(lParts) do
            lHist := lHist + ';' + Trim(lParts[lJ]);
        end;

        if not TryStrToDate(lDataStr, lData) then
          Continue;
        lValor := StrToCurrDef(StringReplace(lValorStr, '.', '', [rfReplaceAll]), 0);
        if lValor = 0 then
          Continue;

        lQ.SQL.Text :=
          'INSERT INTO EXTRATO_BANCARIO ' +
          '  (CODIGO_CONTA, DATA, VALOR, HISTORICO, CONCILIADO) ' +
          'VALUES ' +
          '  (:CODIGO_CONTA, :DATA, :VALOR, :HISTORICO, ''N'')';
        lQ.ParamByName('CODIGO_CONTA').AsInteger := lConta;
        lQ.ParamByName('DATA').AsDateTime := Trunc(lData);
        lQ.ParamByName('VALOR').AsCurrency := lValor;
        lQ.ParamByName('HISTORICO').AsString := Copy(lHist, 1, 200);
        lQ.ExecSQL;
        Inc(lImportados);
      end;

      IBTransactionConc.CommitRetaining;
      ShowMessage(Format('Importados: %d registro(s).', [lImportados]));
      MontarSQL;
    except
      on E: Exception do
      begin
        IBTransactionConc.RollbackRetaining;
        ShowMessage('Erro ao importar: ' + E.Message);
      end;
    end;
  finally
    lQ.Free;
    lArquivo.Free;
  end;
end;

procedure TfrmConciliacaoBancaria.btnConciliarManualClick(Sender: TObject);
var
  lQ: TIBQuery;
  lCodExt, lCodMov: Integer;
begin
  if ibqExtrato.IsEmpty or ibqMovimento.IsEmpty then
  begin
    ShowMessage('Selecione um extrato e um movimento!');
    Exit;
  end;

  lCodExt := ibqExtratoCODIGO.AsInteger;
  lCodMov := ibqMovimentoCODIGO.AsInteger;

  if MessageDlg('Conciliar extrato ' + IntToStr(lCodExt) +
    ' com movimento ' + IntToStr(lCodMov) + '?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if not IBTransactionConc.InTransaction then
    IBTransactionConc.StartTransaction;

  lQ := TIBQuery.Create(nil);
  try
    try
      lQ.Database := dmConexao.IBDConexao;
      lQ.Transaction := IBTransactionConc;

      lQ.SQL.Text :=
        'UPDATE EXTRATO_BANCARIO SET CONCILIADO = ''S'', CODIGO_MOVIMENTO = :MOV ' +
        'WHERE CODIGO = :CODIGO AND CONCILIADO = ''N''';
      lQ.ParamByName('MOV').AsInteger := lCodMov;
      lQ.ParamByName('CODIGO').AsInteger := lCodExt;
      lQ.ExecSQL;

      lQ.SQL.Text :=
        'UPDATE MOVIMENTO_CAIXA SET CONCILIADO = ''S'', CODIGO_EXTRATO = :EXT ' +
        'WHERE CODIGO = :CODIGO AND CONCILIADO = ''N''';
      lQ.ParamByName('EXT').AsInteger := lCodExt;
      lQ.ParamByName('CODIGO').AsInteger := lCodMov;
      lQ.ExecSQL;

      IBTransactionConc.CommitRetaining;
      ShowMessage('Conciliacao manual realizada!');
      MontarSQL;
    except
      on E: Exception do
      begin
        IBTransactionConc.RollbackRetaining;
        ShowMessage('Erro ao conciliar: ' + E.Message);
      end;
    end;
  finally
    lQ.Free;
  end;
end;

procedure TfrmConciliacaoBancaria.btnConciliarAutoClick(Sender: TObject);
var
  lConta, lQtd: Integer;
begin
  lConta := GetCodigoConta;
  if lConta <= 0 then
  begin
    ShowMessage('Informe o codigo da conta bancaria!');
    Exit;
  end;

  if not IBTransactionConc.InTransaction then
    IBTransactionConc.StartTransaction;

  try
    lQtd := TServicoFinanceiro.ConciliarAutomatico(IBTransactionConc, lConta,
      dtpDataInicial.Date, dtpDataFinal.Date);
    IBTransactionConc.CommitRetaining;
    ShowMessage(Format('Conciliados automaticamente: %d', [lQtd]));
    MontarSQL;
  except
    on E: Exception do
    begin
      IBTransactionConc.RollbackRetaining;
      ShowMessage('Erro na conciliacao automatica: ' + E.Message);
    end;
  end;
end;

procedure TfrmConciliacaoBancaria.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
