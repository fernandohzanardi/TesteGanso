unit uCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, Data.DB, IBX.IBQuery, IBX.IBDatabase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, frxClass,
  frxExportBaseDialog, frxExportPDF, frxDBSet;

type
  TfrmCadastroClientes = class(TfrmCadastroPadrao)
    lCodigo: TLabel;
    lNome: TLabel;
    lEndereco: TLabel;
    lBairro: TLabel;
    lCidade: TLabel;
    lTelefone: TLabel;
    lObservacao: TLabel;
    lRendaMensal: TLabel;
    lLimiteCredito: TLabel;
    lTotalCompras: TLabel;
    lEmail: TLabel;
    dbeCodigo: TDBEdit;
    dbeNome: TDBEdit;
    dbeEndereco: TDBEdit;
    dbeBairro: TDBEdit;
    dbeCidade: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeRendaMensal: TDBEdit;
    dbeLimiteCredito: TDBEdit;
    dbmObservacao: TDBMemo;
    dbeEmail: TDBEdit;
    ibqAtualiza: TIBQuery;
    ibqAtualizaTOTAL_COMPRAS: TIBBCDField;
    ibqCadastroCODIGO: TIntegerField;
    ibqCadastroNOME: TIBStringField;
    ibqCadastroENDERECO: TIBStringField;
    ibqCadastroBAIRRO: TIBStringField;
    ibqCadastroCIDADE: TIBStringField;
    ibqCadastroTELEFONE: TIBStringField;
    ibqCadastroOBSERVACAO: TBlobField;
    ibqCadastroRENDA_MENSAL: TIBBCDField;
    ibqCadastroLIMITE_CREDITO: TIBBCDField;
    ibqCadastroTOTAL_COMPRAS: TIBBCDField;
    ibqCadastroEMAIL: TIBStringField;
    dbeTotalCompras: TDBEdit;
    bAtualizar: TButton;
    dbcSituacao: TDBCheckBox;
    ibqCadastroSITUACAO: TIBStringField;
    frxRelatorio: TfrxReport;
    frxCadastro: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    btnEnviarEmail: TButton;
    btnEnviarWhats: TButton;
    procedure bAtualizarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsCadastroDataChange(Sender: TObject; Field: TField);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnEnviarWhatsClick(Sender: TObject);
  private
    procedure FocusEditarSalvar;
    { Private declarations }
  protected
    procedure ExecutarImpressao; override;
  public
    { Public declarations }
  end;

var
  frmCadastroClientes: TfrmCadastroClientes;

implementation

{$R *.dfm}

uses
  uRelFichaCliente, uConfigSMTP, uEnvioMensagens;

procedure TfrmCadastroClientes.bAtualizarClick(Sender: TObject);
begin
  try
    ibqCadastro.Refresh;
  except
    ShowMessage('Conexão falhou!');
  end;
end;

procedure TfrmCadastroClientes.btnEditarClick(Sender: TObject);
begin
  inherited;
  FocusEditarSalvar;
end;

procedure TfrmCadastroClientes.btnImprimirClick(Sender: TObject);
begin
//  inherited;
  frxRelatorio.ShowReport();
end;

procedure TfrmCadastroClientes.btnInserirClick(Sender: TObject);
begin
  inherited;
  if ibqCadastro.State in [dsInsert, dsEdit] then
    ibqCadastro.FieldByName('SITUACAO').AsString := 'A';
  FocusEditarSalvar;
end;

procedure TfrmCadastroClientes.dsCadastroDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  bAtualizar.Enabled := btnInserir.Enabled;
end;

procedure TfrmCadastroClientes.FormActivate(Sender: TObject);
begin
  inherited;

  try
    ibqCadastro.Open;
  except
    ShowMessage('Conexão falhou!');
  end;
end;

procedure TfrmCadastroClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroClientes := Nil;
end;

