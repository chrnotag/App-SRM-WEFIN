import 'package:Srm_Asset/core/constants/enuns/aprovar_ted_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_impl.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';

class BotoesAprovarTedTerceiros extends StatelessWidget {
  final String codigoTransferencia;

  const BotoesAprovarTedTerceiros(
      {super.key, required this.codigoTransferencia});

  @override
  Widget build(BuildContext context) {
    void aprovarOuRecusar(AprovarTedEnum aprovarTedEnum) {
      TedTerceirosImpl.aprovarOuRecusar(aprovarTedEnum, codigoTransferencia);
    }

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          BotaoPadrao(
              label: 'Reprovar',
              filled: false,
              onPressed: () => aprovarOuRecusar(AprovarTedEnum.RECUSAR)),
          SizedBox(
            width: 40.w,
          ),
          BotaoPadrao(
              label: 'Aprovar',
              onPressed: () => aprovarOuRecusar(AprovarTedEnum.APROVAR))
        ],
      ),
    );
  }
}
