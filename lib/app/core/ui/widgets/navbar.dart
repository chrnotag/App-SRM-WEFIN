import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.globalBackgroung, // Defina a cor de fundo desejada
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Coloque a lógica para voltar à tela anterior aqui
          Navigator.of(context).pop(); // Exemplo de lógica para voltar à tela anterior
        },
      ),
      title: SizedBox( // Usar um SizedBox para exibir a imagem
        height: kToolbarHeight,
        child: Transform.scale(
          scale: 0.5, // Escala de 75%
          child: Image.asset(
            'assets/images/logo.png', // Substitua pelo caminho da sua imagem de fundo
            fit: BoxFit.contain, // Use BoxFit.contain para manter a proporção da imagem
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              // Coloque a lógica do menu aqui
            },
            child: const Icon(Icons.account_circle), // Exemplo de ícone de menu
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