procedure TfrmCadastroClientes.FocusEditarSalvar;
begin
  if not (dbeNome.Focused) then
    dbeNome.SetFocus;
end;

procedure TfrmCadastroClientes.btnEnviarEmailClick(Sender: TObject);
var
  lConfig: TConfigSMTP;
  lEnvio: TEnvioMensagens;
  lNome: string;
  lEmail: string;
  lAssunto: string;
  lCorpo: string;
begin
  if (ibqCadastro.IsEmpty) or (ibqCadastro.State in dsEditModes) then
    Exit;

  lEmail := Trim(ibqCadastroEMAIL.AsString);
  if lEmail = '' then
  begin
    ShowMessage('Cliente sem e-mail cadastrado!');
    Exit;
  end;

  try
    lConfig := TfrmConfiguracaoSMTP.Carregar;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar configuracao SMTP: ' + E.Message);
      Exit;
    end;
  end;

  if (Trim(lConfig.Host) = '') or (Trim(lConfig.Remetente) = '') then
  begin
    ShowMessage('Configure o SMTP em Arquivos > Configuracao de SMTP!');
    Exit;
  end;

  lNome := ibqCadastroNOME.AsString;
  lAssunto := lConfig.AssuntoPadrao;
  lCorpo := TEnvioMensagens.MensagemPadrao(lNome, lConfig.MensagemPadrao);

  lEnvio := TEnvioMensagens.Create(lConfig);
  try
    try
      lEnvio.EnviarEmail(lEmail, lNome, lAssunto, lCorpo);
      TRegistroLogEmail.Registrar(ibqCadastroCODIGO.AsInteger, lEmail,
        lConfig.Remetente, lAssunto, lCorpo, slSucesso, '', 'CADASTRO_CLIENTE');
      ShowMessage('E-mail enviado com sucesso!');
    except
      on E: Exception do
      begin
        TRegistroLogEmail.Registrar(ibqCadastroCODIGO.AsInteger, lEmail,
          lConfig.Remetente, lAssunto, lCorpo, slFalha,
          E.ClassName + ': ' + E.Message, 'CADASTRO_CLIENTE');
        ShowMessage('Erro ao enviar e-mail: ' + E.Message);
      end;
    end;
  finally
    lEnvio.Free;
  end;
end;

procedure TfrmCadastroClientes.btnEnviarWhatsClick(Sender: TObject);
var
  lConfig: TConfigSMTP;
  lEnvio: TEnvioMensagens;
  lTelefone: string;
  lMensagemBanco: string;
  lMensagem: string;
begin
  if (ibqCadastro.IsEmpty) or (ibqCadastro.State in dsEditModes) then
    Exit;

  lTelefone := Trim(ibqCadastroTELEFONE.AsString);
  if lTelefone = '' then
  begin
    ShowMessage('Cliente sem telefone cadastrado!');
    Exit;
  end;

  lMensagemBanco := '';
  try
    lConfig := TfrmConfiguracaoSMTP.Carregar;
    lMensagemBanco := lConfig.MensagemPadrao;
  except
  end;

  lMensagem := TEnvioMensagens.MensagemPadrao(ibqCadastroNOME.AsString,
    lMensagemBanco);

  FillChar(lConfig, SizeOf(lConfig), 0);
  lEnvio := TEnvioMensagens.Create(lConfig);
  try
    try
      lEnvio.AbrirWhatsApp(lTelefone, lMensagem);
    except
      on E: Exception do
        ShowMessage('Erro ao abrir WhatsApp: ' + E.Message);
    end;
  finally
    lEnvio.Free;
  end;
end;

procedure TfrmCadastroClientes.ExecutarImpressao;
var
  lDM: TdmRelFichaCliente;
begin
  lDM := TdmRelFichaCliente.Create(nil);
  try
    lDM.Imprimir(ibqCadastroCODIGO.AsInteger);
  finally
    lDM.Free;
  end;
end;

end.
