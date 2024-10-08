import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_geral/conta_digital_impl.dart';
import 'package:Srm_Asset/core/providers/conta_digital/saldo/conta_digital_saldo_impl.dart';
import 'package:Srm_Asset/models/conta_digital/geral/conta_digital.dart';
import 'package:Srm_Asset/models/conta_digital/saldo/saldo_conta_digital.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../implementations_config/api_response.dart';

class ContaDigitalProvider extends ChangeNotifier{

  Future<dynamic> obterDadosContaDigital() async => await ContaDigitalImpl.pegarDadosContaDigital();

  Future<ApiResponse<dynamic>> carregarSaldo(String conta) async {
    final response = await ContaDigitalSaldoImpl.resgatarSaldo(conta);
    notifyListeners();
    return response;
  }

  ContaDigitalModel? _dadosContaDigital;
  ContaDigitalModel? get dadosContaDigital => _dadosContaDigital;
  set dadosContaDigital(ContaDigitalModel? dados){
    _dadosContaDigital = dados;
    notifyListeners();
  }
  SaldoContaDigitalModel? _saldoContaDigital;
  SaldoContaDigitalModel? get saldoContaDigital => _saldoContaDigital;
  set saldoContaDigital(SaldoContaDigitalModel? saldo){
    _saldoContaDigital = saldo;
    notifyListeners();
  }

  Future<void> obterSaldoContaDigital() async{
    if(dadosContaDigital != null){
      final saldoConta = await ContaDigitalSaldoImpl.resgatarSaldo(dadosContaDigital!.conta);
      if(saldoConta.error != null){
        saldoContaDigital = saldoConta.data;
      }
    }
  }
}