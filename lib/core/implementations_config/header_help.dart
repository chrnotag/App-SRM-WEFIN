import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';

Map<String, String> header() {
  final authProvider = Modular.get<AuthProvider>();
  final ambiente = Modular.get<Environment>();
  return {
    'Content-Type': 'application/json; charset=utf-8',
    'accept': 'application/json',
    'plataforma': ambiente.plataforma.name,
    'Authorization': 'Bearer ${authProvider.dataUser?.token}' ?? '',
  };
}
