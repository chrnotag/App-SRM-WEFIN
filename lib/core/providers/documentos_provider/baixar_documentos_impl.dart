import 'dart:developer';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/documentos_provider/baixar_documentos_provider.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:modular_study/core/utils/abrirPastasSistema.dart';
import 'package:modular_study/core/utils/handle_permissions.dart';
import 'package:modular_study/main.dart';
import 'package:modular_study/widgets/popup_generico.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:path/path.dart' as path;
import 'package:modular_study/models/documento_model.dart';
import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../constants/endpoints.dart';
import '../../implementations_config/api_response.dart';

class BaixarDocumentosImpl {
  final Documento documento;
  final isVisualizar;

  BaixarDocumentosImpl({required this.documento, required this.isVisualizar});

  Future<ApiResponse<dynamic>> baixar() async {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    AuthProvider authProvider = Modular.get<AuthProvider>();
    log('token: ${authProvider.dataUser!.token}\niddocmetno: ${documento.idAssinaturaDigital}');
    final header = {
      'accept': 'application/json',
      'plataforma': themeProvider.temaSelecionado.name,
      'Authorization': authProvider.dataUser!.token,
      'Content-Type': 'application/json',
    };
    BaixarDocumentosProvider baixarDocumentosProvider =
        Modular.get<BaixarDocumentosProvider>();
    final url = Uri.parse(
        "${EndPoints.assinatura}/${documento.idAssinaturaDigital}/arquivo?visualizar=$isVisualizar");
    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        if (!isVisualizar) {
          try {
            bool isPermitido = await HandlePermissions.permissionStorage();
            if (isPermitido) {
              String? downloadPath =
                  await ExternalPath.getExternalStoragePublicDirectory(
                      ExternalPath.DIRECTORY_DOWNLOADS);
              String fileName = "${documento.nome}.pdf";
              String fullPath = path.join(downloadPath!, fileName);
              File file = File(fullPath);
              await file.writeAsBytes(response.bodyBytes);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                showDialog(
                  context: myNavigatorKey.currentState!.context,
                  builder: (context) => AlertDialogGenerico(
                      title: 'Sucesso',
                      msg: 'Seu arquivo foi salvo na sua pasta de downloads.',
                      onPressed: () {Modular.to.pop();},
                      icon: Icons.check_circle_outline),
                );
              });
              return SucessResponse(
                  'Arquivo baixado com sucesso para $fullPath');
            }
            return SucessResponse(null);
          } catch (e, stacktrace) {
            log('erro:$e\n\n$stacktrace');
            return SucessResponse(null);
          }
        } else {
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          final data = DocumentoModel.fromJson(responseBody);
          baixarDocumentosProvider.urlDocumento = data.url;
          return SucessResponse(data);
        }
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = ExceptionModel.fromJson(responseBody);
        return ErrorResponse(data);
      }
    } catch (_) {
      final data = ExceptionModel(
          codigo: '500',
          dataHora: DateTime.now(),
          httpStatus: 'INTERNAL_SERVER_ERROR',
          mensagem: 'Desculpe, algo deu errado em nosso servidor.');
      return ErrorResponse(data);
    }
  }
}
