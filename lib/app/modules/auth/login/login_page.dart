import 'package:flutter_mobile_project/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter_mobile_project/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';
import 'package:flutter_mobile_project/app/core/ui/widgets/wefin_textform_field.dart';
import 'package:flutter_mobile_project/app/core/ui/widgets/wefin_default_button.dart';
import 'package:flutter_mobile_project/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter_mobile_project/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.globalBackgroung,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'), // Substitua pelo caminho da sua imagem de fundo
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: 131.h),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 162.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 100.h),
                const _LoginForm(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}