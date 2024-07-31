enum SelecionarDataRelatorioEnum{
  LIQUIDACAO('Liquidados'),
  VENCIMENTO('Vencidos'),
  STATUS('Status');

  final String label;
  const SelecionarDataRelatorioEnum(this.label);
}