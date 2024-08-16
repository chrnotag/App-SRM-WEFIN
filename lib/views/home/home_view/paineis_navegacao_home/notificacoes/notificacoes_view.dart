import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/mensagem_tela_vazia.dart';
import 'package:flutter/material.dart';

class NotificacoesView extends StatefulWidget {
  const NotificacoesView({super.key});

  @override
  State<NotificacoesView> createState() => _NotificacoesViewState();
}

class _NotificacoesViewState extends State<NotificacoesView> {
  Future<void> _future() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _future(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            } else if (snapshot.hasData) {
              return MensagemTelaVazia(
                titulo: 'Nenhuma novidade...',
                mensagem: 'Parece que não há notificações disponiveis',
              );
            }
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                width: context.width,
                color: Colors.white,
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    'Você tem uma pendência em Assinaturas.',
                    style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: SRMColors.textBodyColor),
                  ),
                  subtitle: Text('Qua. 9:42',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          color: context.labelTextColor)),
                  leading: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text('MP', style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600, color: SRMColors.textBodyColor),),
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
