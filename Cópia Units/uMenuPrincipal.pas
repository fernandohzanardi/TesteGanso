unit uMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uVendas, uCadastroProdutos,
  uCadastroCliente, Vcl.StdCtrls, Vcl.Buttons, Vcl.WinXCtrls, Vcl.ExtCtrls, System.StrUtils,
  System.Generics.Collections, uConfigSMTP, uLogEnvioEmail, frxSmartMemo,
  Data.DB, IBX.IBCustomDataSet, IBX.IBQuery, frxClass, frxDBSet, frCoreClasses, uConexao;

type
  TfrmMenuPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    Arquivos: TMenuItem;
    aClientes: TMenuItem;
    aProdutos: TMenuItem;
    aVendas: TMenuItem;
    N1: TMenuItem;
    aSair: TMenuItem;
    aAjuda: TMenuItem;
    Movimentao1: TMenuItem;
    Venda1: TMenuItem;
    Venda2: TMenuItem;
    Compra1: TMenuItem;
    Compra2: TMenuItem;
    Contas1: TMenuItem;
    Receber1: TMenuItem;
    Receber2: TMenuItem;
    Receber11: TMenuItem;
    Receber21: TMenuItem;
    svBusca: TSplitView;
    sbHamburguer: TSpeedButton;
    sbFixar: TSpeedButton;
    lTituloBusca: TLabel;
    eBuscaMenu: TEdit;
    lbResultadoBusca: TListBox;
    splBusca: TSplitter;
    Receber31: TMenuItem;
    Pagar11: TMenuItem;
    N2: TMenuItem;
    Relatrios1: TMenuItem;
    Ativos1: TMenuItem;
    Ativos2: TMenuItem;
    aConfigSMTP: TMenuItem;
    aLogEmail: TMenuItem;
    frxRelatorio: TfrxReport;
    frxRelCross: TfrxDBDataset;
    QVenda: TIBQuery;
    QVendaCODIGO: TIntegerField;
    QVendaDATA_VENDA: TDateField;
    QVendaANO: TSmallintField;
    QVendaCODIGO_PRODUTO: TIntegerField;
    QVendaQUANTIDADE: TIBBCDField;
    QVendaDESCRICAO: TIBStringField;
    QVendaCODIGO1: TIntegerField;
    QVendaFANTASIA: TIBStringField;
    QVendaMES: TIBStringField;
    procedure aClientesClick(Sender: TObject);
    procedure aProdutosClick(Sender: TObject);
    procedure aSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eBuscaMenuChange(Sender: TObject);
    procedure eBuscaMenuKeyPress(Sender: TObject; var Key: Char);
    procedure eBuscaMenuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbResultadoBuscaDblClick(Sender: TObject);
    procedure lbResultadoBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure Venda1Click(Sender: TObject);
    procedure aVendasClick(Sender: TObject);
    procedure Receber31Click(Sender: TObject);
    procedure sbHamburguerClick(Sender: TObject);
    procedure sbFixarClick(Sender: TObject);
    procedure svBuscaResize(Sender: TObject);
    procedure splBuscaCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure splBuscaMoved(Sender: TObject);
    procedure svBuscaOpened(Sender: TObject);
    procedure svBuscaClosed(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure aConfigSMTPClick(Sender: TObject);
    procedure aLogEmailClick(Sender: TObject);
  private
    { Private declarations }
    FMapaNumeracao: TDictionary<string, TMenuItem>;
    procedure EnumerarItensMenu(pItem: TMenuItem; const pPrefixo: string);
    procedure BuscarItensMenu(pItem: TMenuItem; const pTexto: string; pResultado: TList);
    procedure AbrirItemSelecionado;
    procedure RecolherBusca;
    procedure AcessarPorNumeracao(const pNumeracao: string);
    function EhNumeracao(const pTexto: string): Boolean;
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation


{$R *.dfm}

procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin
  sbHamburguer.Caption := #$2261;
  sbFixar.Caption := #$E718;
  FMapaNumeracao := TDictionary<string, TMenuItem>.Create;
  EnumerarItensMenu(mmPrincipal.Items, '');
end;

procedure TfrmMenuPrincipal.FormDestroy(Sender: TObject);
begin
  FMapaNumeracao.Free;
end;

procedure TfrmMenuPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
  if (ssCtrl in Shift) then
  begin
    case Key of
      Ord('M'): begin
                  sbHamburguer.Click;
                  Key := 0;
                end;
      Ord('A'): begin
                  aClientes.Click;
                  Key := 0;
                end;
    end;
  end;
 }
