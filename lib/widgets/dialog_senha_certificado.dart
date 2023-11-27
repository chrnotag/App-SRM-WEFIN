import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/import_certificado_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificadode.dart';
import 'package:validatorless/validatorless.dart';
import '../core/constants/route_labels.dart';
import '../core/constants/themes/theme_configs.dart';

class DialogSenhaCertificado extends StatefulWidget {
  const DialogSenhaCertificado({Key? key}) : super(key: key);

  @override
  State<DialogSenhaCertificado> createState() => _DialogSenhaCertificadoState();
}

class _DialogSenhaCertificadoState extends State<DialogSenhaCertificado> {
  final formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ImportarCertificadoProvider provider =
        context.watch<ImportarCertificadoProvider>();
    return AlertDialog(
      icon: const Icon(
        Icons.lock_outline_rounded,
        color: AppColors.botaoEnvio,
        size: 50,
      ),
      title: Form(
        key: formKey,
        child: TextFormField(
            onTap: () => provider.limparErro(),
            validator: Validatorless.multiple([
              Validatorless.required(
                  'Por favor, informe a senha do certificado.'),
              (value) => provider.errorMsg
            ]),
            controller: textController,
            decoration: InputDecoration(
                hintText: 'Informe a senha do certificado.',
                labelText: 'Infore a senha do certificado',
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
      ),
      actions: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        provider.senhaCertificado = textController.text;
                        provider.importarCertificado();
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.botaoEnvio,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Confirmar',
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Modular.to.navigate(AppRoutes.importarCertificadoRoute);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                                color: AppColors.botaoEnvio, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cancelar',
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
