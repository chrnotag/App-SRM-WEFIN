import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum RelatorioEnum {
  @JsonValue('A VENCER')
  A_VENCER('A Vencer', Color(0x2246a0ea), Color(0xff3629B7), Icons.download),

  @JsonValue('VENCIDO')
  VENCIDO('Vencido', Color(0xffF9EEEE), Color(0xffBF5151), Icons.download),

  @JsonValue('LIQUIDADO')
  LIQUIDADO('Liquidado', Color(0xffEEF8EE), Color(0xff4CB04E), null);

  final String titulo;
  final Color corFundo;
  final Color corTexto;
  final IconData? icone;

  const RelatorioEnum(this.titulo, this.corFundo, this.corTexto, this.icone);
}