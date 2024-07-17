import 'package:Srm_Asset/models/exceptions_responses/exception_model.dart';

abstract class ApiResponse<T> {
  final dynamic _data;
  final ExceptionModel? _error;

  get data => _data;

  get error => _error;

  ApiResponse(this._data, this._error);
}
