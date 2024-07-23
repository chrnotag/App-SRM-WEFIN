import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/recuperar_versao/recuperar_versao_provider.dart';
import 'package:Srm_Asset/models/versao_model/versao_model.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:yaml/yaml.dart';
import 'dart:io' show Platform;
import '../../../flavors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final provider = Modular.get<RecuperarVersaoProvider>();

  Future<String> _getCurrentVersion() async {
    try {
      final flavor = F.appFlavor;
      final pubspecPath = '${flavor!.name.toLowerCase()}.yaml';
      final pubspecContent = await rootBundle.loadString(pubspecPath);
      final pubspec = loadYaml(pubspecContent);
      print(pubspec['version']);
      return pubspec['version'];
    } catch (e) {
      print('Erro ao carregar a versão do pubspec.yaml: $e');
      return '';
    }
  }

  Future<void> pegarVersao() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final response = await provider.pegarVersao();
      final backendVersion = response.data as VersaoModel;

      final currentVersion = await _getCurrentVersion();

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
    print('chamando');
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
              'Uma nova versão do aplicativo está disponível para download.',
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

    if (F.appFlavor == Flavor.TRUST_HOMOLOGACAO || F.appFlavor == Flavor.TRUST_PRODUCAO) {
      if (Platform.isAndroid) {
        url = 'https://play.google.com/store/apps/details?id=com.trust.trust_app';
      } else if (Platform.isIOS) {
        url = 'https://apps.apple.com/app/app-cliente-trust/id6479451107';
      }
    } else if (F.appFlavor == Flavor.SRM_HOMOLOGACAO || F.appFlavor == Flavor.SRM_PRODUCAO) {
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
                  F.appFlavor?.getEnvironment.logo ?? '',
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
