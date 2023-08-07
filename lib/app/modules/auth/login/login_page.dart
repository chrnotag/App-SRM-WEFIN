import 'package:flutter_mobile_project/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter_mobile_project/app/core/ui/extensions/theme_extension.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 130.h),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 162.w,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 100.h),
              const _LoginForm(),
              const _OrSeparator(),
              const SizedBox(height: 8),
              _LoginRegisterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: 1, color: context.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OU',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: context.primaryColor),
          ),
        ),
        Expanded(
          child: Divider(thickness: 1, color: context.primaryColor),
        ),
      ],
    );
  }
}
