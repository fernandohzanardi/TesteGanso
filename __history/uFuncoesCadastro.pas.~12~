unit uFuncoesCadastro;

interface


implementation

uses
  Data.DB, IBX.IBCustomDataSet;

 procedure ManutencaoBancoDados(DataSet: TIbDataSet);
 begin
{
  if (not DataSet.Transaction.InTransaction) then
    ibqCadastro.Transaction.StartTransaction;

   try
     if (DataSet.State in [dsInsert, dsEdit]) then
       DataSet.Post;

     DataSet.Transaction.Commit;
   Except

     DataSet.Transaction.Rollback;
   end;
}
 end;

end.
