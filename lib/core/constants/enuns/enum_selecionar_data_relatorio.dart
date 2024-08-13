import 'package:Srm_Asset/core/constants/enuns/relatorio_enum.dart';

enum SelecionarDataRelatorioEnum{
  LIQUIDACAO('Liquidados', RelatorioEnum.LIQUIDADO),
  VENCIMENTO('Vencidos', RelatorioEnum.VENCIDO),
  STATUS('Status', null);

  final String label;
  final RelatorioEnum? relatorioEnum;
  const SelecionarDataRelatorioEnum(this.label, this.relatorioEnum);
}