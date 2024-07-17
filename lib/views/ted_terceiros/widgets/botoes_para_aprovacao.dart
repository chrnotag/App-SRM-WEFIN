import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/enuns/aprovar_ted_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_impl.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'alert_aprovacao_ted.dart';

class BotoesAprovarTedTerceiros extends StatelessWidget {
  final int codigoTransferencia;

  const BotoesAprovarTedTerceiros(
      {super.key, required this.codigoTransferencia});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          BotaoPadrao(
              label: 'Reprovar',
              filled: false,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => _AlertAprovacaoTed(
                      aprovacao: AprovarTedEnum.RECUSAR,
                      codigoTransferencia: codigoTransferencia),
                );
              }),
          SizedBox(
            width: 40.w,
          ),
          BotaoPadrao(
            label: 'Aprovar',
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _AlertAprovacaoTed(
                  aprovacao: AprovarTedEnum.APROVAR,
                  codigoTransferencia: codigoTransferencia),
            ),
          )
        ],
      ),
    );
  }
}
