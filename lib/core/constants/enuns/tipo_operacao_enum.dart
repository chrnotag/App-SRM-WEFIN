import 'dart:ui';
import 'package:flutter/material.dart';

enum TipoTED {
  RECEBIMENTO_TED(Color(0xfff3f7ff), 'Recebimento TED', Color(0xff0e6dfe)),
  ENVIO_TED(Color(0xfffdf7f6), 'Transferencia TED', Color(0xffe6492d)),
  DEVOLUCAO_TED(Color(0xfff3f7ff), 'Devolução', Color(0xff0e6dfe)),
  TARIFA_TED(Color(0xfffdf7f6), 'Transferencia TED', Color(0xffe6492d));

  final Color corFundo;
  final String stringTED;
  final Color corTexto;

  const TipoTED(this.corFundo, this.stringTED, this.corTexto);

  Color get getCor => this.corFundo;

  String get getStringTED => this.stringTED;

  static TipoTED fromCodigo(String codigo) {
    switch (codigo) {
      case 'EFT':
      case 'TEDC':
      case 'TIC':
        return TipoTED.RECEBIMENTO_TED;
      case 'TARTED':
        return TipoTED.TARIFA_TED;
      case 'DEV':
        return TipoTED.DEVOLUCAO_TED;
      case 'TEDD':
      case 'ENV':
      case 'TID':
        return TipoTED.ENVIO_TED;
      default:
        throw ArgumentError('Código TED inválido: $codigo');
    }
  }
}
