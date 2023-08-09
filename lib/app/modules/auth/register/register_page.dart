import 'package:flutter_mobile_project/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter_mobile_project/app/core/ui/widgets/wefin_textform_field.dart';
import 'package:flutter_mobile_project/app/core/ui/widgets/wefin_default_button.dart';
import 'package:flutter_mobile_project/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 162.w,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 60),
              const _RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
