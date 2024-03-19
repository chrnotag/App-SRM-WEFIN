import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/models/exceptions_responses/exception_model.dart';

class ErrorResponse extends ApiResponse<ExceptionModel> {
  ErrorResponse(ExceptionModel data) : super(null, data);
}
