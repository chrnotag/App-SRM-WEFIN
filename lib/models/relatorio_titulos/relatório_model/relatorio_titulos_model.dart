import 'package:Srm_Asset/core/constants/enuns/relatorio_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'relatorio_titulos_model.g.dart';

@JsonSerializable()
class ListaTitulos {
  final List<Titulo> listaTitulos;
  ListaTitulos({required this.listaTitulos});

  factory ListaTitulos.fromJson(Map<String, dynamic> json) => _$ListaTitulosFromJson(json);

  Map<String, dynamic> toJson() => _$ListaTitulosToJson(this);
}

@JsonSerializable()
class Titulo {
  final String codigoOperacao;
  final DateTime? dataLiquidacao;
  final DateTime dataVencimento;
  final String documento;
  final int id;
  final String identificadorCedente;
  final String identificadorSacado;
  final bool kgfinPos;
  final String nomeSacado;
  final String? notaFiscal;
  final String produto;
  final RelatorioEnum status;
  final double valor;

  Titulo({
    required this.codigoOperacao,
    this.dataLiquidacao,
    required this.dataVencimento,
    required this.documento,
    required this.id,
    required this.identificadorCedente,
    required this.identificadorSacado,
    required this.kgfinPos,
    required this.nomeSacado,
    this.notaFiscal,
    required this.produto,
    required this.status,
    required this.valor,
  });

  factory Titulo.fromJson(Map<String, dynamic> json) => _$TituloFromJson(json);

  Map<String, dynamic> toJson() => _$TituloToJson(this);
}
