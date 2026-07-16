unit uCalculaFuncoesFinanceiras;

interface

type
  TUcalculaFuncFinan = class

  private

  public
    class function CalculaTotalLiquido(Valor, PercDesc, PercAcresc: Currency): Currency; static;
    class function CalculaTotalLiquidoBruto(Valor, PercDesc, PercAcresc: Currency): Currency; static;
    class function CalculaPercLucro(ValorCusto, ValorVenda: Currency): Currency; static;
  end;

implementation

class function TUcalculaFuncFinan.CalculaTotalLiquido (Valor, PercDesc, PercAcresc : Currency): Currency;
begin
  Result := (Valor * (1 - PercDesc / 100)) * (1 + PercAcresc / 100);
end;

class function TUcalculaFuncFinan.CalculaTotalLiquidoBruto (Valor, PercDesc, PercAcresc : Currency): Currency;
begin
  Result := Valor - (valor * PercDesc / 100) + (valor * PercAcresc / 100);
end;

class function TUcalculaFuncFinan.CalculaPercLucro (ValorCusto, ValorVenda: Currency): Currency;
begin
  if ValorVenda = 0 then
    Result := 0
  else
    Result := ((ValorVenda - ValorCusto) / ValorVenda) * 100;
end;

end.
