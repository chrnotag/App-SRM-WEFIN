import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/secao_provider.dart';

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
    return Scaffold(
      backgroundColor: AppColors.globalBackground,
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
                Assets.imagesLogo,
                scale: 3,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            Image.asset(
              Assets.imagesNoNetwork,
              scale: 4,
              color: Colors.white,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sem conexão com a internet',
                    style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontSize: AppSizes.fontSizeLarge),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Verifique sua conexão e tente novamente',
                    style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontSize: AppSizes.fontSizeMedium),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('OK',
                                style: context.textTheme.bodyLarge!.copyWith(
                                    fontSize: AppSizes.fontSizeMedium,
                                    color: Colors.white)),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
