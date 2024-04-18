import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/tema_configs.dart';
import 'package:Srm_Asset/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/certificado_provider.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validatorless/validatorless.dart';
import '../core/constants/AppSizes.dart';

class DialogSenhaCertificado extends StatefulWidget {
  const DialogSenhaCertificado({Key? key}) : super(key: key);

  @override
  State<DialogSenhaCertificado> createState() => _DialogSenhaCertificadoState();
}

class _DialogSenhaCertificadoState extends State<DialogSenhaCertificado> {
  final formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    final CertificadoProvider provider = context.watch<CertificadoProvider>();
    return SingleChildScrollView(
        child: AlertDialog(
          title: SizedBox(
            width: context.width * 0.8,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Modular.to.pop(),
                    ),
                  ],
                ),
                SvgPicture.asset(Assets.senha_certificado_dialog),
                Text('Senha do Certificado Digital',
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.black)),
                Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.paddingLarge.h),
                  child: Text(
                      'No campo abaixo, Insira a senha do seu Certificado Digital.',
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.cinzaEscuro,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Senha do certificado',
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: Colors.black),
                      )),
                    ],
                  ),
                ),
                Form(
                  onChanged: () => provider.limparErro(),
                  key: formKey,
                  child: TextFormField(
                    onChanged: (_) => provider.limparErro(),
                    decoration: InputDecoration(
                        hintText: "Senha",
                        hintStyle: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.labelText),
                        focusColor: context.focusColor,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: context.focusColor, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.labelText,
                            size: 25.r,
                          ),
                        )),
                    validator: Validatorless.multiple([
                      Validatorless.required(
                          'Por favor, informe a senha do certificado.'),
                      (value) => provider.errorMsg
                    ]),
                    obscureText: _isObscured,
                    controller: textController,
                  ),
                ),
              ],
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
                        textStyleFilled: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
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
                        textStyleNoFilled: context.textTheme.bodyMedium!.copyWith(
                            color: context.focusColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
  }
}
