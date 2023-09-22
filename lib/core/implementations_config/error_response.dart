import 'package:modular_study/core/implementations_config/api_response.dart';
import 'package:modular_study/models/exceptions_responses/exception_model.dart';

class ErrorResponse extends ApiResponse<ExceptionModel> {
  ErrorResponse(ExceptionModel data) : super(null, data);
}
