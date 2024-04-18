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
import '../../../core/constants/AppSizes.dart';

part 'widgets/popup_deletar_certificado.dart';

class SelecionarCertificado extends StatefulWidget {
  const SelecionarCertificado({super.key});

  @override
  State<SelecionarCertificado> createState() => _SelecionarCertificadoState();
}

class _SelecionarCertificadoState extends State<SelecionarCertificado> {
  late Future<List<PKCertificate>> _certificadoFuture;

  @override
  void initState() {
    _carregarCertificado();
    super.initState();
  }

  Future<void> _carregarCertificado() async {
    final certificados = CrossPki.listCertificatesWithKey();
    setState(() {
      _certificadoFuture = certificados;
    });
  }

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
              'Assinar Operação ${assinaturaProvider.assinaturaSelecionada!
                  .codigoOperacao}',
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
            child: Column(
              children: [
                Divider(),
                ListTile(
                  title: FutureBuilder(
                    future: _certificadoFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                              color: context.focusColor,
                              strokeWidth: 2.w,
                            ));
                      }
                      if (snapshot.hasError) {
                        return const Text(
                            "Houve um erro ao carregar os certificados.");
                      }
                      return Text(
                        "${snapshot.data!.first.subjectDisplayName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                      ;
                    },
                  ),
                  trailing: FloatingActionButton.small(
                      onPressed: () {
                        if(certificadoProvider.certificadoAtual != null) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                              PopUpDeletarCertificado(
                                  context: context,
                                  certificado: certificadoProvider
                                      .certificadoAtual!,
                                  title: "Excluir Certificado",
                                  label:
                                  "Deseja excluir o certificado ${certificadoProvider
                                      .certificadoAtual!.subjectDisplayName}?")
                                  .popUp).then((_) => Modular.to.pop());
                        }else{
                          Modular.to.pop();
                        }
                      },
                      backgroundColor: AppColors.vermelho,
                      elevation: 0,
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      )),
                ),
                Divider()
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: () async {
                      OverlayApp.iniciaOverlay(context);
                      FinalizarAssinaturaProvider finalizarAssinatura =
                      Modular.get<FinalizarAssinaturaProvider>();
                      await finalizarAssinatura.finalizarAssinatura();
                      OverlayApp.terminaOverlay();
                    },
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
