import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_impl.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/views/ted_terceiros/widgets/visualizar_pdf_ted.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BotaoComprovanteTedTerceiros extends StatelessWidget {
  final int codigoTransacao;

  const BotaoComprovanteTedTerceiros(
      {super.key, required this.codigoTransacao});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: 330.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BotaoPadrao(
                label: 'Comprovante',
                filled: true,
                onPressed: () async {
                  OverlayApp.iniciaOverlay(context);
                  final result = await TedTerceirosImpl.downloadComprovante(
                      '$codigoTransacao');
                  OverlayApp.terminaOverlay();
                  if (result.error != null) {
                    Fluttertoast.showToast(
                        msg:
                            'Houve um erro ao tentar obter o comprovante: ${result.error.mensagem}');
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VisualizarPdfTed(),
                        ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
