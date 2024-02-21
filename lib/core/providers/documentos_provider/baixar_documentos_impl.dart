import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:media_storage/media_storage.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/documentos_provider/baixar_documentos_provider.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/utils/handle_permissions.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:Srm_Asset/main.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:path/path.dart' as path;
import 'package:Srm_Asset/models/documento_model.dart';
import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../constants/endpoints.dart';
import '../../implementations_config/api_response.dart';

class BaixarDocumentosImpl {
  final Documento documento;

  BaixarDocumentosImpl({required this.documento});

  Map<String, String> header() {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    AuthProvider authProvider = Modular.get<AuthProvider>();
    log('token: ${authProvider.dataUser!.token}\niddocmetno: ${documento.idAssinaturaDigital}');
    final header = {
      'accept': 'application/json',
      'plataforma': themeProvider.temaSelecionado.name,
      'Authorization': authProvider.dataUser!.token,
      'Content-Type': 'application/json',
    };

    return header;
  }

  Uri get url => Uri.parse(
      "https://signer.srmasset.com/api/documents/9128d0b9-fe53-4e40-ba09-e47fdc5fcc33/original?access_ticket=CfDJ8Pf-kfXXE6tAq6WYmfveFyQaRpkwMzEkqX-Dq5KNyPIrC62HaMpmpCJXkhUVCZdqwBVSy9EdexHwQ_cZDzrovgu-EXMvlPZOP1Ugpt3dNPcBEkC9PSKD1nwnkB8xFlZbQ2SclHuHB3bp1Vh6sQ99k68ebuK6ynKysbMwP6eN22IcGslcxYuHZvcXpcb8mpcOR0DfUzO__ggDqJ21tP4CJJc&culture=pt");

  Future<ApiResponse<dynamic>> ler() async {
    BaixarDocumentosProvider baixarDocumentosProvider =
        Modular.get<BaixarDocumentosProvider>();
    try {
      var response = await http.get(url, headers: header());
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = DocumentoModel.fromJson(responseBody);
        baixarDocumentosProvider.urlDocumento = url.toString();
        return SucessResponse(data);
      } else {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      return MensagemErroPadrao.codigo_500();
    }
  }

  Future<ApiResponse<dynamic>> baixar() async {
    final dio = Dio();
    bool permissaoConcedida = await HandlePermissions.permissionStorage();
    if (permissaoConcedida) {
      var path = await MediaStorage.getExternalStoragePublicDirectory(
          MediaStorage.DIRECTORY_DOWNLOADS);
      try {
        var response = await http.get(url, headers: header());
        File file = File('$path/documento-baixado.pdf');
        await file.writeAsBytes(response.bodyBytes);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: myNavigatorKey.currentState!.context,
            builder: (context) => AlertDialogGenerico(
              title: 'Download Concluido',
              msg: 'Seu arquivo foi salvo em \"$path/${documento.nome}.pdf\"',
              onPressed: () => Modular.to.pop(),
            ),
          );
        });
        return SucessResponse(null);
      } catch (e, s) {
        log('erro ao baixar: $e \n $s');
        return MensagemErroPadrao.codigo_500();
      }
    }
    return MensagemErroPadrao.codigo_500();
  }
}
