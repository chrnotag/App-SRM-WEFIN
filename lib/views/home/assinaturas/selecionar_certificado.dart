import 'package:crosspki/crosspki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/finalizar_assinatura/finalizar_assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import '../../../core/constants/tema_configs.dart';

part 'widgets/popup_deletar_certificado.dart';

class SelecionarCertificado extends StatefulWidget {
  const SelecionarCertificado({super.key});

  @override
  State<SelecionarCertificado> createState() => _SelecionarCertificadoState();
}

class _SelecionarCertificadoState extends State<SelecionarCertificado> {
  @override
  Widget build(BuildContext context) {
    final CertificadoProvider certificadoProvider =
        context.watch<CertificadoProvider>();
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    return AlertDialog(
      title: Column(
        children: [
          Text(
              'Assinar Operação ${assinaturaProvider.assinaturaSelecionada!.codigoOperacao}',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                letterSpacing: 1.5.sp,
              )),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Text(
                'Confirme se está tudo correto. Então aperte o botão \"Assinar Operação\" para prosseguir.',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.labelText)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
            child: ListTile(
              title: Column(
                children: [
                  Divider(),
                  Text(
                    "${certificadoProvider.certificadoAtual?.subjectDisplayName ?? "Certificado sem nome"}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: certificadoProvider.certificadoAtual != null
                        ? () async {
                            OverlayApp.iniciaOverlay(context);
                            FinalizarAssinaturaProvider finalizarAssinatura =
                                Modular.get<FinalizarAssinaturaProvider>();
                            await finalizarAssinatura.finalizarAssinatura();
                            OverlayApp.terminaOverlay();
                          }
                        : null,
                    label: "Assinar Documento",
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              'Ou',
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.labelText),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: BotaoPadrao(
                  onPressed: () {
                    Modular.to.pushNamed(AppRoutes.importarCertificadoRoute);
                    Modular.to.pop();
                  },
                  label: 'Substituir Certificado',
                  filled: false,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
