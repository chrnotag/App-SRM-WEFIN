import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/utils/abrir_url_externo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
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
import '../core/constants/enuns/plataforma_enum.dart';
import '../core/providers/certificado_provider/certificado_provider.dart';
import '../core/providers/conta_digital/conta_digital_provider.dart';
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

  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _loadSavedLoginData();
    // });
  }

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  void removerCaracteresEspeciais() {
    _loginEC.text = _loginEC.text.replaceAll(RegExp(r'[.-]'), '');
  }

  @override
  Widget build(BuildContext context) {
    Environment ambiente = Modular.get<Environment>();
    String politicaPrivacidade = ambiente.endpoints.politicaPrivacidade;
    String termosDeUso = ambiente.endpoints.termosDeUso;
    int? maximoCaracteresCPF;

    final temLetras = RegExp(r'[a-zA-Z]').hasMatch(_loginEC.text);

    void atualizarMascara() {
      final mascara = temLetras ? null : '###.###.###-##';
      final filtro = temLetras ? null : {"#": RegExp(r'[0-9A-Za-z\W]')};

      if (!temLetras && _loginEC.text.length <= 1) {
        _cpfFormatter.updateMask(mask: null);
      } else if (_loginEC.text.length == 11) {
        _cpfFormatter.updateMask(mask: mascara, filter: filtro);
        _loginEC.text = _cpfFormatter.getMaskedText();
      }

      setState(() {
        maximoCaracteresCPF = temLetras ? null : 11;
      });
    }

    final bool isTrust = ambiente.plataforma == Plataforma.TRUST;

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
                  hint: isTrust ? "CPF" :"E-mail ou CPF",
                  inputFormatters: _cpfFormatter,
                  onChanged: (value) => atualizarMascara(),
                  maxCaracters: maximoCaracteresCPF,
                  label: isTrust ? "Digite seu CPF" : 'Digite seu e-mail ou CPF',
                  autofillHint: AutofillHints.email,
                  controller: _loginEC,
                  validator: Validatorless.multiple([
                    if (temLetras && !isTrust) Validatorless.email('Email inválido!'),
                    if (!temLetras || isTrust) Validatorless.cpf('CPF inválido!'),
                    Validatorless.required(isTrust ? "CPF Obrigatório" : 'E-mail ou CPF Obrigatório'),
                    (value) => _mensagemErro
                  ]),
                ),
                Visibility(
                  visible: widget.visible,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Column(
                      children: [
                        WefinTextFormField(
                          hint: "Senha",
                          autofillHint: AutofillHints.password,
                          inputFormatters:
                              !widget.visible ? _cnpjFormatter : null,
                          onTap: () => _mensagemErro = null,
                          label: 'Digite sua Senha',
                          obscureText: widget.visible,
                          controller: _passwordEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatória'),
                            if (widget.visible)
                              Validatorless.min(3,
                                  'Senha com no mínimo 3 e máximo 10 caracteres.'),
                            (value) => _mensagemErro
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: widget.visible,
                                child: LinkComponent(
                                  style: context.textTheme.bodyMedium!.copyWith(color: context.secondaryColor, fontWeight: FontWeight.bold),
                                  label: 'Esqueci minha senha!',
                                  route: AppRoutes.forgetPassAuthRoute,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BotaoPadrao(
              label: widget.label,
              onPressed: () async {
                if(!temLetras){
                  removerCaracteresEspeciais();
                }
                TextInput.finishAutofillContext();
                if (widget.visible) {
                  await login(temLetras);
                } else {
                  await resetPassword();
                }
              },
            ),
            Visibility(
              visible: widget.visible,
              child: SizedBox(
                width: context.width * 0.8,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Ao continuar concordo com os ',
                        style: context.textTheme.bodySmall!
                            .copyWith(color: context.secondaryColor)),
                    TextSpan(
                        text: 'Termos e Condições de uso ',
                        style: context.textTheme.bodySmall!.copyWith(
                            color: context.secondaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: context.inverseSurfaceColor,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String url = termosDeUso;
                            AbrirUrl().launchURL(url);
                          }),
                    TextSpan(
                        text: 'e tenho ciência da ',
                        style: context.textTheme.bodySmall!
                            .copyWith(color: context.secondaryColor)),
                    TextSpan(
                        text: 'Declaração de Política de Privacidade.',
                        style: context.textTheme.bodySmall!.copyWith(
                            color: context.secondaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: context.inverseSurfaceColor,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String url = politicaPrivacidade;
                            await AbrirUrl().launchURL(url);
                          }),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//
// // Função para salvar os dados de login (email e senha) se o usuário optar por isso
//   void _saveLoginDataIfNeeded() async {
//     await _storage.write(key: 'email', value: _loginEC.text);
//     await _storage.write(key: 'password', value: _passwordEC.text);
//   }

  // void _loadSavedLoginData() async {
  //   // String? savedEmail = await _storage.read(key: 'email');
  //   // String? savedPassword = await _storage.read(key: 'password');
  //   if (savedEmail != null && savedPassword != null) {
  //     setState(() {
  //       _loginEC.text = savedEmail;
  //       _passwordEC.text = savedPassword;
  //     });
  //   }
  // }

  Future<void> login(bool temLetras) async {
    CertificadoProvider certificadoProvider =
        Modular.get<CertificadoProvider>();
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

      if (response != null && response.error != null) {
        final error = response.error as ExceptionModel;
        setState(() {
          OverlayApp.terminaOverlay();
          _mensagemErro = error.mensagem;
        });
      } else {
        final contaDigitalProvider = Modular.get<ContaDigitalProvider>();
        await contaDigitalProvider.obterDadosContaDigital();
        await contaDigitalProvider.obterSaldoContaDigital();
        await certificadoProvider.pegarCertificado();
        // _saveLoginDataIfNeeded();
        if (authProvider.listaCedente!.length > 1) {
          OverlayApp.terminaOverlay();
          Modular.to.pushReplacementNamed(AppRoutes.listaSelecaoEmpresasRoute);
        } else {
          //certificadoProvider.pegarCertificado();
          OverlayApp.terminaOverlay();
          authProvider.RelogarTrocarCedente(
              authProvider.dataUser!.identificadorCedente, context);
          Modular.to.navigate(AppRoutes.homeAppRoute);
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
      recuperarSenhaProvider.dadosUsuario =
          RecuperarSenhaModel(usuario: _loginEC.text);
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
      icon: SvgPicture.asset(Assets.iconsCheck, color: TRUSTColors.primaryColor),
    );
  }
}
