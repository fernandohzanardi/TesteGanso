unit uEnvioMensagens;

interface

uses
  Winapi.Windows, Winapi.ShellAPI, System.SysUtils, System.Classes,
  Data.DB, IBX.IBDatabase, IBX.IBQuery,
  IdSMTP, IdMessage, IdSSLOpenSSL, IdExplicitTLSClientServerBase;

type
  TConfigSMTP = record
    Host: string;
    Porta: Integer;
    UsarTLS: Boolean;
    TipoTLS: Char;
    Usuario: string;
    Senha: string;
    Remetente: string;
    NomeRemetente: string;
    TimeoutMs: Integer;
    AssuntoPadrao: string;
    MensagemPadrao: string;
  end;

  TEnvioMensagens = class
  strict private
    FConfig: TConfigSMTP;
    function DigitosApenas(const pTexto: string): string;
  public
    constructor Create(const pConfig: TConfigSMTP);
    procedure EnviarEmail(const pDestinatario, pNomeDestinatario,
      pAssunto, pCorpo: string);
    procedure AbrirWhatsApp(const pTelefone, pMensagem: string);
    class function MensagemPadrao(const pNomeCliente,
      pMensagemBanco: string): string;
  end;

  TSituacaoLog = (slSucesso, slFalha);

  TRegistroLogEmail = class
  public
    class procedure Registrar(
      const pCodigoCliente: Integer;
      const pDestinatario, pRemetente, pAssunto, pCorpo: string;
      const pSituacao: TSituacaoLog;
      const pMensagemErro, pOrigem: string);
  end;

implementation

uses
  System.NetEncoding, uConexao;

const
  CMensagemPadraoDefault =
    'Ola %s, tudo bem?' + sLineBreak +
    'Agradecemos por ser nosso cliente. Qualquer duvida, estamos a disposicao.' +
    sLineBreak + sLineBreak +
    'Atenciosamente,' + sLineBreak +
    'Equipe GANSO';

{ TEnvioMensagens }

constructor TEnvioMensagens.Create(const pConfig: TConfigSMTP);
begin
  inherited Create;
  FConfig := pConfig;
end;

function TEnvioMensagens.DigitosApenas(const pTexto: string): string;
var
  lIndice: Integer;
begin
  Result := '';
  for lIndice := 1 to Length(pTexto) do
    if CharInSet(pTexto[lIndice], ['0'..'9']) then
      Result := Result + pTexto[lIndice];
end;

class function TEnvioMensagens.MensagemPadrao(const pNomeCliente,
  pMensagemBanco: string): string;
begin
  if Trim(pMensagemBanco) <> '' then
    Result := StringReplace(pMensagemBanco, '{NOME}', pNomeCliente,
      [rfReplaceAll, rfIgnoreCase])
  else
    Result := Format(CMensagemPadraoDefault, [pNomeCliente]);
end;

procedure TEnvioMensagens.EnviarEmail(const pDestinatario, pNomeDestinatario,
  pAssunto, pCorpo: string);
var
  lSMTP: TIdSMTP;
  lMsg: TIdMessage;
  lSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  if Trim(pDestinatario) = '' then
    raise Exception.Create('Destinatario nao informado.');

  if Trim(FConfig.Host) = '' then
    raise Exception.Create('Servidor SMTP nao configurado.');

  lSMTP := TIdSMTP.Create(nil);
  lMsg := TIdMessage.Create(nil);
  lSSL := nil;
  try
    if FConfig.UsarTLS and (FConfig.TipoTLS <> 'N') then
    begin
      lSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      lSSL.SSLOptions.Method := sslvTLSv1_2;
      lSSL.SSLOptions.Mode := sslmClient;
      lSMTP.IOHandler := lSSL;

      case FConfig.TipoTLS of
        'I': lSMTP.UseTLS := utUseImplicitTLS;
      else
        lSMTP.UseTLS := utUseExplicitTLS;
      end;
    end
    else
      lSMTP.UseTLS := utNoTLSSupport;

    lSMTP.Host := FConfig.Host;
    lSMTP.Port := FConfig.Porta;
    lSMTP.Username := FConfig.Usuario;
    lSMTP.Password := FConfig.Senha;

    if FConfig.TimeoutMs > 0 then
    begin
      lSMTP.ConnectTimeout := FConfig.TimeoutMs;
      lSMTP.ReadTimeout := FConfig.TimeoutMs;
    end;

    lMsg.From.Address := FConfig.Remetente;
    lMsg.From.Name := FConfig.NomeRemetente;
    lMsg.Recipients.Add.Address := pDestinatario;
    if Trim(pNomeDestinatario) <> '' then
      lMsg.Recipients.Items[0].Name := pNomeDestinatario;
    lMsg.Subject := pAssunto;
    lMsg.ContentType := 'text/plain';
    lMsg.CharSet := 'UTF-8';
    lMsg.Body.Text := pCorpo;

    lSMTP.Connect;
    try
      lSMTP.Send(lMsg);
    finally
      if lSMTP.Connected then
        lSMTP.Disconnect;
    end;
  finally
    if Assigned(lSSL) then
      lSSL.Free;
    lMsg.Free;
    lSMTP.Free;
  end;
