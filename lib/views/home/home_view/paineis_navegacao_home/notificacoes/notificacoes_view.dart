import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/notificacoes_provider/notificacoes_provider.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/mensagem_tela_vazia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificacoesView extends StatefulWidget {
  const NotificacoesView({super.key});

  @override
  State<NotificacoesView> createState() => _NotificacoesViewState();
}

class _NotificacoesViewState extends State<NotificacoesView> {

  @override
  void initState() {
    super.initState();
    final provider = Modular.get<NotificacoesProvider>();
    provider.futureNotificacoes = provider.pegarNotificacoes();
  }

  @override
  void dispose() {
    super.dispose();
    final provider = Modular.get<NotificacoesProvider>();
    provider.marcarLido();
    provider.limparNotificacoes();
  }

  @override
  Widget build(BuildContext context) {
    final notificacoesProvider = context.watch<NotificacoesProvider>();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: notificacoesProvider.futureNotificacoes!,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            } else if (notificacoesProvider.notificacoes.isEmpty) {
              return MensagemTelaVazia(
                titulo: 'Nenhuma novidade...',
                mensagem: 'Parece que não há notificações disponiveis',
              );
            }
            return ListView.builder(
              itemCount: notificacoesProvider.notificacoes.length,
              itemBuilder: (context, index) => Container(
                width: context.width,
                color: Colors.white,
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    notificacoesProvider.notificacoes[index].titulo,
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: SRMColors.textBodyColor),
                  ),
                  subtitle: Text(notificacoesProvider.notificacoes[index].mensagem,
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: context.labelTextColor)),
                  leading: SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Center(
                      child: SvgPicture.asset(AssetsConfig.trustAlertIconTrust)
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
