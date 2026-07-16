unit uCadastroContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, Data.DB, IBX.IBQuery, IBX.IBDatabase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadastroContaBancaria = class(TfrmCadastroPadrao)
    lCodigo: TLabel;
    lDescricao: TLabel;
    lBanco: TLabel;
    lAgencia: TLabel;
    lNumeroConta: TLabel;
    lSaldoInicial: TLabel;
    dbeCodigo: TDBEdit;
    dbeDescricao: TDBEdit;
    dbeBanco: TDBEdit;
    dbeAgencia: TDBEdit;
    dbeNumeroConta: TDBEdit;
    dbeSaldoInicial: TDBEdit;
    dbcAtivo: TDBCheckBox;
    ibqCadastroCODIGO: TIntegerField;
    ibqCadastroDESCRICAO: TIBStringField;
    ibqCadastroBANCO: TIBStringField;
    ibqCadastroAGENCIA: TIBStringField;
    ibqCadastroNUMERO_CONTA: TIBStringField;
    ibqCadastroSALDO_INICIAL: TIBBCDField;
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
  frmCadastroContaBancaria: TfrmCadastroContaBancaria;

implementation

{$R *.dfm}

uses
  uConexao;

procedure TfrmCadastroContaBancaria.FormActivate(Sender: TObject);
begin
  try
    ibqCadastro.Open;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmCadastroContaBancaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroContaBancaria := Nil;
end;

procedure TfrmCadastroContaBancaria.btnInserirClick(Sender: TObject);
begin
  inherited;
  if ibqCadastro.State in [dsInsert, dsEdit] then
    ibqCadastro.FieldByName('ATIVO').AsString := 'A';
end;

end.
