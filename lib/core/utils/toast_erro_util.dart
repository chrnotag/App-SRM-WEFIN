import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, ApiResponse<dynamic> response) {
  Fluttertoast.showToast(
    msg: '$msg: ${response.error.mensagem}',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
