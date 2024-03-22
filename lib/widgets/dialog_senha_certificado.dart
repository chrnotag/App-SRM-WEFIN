import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:validatorless/validatorless.dart';
import '../core/constants/route_labels.dart';

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
        color: context.focusColor,
        size: 50.r,
      ),
      title: Form(
        onChanged: () => provider.limparErro(),
        key: formKey,
        child: TextFormField(
          onChanged: (_) => provider.limparErro(),
          decoration: const InputDecoration(
              hintText: "Senha do certificado",
              labelText: "Senha do Certificado",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1))),
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
                        provider.importarCertificado(context);
                      }
                    },
                    label: "Confirmar",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                  child: BotaoPadrao(
                    onPressed: () {
                      Modular.to.pop();
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
