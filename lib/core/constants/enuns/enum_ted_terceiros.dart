import 'package:Srm_Asset/views/ted_terceiros/widgets/botao_comprovante.dart';
import 'package:Srm_Asset/views/ted_terceiros/widgets/botoes_para_aprovacao.dart';
import 'package:flutter/material.dart';

enum TedTerceirosEnum {
  PARA_APROVACAO(Color(0xfff3f7ff), 'Para Aprovação', Color(0xff0e6dfe)),
  PAGO(Color(0xffDAFADA), 'Aprovado', Color(0xff4CB04E)),
  SOLICITADO(Colors.white, 'Solicitado', Color(0xffE1C11A)),
  REJEITADO(Color(0xfffdf7f6), 'Recusado', Color(0xffe6492d));

  final Color corFundo;
  final Color corTexto;
  final String status;

  const TedTerceirosEnum(this.corTexto, this.status, this.corFundo,);

  Color get getCorFundo => corFundo;

  Color get getCorTexto => corTexto;

  String get getStatus => status;

  static TedTerceirosEnum fromStatus(String status) {
    switch (status) {
      case 'SOLICITADO':
        return TedTerceirosEnum.SOLICITADO;
      case 'REJEITADO':
        return TedTerceirosEnum.REJEITADO;
      case 'PARA_APROVACAO':
        return TedTerceirosEnum.PARA_APROVACAO;
      case 'APROVADO':
        return TedTerceirosEnum.PAGO;
      default:
        throw ArgumentError('Status inválido: $status');
    }
  }
}
