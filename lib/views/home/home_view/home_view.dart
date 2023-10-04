import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const AppBarLogo(),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            SelecaoEmpresa(
                nomeEmpresa: authProvider.empresaSelecionada!.nome,
                changeble: true),
            // Expanded(child: Container()),
            GridView.count(
              // Definindo apenas uma "coluna" para criar um layout de 1 linha
              crossAxisCount: 1,
              children: <Widget>[
                // Espaço vazio
                Container(color: Colors.transparent),
                Container(color: Colors.red, height: 100),
                Container(color: Colors.green, height: 100),
                Container(color: Colors.blue, height: 100),
              ],

            ),
            // Row(
            //   children: [
            //     Container(
            //       height: 50,
            //       child: ListView(
            //         scrollDirection: Axis.horizontal,
            //         shrinkWrap: true,
            //         children: [
            //           Container(
            //             width: 50,
            //             height: 50,
            //             color: Colors.red,
            //           ),
            //           Container(
            //             width: 50,
            //             height: 50,
            //             color: Colors.red,
            //           ),
            //           Container(
            //             width: 50,
            //             height: 50,
            //             color: Colors.red,
            //           ),

            //         ],
            //       ),
            //     ),
            //   ],
            // )
          ]),
        ),
      ),
    );
  }
}
