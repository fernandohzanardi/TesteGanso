unit uCadastroCentroCusto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, IBX.IBCustomDataSet,
  IBX.IBUpdateSQL, Data.DB, IBX.IBQuery, IBX.IBDatabase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadastroCentroCusto = class(TfrmCadastroPadrao)
    lCodigo: TLabel;
    lDescricao: TLabel;
    dbeCodigo: TDBEdit;
    dbeDescricao: TDBEdit;
    dbcAtivo: TDBCheckBox;
    ibqCadastroCODIGO: TIntegerField;
    ibqCadastroDESCRICAO: TIBStringField;
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
  frmCadastroCentroCusto: TfrmCadastroCentroCusto;

implementation

{$R *.dfm}

uses
  uConexao;

procedure TfrmCadastroCentroCusto.FormActivate(Sender: TObject);
begin
  try
    ibqCadastro.Open;
  except
    ShowMessage('Conexao falhou!');
  end;
end;

procedure TfrmCadastroCentroCusto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroCentroCusto := Nil;
end;

procedure TfrmCadastroCentroCusto.btnInserirClick(Sender: TObject);
begin
  inherited;
  if ibqCadastro.State in [dsInsert, dsEdit] then
    ibqCadastro.FieldByName('ATIVO').AsString := 'A';
end;

end.
