import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RelatorioEnum {
  A_VENCER('A Vencer', Color(0x2246a0ea), Color(0xff3629B7)),
  VENCIDO('Vencido', Color(0xffF9EEEE), Color(0xffBF5151)),
  LIQUIDADO('Liquidado', Color(0xffEEF8EE), Color(0xff4CB04E));

  final String titulo;
  final Color corFundo;
  final Color corTexto;

  const RelatorioEnum(this.titulo, this.corFundo, this.corTexto);
}