end;

procedure TfrmMenuPrincipal.EnumerarItensMenu(pItem: TMenuItem; const pPrefixo: string);
var
  lIndice: Integer;
  lNumero: Integer;
  lNumeracao: string;
begin
  lNumero := 0;
  for lIndice := 0 to pItem.Count - 1 do
  begin
    if (pItem.Items[lIndice].Caption <> '-') then
    begin
      Inc(lNumero);
      if (pPrefixo = '') then
        lNumeracao := IntToStr(lNumero)
      else
        lNumeracao := pPrefixo + '.' + IntToStr(lNumero);

      pItem.Items[lIndice].Caption := lNumeracao + ' - ' + pItem.Items[lIndice].Caption;
      FMapaNumeracao.Add(lNumeracao, pItem.Items[lIndice]);
      EnumerarItensMenu(pItem.Items[lIndice], lNumeracao);
    end;
  end;
end;

function TfrmMenuPrincipal.EhNumeracao(const pTexto: string): Boolean;
var
  lIndice: Integer;
begin
  Result := (pTexto <> '');
  for lIndice := 1 to Length(pTexto) do
  begin
    if (not CharInSet(pTexto[lIndice], ['0'..'9', '.'])) then
      Result := False;
  end;
end;

procedure TfrmMenuPrincipal.BuscarItensMenu(pItem: TMenuItem; const pTexto: string;
  pResultado: TList);
var
  lIndice: Integer;
  lCaption: string;
begin
  for lIndice := 0 to pItem.Count - 1 do
  begin
    if (pItem.Items[lIndice].Count > 0) then
      BuscarItensMenu(pItem.Items[lIndice], pTexto, pResultado)
    else if (pItem.Items[lIndice].Caption <> '-') and
            (Assigned(pItem.Items[lIndice].OnClick)) then
    begin
      lCaption := StripHotkey(pItem.Items[lIndice].Caption);
      if (EhNumeracao(pTexto) and StartsText(pTexto, lCaption)) or
         ((not EhNumeracao(pTexto)) and ContainsText(lCaption, pTexto)) then
        pResultado.Add(pItem.Items[lIndice]);
    end;
  end;
end;

procedure TfrmMenuPrincipal.eBuscaMenuChange(Sender: TObject);
var
  lResultado: TList;
  lIndice: Integer;
begin
  lbResultadoBusca.Items.Clear;

  if (Trim(eBuscaMenu.Text) = '') then
    Exit;

  lResultado := TList.Create;
  try
    BuscarItensMenu(mmPrincipal.Items, Trim(eBuscaMenu.Text), lResultado);
    for lIndice := 0 to lResultado.Count - 1 do
      lbResultadoBusca.Items.AddObject(
        StripHotkey(TMenuItem(lResultado[lIndice]).Caption), TObject(lResultado[lIndice]));
  finally
    lResultado.Free;
  end;
end;

procedure TfrmMenuPrincipal.AbrirItemSelecionado;
begin
  if (lbResultadoBusca.ItemIndex >= 0) then
  begin
    TMenuItem(lbResultadoBusca.Items.Objects[lbResultadoBusca.ItemIndex]).Click;
    RecolherBusca;
  end;
end;

procedure TfrmMenuPrincipal.RecolherBusca;
begin
  if (svBusca.DisplayMode = svmOverlay) then
    svBusca.Opened := False;
end;

procedure TfrmMenuPrincipal.sbHamburguerClick(Sender: TObject);
begin
  svBusca.Opened := not svBusca.Opened;

// Não funciona aqui por causa da animação
//  if (svBusca.Opened) then
//    eBuscaMenu.SetFocus;
end;

procedure TfrmMenuPrincipal.sbFixarClick(Sender: TObject);
begin
  if (sbFixar.Down) then
  begin
    sbFixar.Caption := #$E77A;
    sbFixar.Hint := 'Desafixar painel';
    svBusca.DisplayMode := svmDocked;
    svBusca.Opened := True;
  end
  else
  begin
    sbFixar.Caption := #$E718;
    sbFixar.Hint := 'Fixar painel';
    svBusca.DisplayMode := svmOverlay;
  end;
