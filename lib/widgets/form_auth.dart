import 'package:Srm_Asset/core/utils/abrir_url_externo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/constants/themes/theme_configs.dart';
import 'package:Srm_Asset/core/implementations_config/export_impl.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/recuperar_senha/recuperar_senha_provider.dart';
import 'package:Srm_Asset/core/utils/get_device_infos.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/models/recuperar_senha_model/recuperar_senha_model.dart';
import 'package:Srm_Asset/models/user_model.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_textfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';
import '../core/providers/theme_provider.dart';
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

  final MaskTextInputFormatter _cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSavedLoginData();
    });
  }

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String politicaPrivacidade = EndPoints.politicaPrivacidade;
    String termosDeUso = EndPoints.termosDeUso;
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20.h),
            Column(
              children: [
                WefinTextFormField(
                  onTap: () => setState(() {
                    _mensagemErro = null;
                  }),
                  label: 'Digite seu email',
                  autofillHint: AutofillHints.email,
                  controller: _loginEC,
                  validator: Validatorless.multiple([
                    Validatorless.email('Email inválido!'),
                    Validatorless.required('Email Obrigatório'),
                    (value) => _mensagemErro
                  ]),
                ),
                Visibility(
                  visible: widget.visible,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: WefinTextFormField(
                      autofillHint: AutofillHints.password,
                      inputFormatters: !widget.visible ? _cnpjFormatter : null,
                      onTap: () => _mensagemErro = null,
                      label:
                          'Digite sua Senha',
                      obscureText: widget.visible,
                      controller: _passwordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        if (widget.visible)
                          Validatorless.max(10, 'Maximo de 10 caracteres.'),
                        if (widget.visible)
                          Validatorless.min(
                              3, 'Senha com no mínimo 3 e máximo 10 caracteres.'),
                        (value) => _mensagemErro
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.visible,
              child: LinkComponent(
                label: 'Esqueci minha senha!',
                route: AppRoutes.forgetPassAuthRoute,
              ),
            ),
            Visibility(
              visible: widget.visible,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Ao continuar você concorda com as nossas ',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: context.surface)),
                  TextSpan(
                      text: 'Politicas de Privacidade ',
                      style: context.textTheme.bodySmall!.copyWith(
                          color: context.surface,
                          decoration: TextDecoration.underline,
                          decorationColor: context.surface,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          String url = politicaPrivacidade;
                          AbrirUrl().launchURL(url);
                        }),
                  TextSpan(
                      text: 'e os nossos ',
                      style: context.textTheme.bodySmall!
                          .copyWith(color: context.surface)),
                  TextSpan(
                      text: 'Termos de uso',
                      style: context.textTheme.bodySmall!.copyWith(
                          color: context.surface,
                          decoration: TextDecoration.underline,
                          decorationColor: context.surface,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          String url = termosDeUso;
                          await AbrirUrl().launchURL(url);
                        }),
                ]),
              ),
            ),
            BotaoPadrao(
              label: widget.label,
              onPressed: () async {
                TextInput.finishAutofillContext();
                if (widget.visible) {
                  await login();
                } else {
                  await resetPassword();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final FlutterSecureStorage _storage = FlutterSecureStorage();

// Função para salvar os dados de login (email e senha) se o usuário optar por isso
  void _saveLoginDataIfNeeded() async {
    await _storage.write(key: 'email', value: _loginEC.text);
    await _storage.write(key: 'password', value: _passwordEC.text);
  }

  void _loadSavedLoginData() async {
    String? savedEmail = await _storage.read(key: 'email');
    String? savedPassword = await _storage.read(key: 'password');

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        _loginEC.text = savedEmail;
        _passwordEC.text = savedPassword;
      });
    }
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
        _saveLoginDataIfNeeded();
        if (authProvider.listaCedente!.length > 1) {
          Modular.to.pushReplacementNamed(AppRoutes.listaSelecaoEmpresasRoute);
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
          usuario: _loginEC.text);
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

  String removerMascaraCNPJ(String cnpj) {
    return cnpj.replaceAll(".", "").replaceAll("/", "").replaceAll("-", "");
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
