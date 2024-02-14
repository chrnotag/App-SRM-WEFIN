import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modular_study/core/constants/enuns/theme_enum.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/auth_provider_config/recuperar_senha/recuperar_senha_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/core/providers/theme_provider.dart';
import 'package:modular_study/core/utils/get_device_infos.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/models/recuperar_senha_model/recuperar_senha_model.dart';
import 'package:modular_study/models/user_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_textfield.dart';
import 'package:validatorless/validatorless.dart';
import '../generated/assets.dart';
import 'link_component.dart';

class AuthForm extends StatefulWidget {
  final String label;
  final bool visible;

  const AuthForm({super.key, this.label = 'Entrar', this.visible = true});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  String? _mensagemErro;

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WefinTextFormField(
            onTap: () => setState(() {
              _mensagemErro = null;
            }),
            label: 'Digite seu email',
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.email('Email inválido!'),
              Validatorless.required('Email Obrigatório'),
              (value) => _mensagemErro
            ]),
          ),
          SizedBox(height: 20.h),
          WefinTextFormField(
            onTap: () => _mensagemErro = null,
            maxLength: widget.visible ? 10 : null,
            label: widget.visible ? 'Digite sua Senha' : 'Digite seu CNPJ',
            obscureText: widget.visible,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required(
                  widget.visible ? 'Senha obrigatória' : 'CNPJ Obrigatório'),
              if (!widget.visible) Validatorless.cnpj('CNPJ Inválido!'),
              if (widget.visible)
                Validatorless.min(
                    3, 'Senha com no mínimo 3 e máximo 10 caracteres.'),
              (value) => _mensagemErro
            ]),
          ),
          SizedBox(height: 20.h),
          Visibility(
            visible: widget.visible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Alinha à direita
              children: [
                LinkComponent(
                  label: 'Esqueci minha senha!',
                  route: AppRoutes.forgetPassAuthRoute,
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),
          BotaoPadrao(
            label: widget.label,
            onPressed: () async {
              if (widget.visible) {
                await login();
              } else {
                await resetPassword();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    final authProvider = Modular.get<AuthProvider>();
    _mensagemErro = null;

    if (_formKey.currentState!.validate()) {
      setState(() {
        OverlayApp.iniciaOverlay(context);
      });

      final userModel = UserModel(
          usuario: _loginEC.text,
          senha: _passwordEC.text,
          idDevice: await DeviceUtils().getDeviceID());

      final response = await authProvider.login(userModel);

      OverlayApp.terminaOverlay();

      if (response != null && response.error != null) {
        final error = response.error as ExceptionModel;
        setState(() {
          _mensagemErro = error.mensagem;
        });
      } else {
        if (authProvider.listaCedente!.length > 1) {
          Modular.to.navigate(AppRoutes.listaSelecaoEmpresasRoute);
        } else {
          authProvider.RelogarTrocarCedente(
              authProvider.dataUser!.identificadorCedente, context);
        }
      }
    }
  }

  Future<void> resetPassword() async {
    RecuperarSenhaProvider recuperarSenhaProvider =
        Modular.get<RecuperarSenhaProvider>();
    _mensagemErro = null;
    if (_formKey.currentState!.validate()) {
      setState(() {
        OverlayApp.iniciaOverlay(context);
      });
      recuperarSenhaProvider.dadosUsuario = RecuperarSenhaModel(
          identificadorCedente: _passwordEC.text, usuario: _loginEC.text);
      final response = await recuperarSenhaProvider.recuperarSenha();
      OverlayApp.terminaOverlay();
      if (response != null && response.error != null) {
        setState(() {
          _mensagemErro = "Por favor, verifique os dados informados.";
        });
      } else {
        showDialog(
            context: context,
            builder: (context) => confirmarRecuperarSenha(),
            barrierDismissible: false);
      }
    }
  }

  Widget confirmarRecuperarSenha() {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.end,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      actions: [
        Row(
          children: [
            Expanded(
              child: BotaoPadrao(
                onPressed: () {
                  Modular.to.pop();
                },
                label: "OK",
              ),
            ),
          ],
        )
      ],
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Text(
              "Dados enviados com sucesso",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "Acesse o link que enviamos para o seu email para cadastrar uma nova senha de acesso",
            style: context.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
      icon: SvgPicture.asset(Assets.iconsCheck, color: AppColors.verde),
    );
  }
}
