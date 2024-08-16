import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/views/home/home_view/paineis_navegacao_home/home/painel_home.dart';
import 'package:Srm_Asset/views/home/home_view/paineis_navegacao_home/menu_user/menu.dart';
import 'package:Srm_Asset/views/home/home_view/paineis_navegacao_home/notificacoes/notificacoes_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int naviController = 0;

  Color trocarCor(int posicao) {
    if (posicao == naviController) {
      return context.secondaryColor;
    }
    return context.labelTextColor;
  }

  List<Widget> telas = [PainelHome(), NotificacoesView(), PerfilUsuario()];

  Widget buildIndicator(int index) {
    return Positioned(
      top: 0,
      child: Container(
        width: 40,
        height: 3,
        color: trocarCor(index),
      ),
    );
  }

  Widget buildIcon(String asset, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          asset,
          color: trocarCor(index),
        ),
        if (naviController == index) buildIndicator(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsConfig.trustHome,
                  color: trocarCor(0),
                ),
                label: 'Início'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsConfig.trustNotificacoes,
                  color: trocarCor(1),
                ),
                label: 'Notificações'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsConfig.trustMaletaBarra,
                  color: trocarCor(2),
                ),
                label: 'Perfil'),
          ],
          onTap: (value) => setState(() {
            naviController = value;
          }),
          currentIndex: naviController,
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  child: telas[naviController],
                ),
              ),
            ),
          ],
        ));
  }
}
