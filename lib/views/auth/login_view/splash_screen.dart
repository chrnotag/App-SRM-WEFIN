import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/recuperar_versao/recuperar_versao_provider.dart';
import 'package:Srm_Asset/models/versao_model/versao_model.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'dart:io' show Platform;

import '../../../core/constants/enuns/plataforma_enum.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ambiente = Modular.get<Environment>();
  final provider = Modular.get<RecuperarVersaoProvider>();

  Future<void> pegarVersao() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final response = await provider.pegarVersao();
      final backendVersion = response.data as VersaoModel;

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version + "+" + packageInfo.buildNumber;

      print('Versão atual: $currentVersion');
      print('Versão do backend: ${backendVersion.versao}');

      if (backendVersion.versao != currentVersion) {
        _showUpdateDialog();
      } else {
        Modular.to.navigate(AppRoutes.loginAuthRoute);
      }
    } catch (error) {
      print('Erro ao recuperar a versão: $error');
    }
  }

  void _showUpdateDialog() {
    print('chamadno');
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Text(
              'Atualização Disponível',
              style: context.textTheme.displaySmall!.copyWith(
                  color: SRMColors.textBodyColor, fontWeight: FontWeight.w900),
            ),
            Text(
              'Uma nova versão do aplicativo esta disponível para download.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: BotaoPadrao(label: 'Atualizar Aplicativo', onPressed: _launchAppStore),
            ),
            BotaoPadrao(label: 'Cancelar', filled: false, onPressed: () => FlutterExitApp.exitApp(iosForceExit: true),)
          ],
        ),
      ),
    );
  }

  Future<void> _launchAppStore() async {
    String url = '';

    if (ambiente.plataforma == Plataforma.TRUST) {
      if (Platform.isAndroid) {
        url = 'https://play.google.com/store/apps/details?id=com.trust.trust_app';
      } else if (Platform.isIOS) {
        url = 'https://apps.apple.com/app/app-cliente-trust/id6479451107';
      }
    } else if (ambiente.plataforma == Plataforma.SRM) {
      if (Platform.isAndroid) {
        url = 'https://play.google.com/store/apps/details?id=com.app.srm';
      } else if (Platform.isIOS) {
        url = 'https://apps.apple.com/app/app-cliente-srm/id6479165868';
      }
    } else {
      throw UnsupportedError("Unsupported platform or OS");
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    pegarVersao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.secondaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  ambiente.logo,
                  width: context.width * 0.5,
                ),
                SizedBox(
                  height: 30.h,
                ),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
