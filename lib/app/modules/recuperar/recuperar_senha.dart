import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/modules/auth/login/login_page.dart';

class ErrorScreen extends StatelessWidget {
  static String routeName = '/recuperar';

  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e376f),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drawable-xxxhdpi.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 90,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/ic_erro_inesperado.png',
                color: Colors.white,
              ),
              const Text(
                'OPS!!!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              const SizedBox(
                width: 255,
                child: Text(
                  'No momento o sistema encontra-se indisponivel,para acesso, por gentileza tente mais tarde',
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          ///Exemplo de como usar o navigator
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5b96cc)),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
