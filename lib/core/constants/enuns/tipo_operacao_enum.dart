import 'dart:ui';
import 'package:flutter/material.dart';

enum TipoTED {
  RECEBIMENTO_TED(Color(0XFFf3f7ff), 'Recebimento TED'),
  ENVIO_TED(Color(0XFFfdf7f6), 'Transferencia TED');

  final Color cor;
  final String stringTED;

  const TipoTED(this.cor, this.stringTED);

  Color get getCor => this.cor;
  String get getStringTED => this.stringTED;

  static TipoTED fromCodigo(String codigo) {
    switch (codigo) {
      case 'EFT':
      case 'DEV':
      case 'TEDC':
        return TipoTED.RECEBIMENTO_TED;
      case 'TEDD':
      case 'TARTED':
      case 'ENV':
      case 'TID':
        return TipoTED.ENVIO_TED;
      default:
        throw ArgumentError('Código TED inválido: $codigo');
    }
  }
}
