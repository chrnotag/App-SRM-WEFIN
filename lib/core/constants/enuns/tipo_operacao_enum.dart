import 'dart:ui';
import 'package:flutter/material.dart';

enum TipoTED {
  RECEBIMENTO_TED(Color(0XFFE57373FF), 'Recebimento TED'),
  ENVIO_TED(Color(0XFF81C784FF), 'Transferencia TED');
  final Color cor;
  final String stringTED;
  const TipoTED(this.cor, this.stringTED);
  Color get getCor => this.cor;
  String get getStringTED => this.stringTED;
}