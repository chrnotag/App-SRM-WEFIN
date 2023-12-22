import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/generated/assets.dart';

class SelecaoEmpresaLogin extends StatelessWidget {
  const SelecaoEmpresaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Seja bem-vindo\nao seu app de gestão',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!
                            .copyWith(fontSize: 20, color: AppColors.labelText),
                      ),
                      Text(
                        'Em qual empresa deseja entrar?',
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.labelText),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Modular.to.navigate(AppRoutes.loginSRMAuthRoute);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.logoSRM,
                                  width: 240,
                                  color: AppColors.corPrimariaSRM,
                                ),
                                Text(
                                  'CAPITAL EM MOVIMENTO',
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                      color: Color(0xffDE9320),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.paddingMedium),
                            child: Text(
                              'ou',
                              style: context.textTheme.bodyLarge!
                                  .copyWith(color: AppColors.corPrimariaSRM),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              Assets.logoTRUST,
                              width: 240,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
