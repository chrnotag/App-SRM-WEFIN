import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/utils/get_device_infos.dart';
import 'package:modular_study/models/user_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_textfield.dart';
import 'package:validatorless/validatorless.dart';

import '../generated/assets.dart';
import 'link_component.dart';
import 'loader_widget.dart';

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

  OverlayState? overlay;
  final overlayLoader = OverlayEntry(
    builder: (context) => const Material(
      color: Colors.transparent,
      child: Loader(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context);
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
          const SizedBox(height: 20),
          WefinTextFormField(
            onTap: () => _mensagemErro = null,
            maxLength: 10,
            label: widget.visible ? 'Digite sua Senha' : 'Digite seu CPF',
            obscureText: widget.visible,
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required(
                  widget.visible ? 'Senha obrigatória' : 'CPF Obrigatório'),
              if (!widget.visible) Validatorless.cpf('CPF Inválido!'),
              Validatorless.min(
                  3, 'Senha com no mínimo 3 e máximo 10 caracteres.'),
              (value) => _mensagemErro
            ]),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 50),
          WefinDefaultButton(
            label: widget.label,
            fontSize: 14,
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
        overlay!.insert(overlayLoader);
      });
      final userModel = UserModel(
          nomeUsuario: _loginEC.text,
          senha: _passwordEC.text,
          idDevice: await DeviceUtils().getDeviceID());
      final response = await authProvider.login(userModel);
      overlayLoader.remove();
      if (response != null && response.error != null) {
        final error = response.error as ExceptionModel;
        setState(() {
          if (error.codigo == '500') {
            _mensagemErro = error.mensagem;
          } else {
            _mensagemErro = "Usuário ou senha Incorretos";
          }
        });
      } else {
        Modular.to.navigate(AppRoutes.listaSelecaoEmpresasRoute);
      }
    }
  }

  Future<void> resetPassword() async {
    final confirmDialog = AlertDialog(
      actionsAlignment: MainAxisAlignment.end,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.azul),
                  child: const Text("OK")),
            ),
          ],
        )
      ],
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Dados enviados com sucesso",
              style: context.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "Acesse o link que enviamos para o seu email para cadastrar uma nova senha de acesso",
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
      icon: SvgPicture.asset(Assets.iconsCheck, color: AppColors.verde),
    );
    showDialog(
        context: context,
        builder: (context) => confirmDialog,
        barrierDismissible: false);
  }
}
