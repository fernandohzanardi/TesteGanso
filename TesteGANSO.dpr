program TesteGANSO;

uses
  Vcl.Forms,
  uMenuPrincipal in 'uMenuPrincipal.pas' {frmMenuPrincipal},
  uConexao in 'uConexao.pas' {dmConexao: TDataModule},
  uFuncoesCadastro in 'uFuncoesCadastro.pas',
  uVendas in 'uVendas.pas' {frmVendas},
  uInserirAlterarItens in 'uInserirAlterarItens.pas' {frmInserirAlterarItens},
  uCalculaFuncoesFinanceiras in 'uCalculaFuncoesFinanceiras.pas',
  uServicoFinanceiro in 'uServicoFinanceiro.pas',
  uCadastroPadrao in 'uCadastroPadrao.pas' {frmCadastroPadrao},
  uCadastroCliente in 'uCadastroCliente.pas' {frmCadastroClientes},
  uCadastroProdutos in 'uCadastroProdutos.pas' {frmCadastroProdutos},
  uCadastroFormaPagamento in 'uCadastroFormaPagamento.pas' {frmCadastroFormaPagamento},
  uCadastroCentroCusto in 'uCadastroCentroCusto.pas' {frmCadastroCentroCusto},
  uCadastroContaBancaria in 'uCadastroContaBancaria.pas' {frmCadastroContaBancaria},
  uCadastroFornecedor in 'uCadastroFornecedor.pas' {frmCadastroFornecedor},
  uVendaPagamento in 'uVendaPagamento.pas' {frmVendaPagamento},
  uMovimentoCaixa in 'uMovimentoCaixa.pas' {frmMovimentoCaixa},
  uContasReceber in 'uContasReceber.pas' {frmContasReceber},
  uContasPagar in 'uContasPagar.pas' {frmContasPagar},
  uFechamentoCaixa in 'uFechamentoCaixa.pas' {frmFechamentoCaixa},
  uConciliacaoBancaria in 'uConciliacaoBancaria.pas' {frmConciliacaoBancaria},
  uFluxoCaixa in 'uFluxoCaixa.pas' {frmFluxoCaixa},
  uRelFichaCliente in 'uRelFichaCliente.pas' {dmRelFichaCliente: TDataModule},
  uEnvioMensagens in 'uEnvioMensagens.pas',
  uConfigSMTP in 'uConfigSMTP.pas' {frmConfiguracaoSMTP},
  uLogEnvioEmail in 'uLogEnvioEmail.pas' {frmLogEnvioEmail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);
  Application.Run;
end.
