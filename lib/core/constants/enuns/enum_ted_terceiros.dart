import 'package:Srm_Asset/views/ted_terceiros/widgets/botao_comprovante.dart';
import 'package:Srm_Asset/views/ted_terceiros/widgets/botoes_para_aprovacao.dart';
import 'package:flutter/material.dart';

enum TedTerceirosEnum {
  PARA_APROVACAO(Color(0xfff3f7ff), 'Para Aprovação', Color(0xff0e6dfe), BotoesAprovarTedTerceiros()),
  APROVADO(Color(0xffDAFADA), 'Aprovado', Color(0xff4CB04E), BotaoComprovanteTedTerceiros()),
  SOLICITADO(Colors.white, 'Solicitado', Color(0xffE1C11A), null),
  RECUSADO(Color(0xfffdf7f6), 'Recusado', Color(0xffe6492d), null);

  final Color corFundo;
  final Color corTexto;
  final String status;
  final Widget? botoes;

  const TedTerceirosEnum(this.corTexto, this.status, this.corFundo, this.botoes);

  Color get getCorFundo => this.corFundo;

  Color get getCorTexto => this.corTexto;

  String get getStatus => this.status;

  static TedTerceirosEnum fromStatus(String status) {
    switch (status) {
      case 'SOLICITADO':
        return TedTerceirosEnum.SOLICITADO;
      case 'REJEITADO':
        return TedTerceirosEnum.RECUSADO;
      case 'PARA_APROVACAO':
        return TedTerceirosEnum.PARA_APROVACAO;
      case 'APROVADO':
        return TedTerceirosEnum.APROVADO;
      default:
        throw ArgumentError('Status inválido: $status');
    }
  }
}
