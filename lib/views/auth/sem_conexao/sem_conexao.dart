import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/core/providers/theme_provider.dart';

import '../../../generated/assets.dart';

class SemConexaoScreen extends StatefulWidget {
  const SemConexaoScreen({super.key});

  @override
  State<SemConexaoScreen> createState() => _SemConexaoScreenState();
}

class _SemConexaoScreenState extends State<SemConexaoScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final SessionProvider sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.stopListening();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Modular.get<ThemeProvider>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesBackgroundImage),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBar(
              centerTitle: true,
              title: Image.asset(
                themeProvider.logoTemaAppBar,
                width: 70.w,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            Image.asset(Assets.imagesNoNetwork,
                scale: 3.r, color: context.onSecondary),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Text(
                    'Sem conexão com a internet',
                    style: context.textTheme.displayMedium!
                        .copyWith(color: context.inverseSurface),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Text(
                    'Verifique sua conexão e tente novamente',
                    style: context.textTheme.displaySmall!
                        .copyWith(color: context.inverseSurface),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: BotaoPadrao(label: 'Ok', onPressed: (){})
            ),
          ],
        ),
      ),
    );
  }
}
