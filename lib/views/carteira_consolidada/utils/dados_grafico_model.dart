import 'dart:ui';

class DadosGraficoModel{
  final String titulo;
  final Color cor;
  final double? valor;
  final String porcentagem;
  final int? qtdTitulos;
  const DadosGraficoModel({required this.titulo, required this.cor, this.valor = 0, required this.porcentagem, this.qtdTitulos = 0});
}