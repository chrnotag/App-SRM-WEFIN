import 'package:flutter/material.dart';
import 'package:modular_study/core/constants/datas/usuarios_data.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/implementations_config/export_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/utils/get_device_infos.dart';
import 'package:modular_study/models/user_model.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_textfield.dart';
import 'package:validatorless/validatorless.dart';

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
    final authProvider = Modular.get<AuthProvider>();
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                authProvider.setLoading();
                if (_loginEC.text == "teste@gmail.com" &&
                    _passwordEC.text == "123") {
                  authProvider.setDataUser = UsuariosData.dadosUsuarios;
                  authProvider.setLoading();
                  Modular.to.navigate(AppRoutes.listaSelecaoEmpresasRoute);
                } else {
                  log(authProvider.isLoading.toString());
                  final userModel = UserModel(
                      nomeUsuario: _loginEC.text,
                      senha: _passwordEC.text,
                      idDevice: await DeviceUtils().getDeviceID());
                  final response = await authProvider.login(userModel);
                  authProvider.setLoading();
                  log(authProvider.isLoading.toString());
                  if (response.error != null) {
                    final error = response.error as ExceptionModel;
                    log(error.mensagem ?? 'Sem erro');
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
            },
          ),
        ],
      ),
    );
  }
}