end;

procedure TEnvioMensagens.AbrirWhatsApp(const pTelefone, pMensagem: string);
var
  lNumero: string;
  lUrl: string;
begin
  lNumero := DigitosApenas(pTelefone);
  if lNumero = '' then
    raise Exception.Create('Telefone nao informado.');

  if Length(lNumero) <= 11 then
    lNumero := '55' + lNumero;

  lUrl := Format('https://wa.me/%s?text=%s',
    [lNumero, TNetEncoding.URL.Encode(pMensagem)]);

  ShellExecute(0, 'open', PChar(lUrl), nil, nil, SW_SHOWNORMAL);
end;

{ TRegistroLogEmail }

class procedure TRegistroLogEmail.Registrar(
  const pCodigoCliente: Integer;
  const pDestinatario, pRemetente, pAssunto, pCorpo: string;
  const pSituacao: TSituacaoLog;
  const pMensagemErro, pOrigem: string);
const
  CSituacao: array[TSituacaoLog] of Char = ('S', 'F');
var
  lTransacao: TIBTransaction;
  lQuery: TIBQuery;
  lUsuario: string;
  lMaquina: string;
  lTamanho: DWORD;
begin
  lTransacao := TIBTransaction.Create(nil);
  lQuery := TIBQuery.Create(nil);
  try
    lTransacao.DefaultDatabase := dmConexao.IBDConexao;
    lTransacao.Params.Text := 'read_committed'#13#10'rec_version'#13#10'nowait';
    try
      lTransacao.StartTransaction;

      lQuery.Database := dmConexao.IBDConexao;
      lQuery.Transaction := lTransacao;
      lQuery.SQL.Text :=
        'INSERT INTO LOG_ENVIO_EMAIL '                                    +
        '  (CODIGO_CLIENTE, DESTINATARIO, REMETENTE, ASSUNTO, CORPO, '    +
        '   SITUACAO, MENSAGEM_ERRO, USUARIO_SO, MAQUINA, ORIGEM) '       +
        'VALUES '                                                         +
        '  (:CODIGO_CLIENTE, :DESTINATARIO, :REMETENTE, :ASSUNTO, :CORPO,'+
        '   :SITUACAO, :MENSAGEM_ERRO, :USUARIO_SO, :MAQUINA, :ORIGEM)';

      if pCodigoCliente > 0 then
        lQuery.ParamByName('CODIGO_CLIENTE').AsInteger := pCodigoCliente
      else
        lQuery.ParamByName('CODIGO_CLIENTE').Clear;

      lQuery.ParamByName('DESTINATARIO').AsString  := pDestinatario;
      lQuery.ParamByName('REMETENTE').AsString     := pRemetente;
      lQuery.ParamByName('ASSUNTO').AsString       := Copy(pAssunto, 1, 120);
      lQuery.ParamByName('CORPO').AsString         := pCorpo;
      lQuery.ParamByName('SITUACAO').AsString      := CSituacao[pSituacao];
      lQuery.ParamByName('MENSAGEM_ERRO').AsString := Copy(pMensagemErro, 1, 500);

      lTamanho := 50;
      SetLength(lUsuario, lTamanho);
      if GetUserName(PChar(lUsuario), lTamanho) then
        SetLength(lUsuario, lTamanho - 1)
      else
        lUsuario := '';

      lTamanho := 50;
      SetLength(lMaquina, lTamanho);
      if GetComputerName(PChar(lMaquina), lTamanho) then
        SetLength(lMaquina, lTamanho)
      else
        lMaquina := '';

      lQuery.ParamByName('USUARIO_SO').AsString := lUsuario;
      lQuery.ParamByName('MAQUINA').AsString    := lMaquina;
      lQuery.ParamByName('ORIGEM').AsString     := Copy(pOrigem, 1, 30);

      lQuery.ExecSQL;
      lTransacao.Commit;
    except
      if lTransacao.InTransaction then
        lTransacao.Rollback;
    end;
  finally
    lQuery.Free;
    lTransacao.Free;
  end;
end;

end.