end;

procedure TfrmMenuPrincipal.svBuscaClosed(Sender: TObject);
begin
  eBuscaMenu.Clear;
end;

procedure TfrmMenuPrincipal.svBuscaOpened(Sender: TObject);
begin
  if (svBusca.Opened) then
    eBuscaMenu.SetFocus;
end;

procedure TfrmMenuPrincipal.svBuscaResize(Sender: TObject);
var
  lLargura: Integer;
begin
  lLargura := svBusca.Width - 44;
  if (lLargura < 50) then
    Exit;

  eBuscaMenu.Width := lLargura;
  lbResultadoBusca.Width := lLargura;
  sbFixar.Left := svBusca.Width - 32;
end;

procedure TfrmMenuPrincipal.splBuscaCanResize(Sender: TObject; var NewSize: Integer;
  var Accept: Boolean);
begin
  Accept := svBusca.Opened;
end;

procedure TfrmMenuPrincipal.splBuscaMoved(Sender: TObject);
begin
  svBusca.OpenedWidth := svBusca.Width;
end;

procedure TfrmMenuPrincipal.AcessarPorNumeracao(const pNumeracao: string);
var
  lItem: TMenuItem;
begin
  if (not FMapaNumeracao.TryGetValue(pNumeracao, lItem)) then
  begin
    ShowMessage('Nenhuma opção de menu com a numeração ' + pNumeracao + '!');
    Exit;
  end;

  if (lItem.Count > 0) or (not Assigned(lItem.OnClick)) then
    Exit;

  eBuscaMenu.Clear;
  lbResultadoBusca.Items.Clear;
  lItem.Click;
  RecolherBusca;
end;

procedure TfrmMenuPrincipal.eBuscaMenuKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    if (EhNumeracao(Trim(eBuscaMenu.Text))) then
      AcessarPorNumeracao(Trim(eBuscaMenu.Text));
  end;
end;

procedure TfrmMenuPrincipal.eBuscaMenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) and (lbResultadoBusca.Items.Count > 0) then
  begin
    Key := 0;
    lbResultadoBusca.ItemIndex := 0;
    lbResultadoBusca.SetFocus;
  end;
end;

procedure TfrmMenuPrincipal.lbResultadoBuscaDblClick(Sender: TObject);
begin
  AbrirItemSelecionado;
end;

procedure TfrmMenuPrincipal.lbResultadoBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    AbrirItemSelecionado;
  end;
end;

procedure TfrmMenuPrincipal.Receber31Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuPrincipal.Venda1Click(Sender: TObject);
begin
  if (not Assigned(frmVendas)) then
    frmVendas := TfrmVendas.Create(Self);

  frmVendas.Show;

end;

procedure TfrmMenuPrincipal.aClientesClick(Sender: TObject);
begin
  if (not Assigned(frmCadastroClientes)) then
    frmCadastroClientes := TfrmCadastroClientes.Create(Self);

  frmCadastroClientes.Show;
end;

procedure TfrmMenuPrincipal.aProdutosClick(Sender: TObject);
begin

 if (not Assigned(frmCadastroProdutos)) then
   frmCadastroProdutos := TfrmCadastroProdutos.Create(Self);

 frmCadastroProdutos.Show;
end;

procedure TfrmMenuPrincipal.aSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuPrincipal.aVendasClick(Sender: TObject);
begin
  if (not Assigned(frmVendas)) then
    frmVendas := TfrmVendas.Create(Self);

  frmVendas.Show;

end;

procedure TfrmMenuPrincipal.aConfigSMTPClick(Sender: TObject);
begin
  if not Assigned(frmConfiguracaoSMTP) then
    frmConfiguracaoSMTP := TfrmConfiguracaoSMTP.Create(Self);

  frmConfiguracaoSMTP.Show;
end;

procedure TfrmMenuPrincipal.aLogEmailClick(Sender: TObject);
begin
  if not Assigned(frmLogEnvioEmail) then
    frmLogEnvioEmail := TfrmLogEnvioEmail.Create(Self);

  frmLogEnvioEmail.Show;
end;

end.
