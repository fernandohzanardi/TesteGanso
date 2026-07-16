unit uCadastroFormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, Data.DB, IBX.IBQuery, IBX.IBDatabase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadastroFormaPagamento = class(TfrmCadastroPadrao)
    lCodigo: TLabel;
    lDescricao: TLabel;
    lDiasCompensacao: TLabel;
    dbeCodigo: TDBEdit;
    dbeDescricao: TDBEdit;
    dbeDiasCompensacao: TDBEdit;
    dbcEntraCaixaImediato: TDBCheckBox;
    dbcGeraTitulo: TDBCheckBox;
    dbcAtivo: TDBCheckBox;
    ibqCadastroCODIGO: TIntegerField;
    ibqCadastroDESCRICAO: TIBStringField;
    ibqCadastroENTRA_CAIXA_IMEDIATO: TIBStringField;
    ibqCadastroGERA_TITULO: TIBStringField;
    ibqCadastroDIAS_COMPENSACAO: TIntegerField;
    ibqCadastroATIVO: TIBStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroFormaPagamento: TfrmCadastroFormaPagamento;

implementation

{$R *.dfm}

uses
  uConexao;

procedure TfrmCadastroFormaPagamento.FormActivate(Sender: TObject);
begin
  try
    ibqCadastro.Open;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmCadastroFormaPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroFormaPagamento := Nil;
end;

procedure TfrmCadastroFormaPagamento.btnInserirClick(Sender: TObject);
begin
  inherited;
  if ibqCadastro.State in [dsInsert, dsEdit] then
    ibqCadastro.FieldByName('ATIVO').AsString := 'A';
end;

end.
