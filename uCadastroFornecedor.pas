unit uCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, Data.DB, IBX.IBQuery, IBX.IBDatabase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadastroFornecedor = class(TfrmCadastroPadrao)
    lCodigo: TLabel;
    lNome: TLabel;
    lTelefone: TLabel;
    lEmail: TLabel;
    dbeCodigo: TDBEdit;
    dbeNome: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeEmail: TDBEdit;
    dbcAtivo: TDBCheckBox;
    ibqCadastroCODIGO: TIntegerField;
    ibqCadastroNOME: TIBStringField;
    ibqCadastroTELEFONE: TIBStringField;
    ibqCadastroEMAIL: TIBStringField;
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
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

{$R *.dfm}

uses
  uConexao;

procedure TfrmCadastroFornecedor.FormActivate(Sender: TObject);
begin
  try
    ibqCadastro.Open;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmCadastroFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroFornecedor := Nil;
end;

procedure TfrmCadastroFornecedor.btnInserirClick(Sender: TObject);
begin
  inherited;
  if ibqCadastro.State in [dsInsert, dsEdit] then
    ibqCadastro.FieldByName('ATIVO').AsString := 'A';
end;

end.
