import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/enuns/import_certificado_enum.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_textfield.dart';
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
      icon: Icon(
        Icons.lock_outline_rounded,
        color: context.primaryColor,
        size: 50,
      ),
      title: Form(
        key: formKey,
        child: WefinTextFormField(
          onTap: () => provider.limparErro(),
          label: "Senha do certificado",
          validator: Validatorless.multiple([
            Validatorless.required(
                'Por favor, informe a senha do certificado.'),
            (value) => provider.errorMsg
          ]),
          obscureText: true,
          controller: textController,
        ),
      ),
      actions: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        provider.senhaCertificado = textController.text;
                        provider.importarCertificado();
                      }
                    },
                    label: "Confirmar",
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
                  child: BotaoPadrao(
                    onPressed: () {
                      Modular.to.navigate(AppRoutes.assinaturaDigitalRoute);
                    },
                    label: "Cancelar",
                    filled: false,
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
