import 'dart:convert';
import 'dart:io';
import 'package:Srm_Asset/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/utils/mensagem_erro_requisicao.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/documento_model.dart';
import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../../widgets/popup_generico.dart';
import '../../constants/classes_abstratas/envirioment.dart';
import '../../implementations_config/api_response.dart';
import '../../implementations_config/export_impl.dart';
import '../../providers/documentos_provider/baixar_documentos_provider.dart';

class BaixarDocumentosImpl {
  final Documento documento;
    Environment ambiente = Modular.get<Environment>();

  BaixarDocumentosImpl({required this.documento});

  Map<String, String> header() {
    AuthProvider authProvider = Modular.get<AuthProvider>();
    final header = {
      'accept': 'application/json',
      'plataforma': ambiente.plataforma.name,
      'Authorization': authProvider.dataUser!.token,
      'Content-Type': 'application/json',
    };

    return header;
  }

  Future<ApiResponse<dynamic>> ler() async {
    Uri url = ambiente.endpoints.montarUrlBaixarDocumento(documento.idAssinaturaDigital!, true);
    BaixarDocumentosProvider baixarDocumentosProvider =
    Modular.get<BaixarDocumentosProvider>();
    try {
      var response = await http.get(url, headers: header());
      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final data = DocumentoModel.fromJson(responseBody);
        baixarDocumentosProvider.urlDocumento = data.url;
        return SucessResponse(data);
      } else {
        baixarDocumentosProvider.urlDocumento = null;
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }
    } catch (_) {
      baixarDocumentosProvider.urlDocumento = null;
      return MensagemErroPadrao.codigo500();
    }
  }

  Future<ApiResponse<dynamic>> baixar() async {
    Uri url = ambiente.endpoints.montarUrlBaixarDocumento(documento.idAssinaturaDigital!, false);
    try {
      var downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory == null) {
        return MensagemErroPadrao.codigo500();
      }

      var response = await http.get(url, headers: header());
      if (response.statusCode != 200) {
        return MensagemErroPadrao.erroResponse(response.bodyBytes);
      }

      File file = File('${downloadsDirectory.path}/${documento.nome}.pdf');
      await file.writeAsBytes(response.bodyBytes);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: myNavigatorKey.currentState!.context,
          builder: (context) => AlertDialogGenerico(
            title: 'Download Concluído',
            msg: 'Seu arquivo foi salvo em "${downloadsDirectory.path}/${documento.nome}.pdf"',
            onPressed: () => Modular.to.pop(),
          ),
        );
      });

      return SucessResponse(null);
    } catch (_) {
      return MensagemErroPadrao.codigo500();
    }
  }
}