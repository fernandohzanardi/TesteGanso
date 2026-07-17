unit uCadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, Data.DB, IBX.IBQuery, IBX.IBDatabase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, uCalculaFuncoesFinanceiras,
  frxClass, frxDBSet;

type
  TfrmCadastroProdutos = class(TfrmCadastroPadrao)
    lCodigo: TLabel;
    lDescricao: TLabel;
    lReferencia: TLabel;
    lCodigoBarras: TLabel;
    lMarca: TLabel;
    lGrupo: TLabel;
    lPrecoVenda: TLabel;
    lEstoqueAtual: TLabel;
    dbeCodigo: TDBEdit;
    dbeDescricao: TDBEdit;
    dbeReferencia: TDBEdit;
    dbeCodigoBarras: TDBEdit;
    dbeMarca: TDBEdit;
    dbeGrupo: TDBEdit;
    dbePrecoVenda: TDBEdit;
    dbeEstoqueAtual: TDBEdit;
    ibqCadastroCODIGO: TIntegerField;
    ibqCadastroDESCRICAO: TIBStringField;
    ibqCadastroREFERENCIA: TIBStringField;
    ibqCadastroCODIGO_BARRAS: TLargeintField;
    ibqCadastroMARCA: TIBStringField;
    ibqCadastroGRUPO: TIBStringField;
    ibqCadastroPRECO_VENDA: TIBBCDField;
    ibqCadastroESTOQUE_ATUAL: TIBBCDField;
    ibqCadastroVALOR_CUSTO: TIBBCDField;
    lValorCusto: TLabel;
    lPercLucro: TLabel;
    dbeValorCusto: TDBEdit;
    ePercLucro: TEdit;
    ImCliente: TImage;
    ibConsultaQtdeVendas: TIBQuery;
    ibConsultaQtdeVendasQTDE_VENDA: TIntegerField;
    EqtdeVenda: TEdit;
    Edit1: TEdit;
    IBQuery1: TIBQuery;
    IBQuery1CODIGO: TIntegerField;
    IBQuery1DATA_HORA_VENDA: TDateTimeField;
    IBQuery1TOTAL_LIQUIDO: TIBBCDField;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure dsCadastroDataChange(Sender: TObject; Field: TField);
    procedure dbeValorCustoChange(Sender: TObject);
    procedure dbePrecoVendaChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure FocusEditarSalvar;
    procedure AtualizaPercLucro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

{$R *.dfm}

procedure TfrmCadastroProdutos.FormActivate(Sender: TObject);
begin
  try
    ibqCadastro.Open;
  except
    ShowMessage('Conexão falhou!');
  end;
end;

procedure TfrmCadastroProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroProdutos := Nil;
end;

procedure TfrmCadastroProdutos.btnEditarClick(Sender: TObject);
begin
  inherited;
  FocusEditarSalvar;
end;

procedure TfrmCadastroProdutos.btnInserirClick(Sender: TObject);
begin
  inherited;
  FocusEditarSalvar;

  if True then
  begin
  ibConsultaQtdeVendas.Close;
  ibConsultaQtdeVendas.ParamByName('codigo').AsInteger := ibqCadastroCodigo.Asinteger;
  ibConsultaQtdeVendas.Open;
  end;

  if True then
    ShowMessage('Teste');

end;

procedure TfrmCadastroProdutos.Button1Click(Sender: TObject);
begin
  inherited;
  ShowMessage('Clicado o Botão Imprimir!');
  // Alterado por André Luis Dia 17/07/2026 as 15:45
end;

procedure TfrmCadastroProdutos.FocusEditarSalvar;
begin
  if not (dbeDescricao.Focused) then
    dbeDescricao.SetFocus;
end;

procedure TfrmCadastroProdutos.AtualizaPercLucro;
var Texto: String;
begin
// Adicionado
//Validação
  Texto := '';


//    ePercLucro.Text := FormatFloat('0.00',
//      TUcalculaFuncFinan.CalculaPercLucro(ibqCadastroVALOR_CUSTO.AsCurrency,
//      ibqCadastroPRECO_VENDA.AsCurrency)) + ' %';

   ePercLucro.Text := FormatFloat('0.00',
      ((ibqCadastroPRECO_VENDA.AsCurrency - ibqCadastroVALOR_CUSTO.AsCurrency) / ibqCadastroPRECO_VENDA.AsCurrency) * 100) + ' %';

end;

procedure TfrmCadastroProdutos.dsCadastroDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  AtualizaPercLucro;

  ibConsultaQtdeVendas.Close;
  ibConsultaQtdeVendas.ParamByName('codigo').AsInteger := ibqCadastroCodigo.Asinteger;
  ibConsultaQtdeVendas.Open;

  EqtdeVenda.Text := intToStr(ibConsultaQtdeVendas.FieldByName('qtde_venda').AsInteger);
end;

procedure TfrmCadastroProdutos.dbeValorCustoChange(Sender: TObject);
begin
  AtualizaPercLucro;
end;

procedure TfrmCadastroProdutos.dbePrecoVendaChange(Sender: TObject);
begin
  AtualizaPercLucro;
end;

end.
