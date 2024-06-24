import 'package:Srm_Asset/core/constants/enuns/enum_ted_terceiros.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/ted_terceiros/ted_terceiros_provider.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
part '../widgets/card_ted.dart';
part '../widgets/item_card_ted.dart';

class ListaAprovacaoTed extends StatefulWidget {
  const ListaAprovacaoTed({super.key});

  @override
  State<ListaAprovacaoTed> createState() => _ListaAprovacaoTedState();
}

class _ListaAprovacaoTedState extends State<ListaAprovacaoTed> {
  @override
  Widget build(BuildContext context) {
    final tedProvider = context.watch<TedTerceirosProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TED PARA TERCEIROS',
          style: context.textTheme.displaySmall!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: tedProvider.futureListaTed,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Loader();
          }
          if(tedProvider.futureListaTed == null){
            return Padding(
              padding: EdgeInsets.all(16.r),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) => _CardTedTerceiros(),
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => _CardTedTerceiros(),
          );
        },
      ),
    );
  }
}
