import 'dart:convert';
import 'package:Srm_Asset/core/implementations_config/error_response.dart';

import '../../models/exceptions_responses/exception_model.dart';

class MensagemErroPadrao {
  static ErrorResponse codigo_500() {
    final data = ExceptionModel(
        codigo: '500',
        dataHora: DateTime.now(),
        httpStatus: 'INTERNAL_SERVER_ERROR',
        mensagem: 'Desculpe, algo deu errado em nosso servidor.');
    return ErrorResponse(data);
  }

  static ErrorResponse erroResponse(List<int> bodyBytes){
    final responseBody = json.decode(utf8.decode(bodyBytes));
    final data = ExceptionModel.fromJson(responseBody);
    return ErrorResponse(data);
  }
}
