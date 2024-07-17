import 'package:flutter/material.dart';

enum StatusMinhasTransferenciasEnum{
  APROVADO(Colors.green, true, 'Aprovado'),
  AGUARDANDO_APROVACAO(Colors.amber, false, 'Aguardando Aprovação'),
  REJEITADO(Colors.red, false, 'Rejeitado');

  final Color corStatus;
  final bool mostrarComprovante;
  final String status;
  const StatusMinhasTransferenciasEnum(this.corStatus, this.mostrarComprovante, this.status);
}