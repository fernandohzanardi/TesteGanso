unit uRelFichaCliente;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase,
  IBX.IBCustomDataSet, IBX.IBQuery, frxClass, frxDBSet, frxIBXComponents ;

type
  TdmRelFichaCliente = class(TDataModule)
    IBTransactionRel: TIBTransaction;
    ibqCliente: TIBQuery;
    ibqClienteCODIGO: TIntegerField;
    ibqClienteNOME: TIBStringField;
    ibqClienteENDERECO: TIBStringField;
    ibqClienteBAIRRO: TIBStringField;
    ibqClienteCIDADE: TIBStringField;
    ibqClienteTELEFONE: TIBStringField;
    ibqClienteOBSERVACAO: TMemoField;
    ibqClienteRENDA_MENSAL: TIBBCDField;
    ibqClienteLIMITE_CREDITO: TIBBCDField;
    ibqClienteTOTAL_COMPRAS: TIBBCDField;
    ibqClienteSITUACAO: TIBStringField;
    frxCliente: TfrxDBDataset;
    frxRelatorio: TfrxReport;
  private
    procedure CarregarRelatorio;
  public
    procedure Imprimir(const pCodigo: Integer);
  end;

implementation

uses
  uConexao;

{$R *.dfm}
{$R RelFichaCliente.res}

procedure TdmRelFichaCliente.CarregarRelatorio;
var
  lStream: TResourceStream;
begin
  lStream := TResourceStream.Create(HInstance, 'RELFICHACLIENTE', RT_RCDATA);
  try
    frxRelatorio.LoadFromStream(lStream);
  finally
    lStream.Free;
  end;
end;

procedure TdmRelFichaCliente.Imprimir(const pCodigo: Integer);
begin
  ibqCliente.Close;
  ibqCliente.ParamByName('CODIGO').AsInteger := pCodigo;
  ibqCliente.Open;

  if (ibqCliente.IsEmpty) then
    Exit;

  CarregarRelatorio;
  frxRelatorio.ShowReport;
end;

end.
