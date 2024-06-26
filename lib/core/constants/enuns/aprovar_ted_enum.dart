import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum AprovarTedEnum{
  APROVAR(''),
  RECUSAR('');

  final String urlAprovacao;
  const AprovarTedEnum(this.urlAprovacao);
  String get getUrlAprovacao => this.urlAprovacao;
}