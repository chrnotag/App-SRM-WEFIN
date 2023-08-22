import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Insira a lógica para voltar à tela anterior aqui
        },
      ),
      title: Image.network(
        'URL_DA_IMAGEM', // Substitua 'URL_DA_IMAGEM' pela URL da sua imagem
        fit: BoxFit.cover,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              // Insira a lógica do menu aqui
            },
            child: const Text('Menu'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
