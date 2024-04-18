import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_geral/conta_digital_impl.dart';
import 'package:Srm_Asset/core/providers/conta_digital/saldo/conta_digital_saldo_impl.dart';
import 'package:Srm_Asset/models/conta_digital/geral/conta_digital.dart';
import 'package:flutter/cupertino.dart';

class ContaDigitalProvider extends ChangeNotifier{

  Future<dynamic> obterDadosContaDigital() async => await ContaDigitalImpl.pegarDadosContaDigital();

  ContaDigitalModel? _dadosContaDigital;
  ContaDigitalModel? get dadosContaDigital => _dadosContaDigital;
  set dadosContaDigital(ContaDigitalModel? dados){
    _dadosContaDigital = dados;
    notifyListeners();
  }

  Future<dynamic> obterSaldoContaDigital() async{
    if(dadosContaDigital != null){
      return await ContaDigitalSaldoImpl.resgatarSaldo(dadosContaDigital!.conta);
    }
  }
}