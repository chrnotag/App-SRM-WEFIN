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
}