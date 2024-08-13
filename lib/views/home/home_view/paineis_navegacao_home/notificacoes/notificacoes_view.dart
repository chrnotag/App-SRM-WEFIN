import 'package:flutter/material.dart';

class NotificacoesView extends StatefulWidget {
  const NotificacoesView({super.key});

  @override
  State<NotificacoesView> createState() => _NotificacoesViewState();
}

class _NotificacoesViewState extends State<NotificacoesView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: Center(child: Container(child: Text("Tela notificacoes"),)))
          ],
        ),
      ),
    );
  }
}
