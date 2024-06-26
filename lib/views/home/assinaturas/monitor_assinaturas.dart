import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/widgets/card_monitor_assinaturas/card_monitor_assinaturas.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:line_icons/line_icons.dart';

class MonitorAssinaturas extends StatefulWidget {
  const MonitorAssinaturas({super.key});

  @override
  State<MonitorAssinaturas> createState() => _MonitorAssinaturasState();
}

class _MonitorAssinaturasState extends State<MonitorAssinaturas> {
  final monitorProvider = Modular.get<AssinaturaProvider>();

  @override
  void initState() {
    super.initState();
    monitorProvider.carregarDados();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    final List<MonitorAssinaturasModel> assinaturas =
        assinaturaProvider.ordenarOperacoes(assinaturaProvider.todasAssinaturas,
            authProvider.dataUser!.identificadorUsuario);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Monitor de Operações',
            style:
                context.textTheme.displaySmall!.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: context.secondaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  value: assinaturaProvider.valorSelecionado,
                  selectedItemBuilder: (context) =>
                      assinaturaProvider.listaCedentes
                          .map((e) => DropdownMenuItem(
                                value: e.identificador,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.nome,
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: context.labelTextColor,
                                              fontWeight: FontWeight.w900),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ))
                          .toList(),
                  menuMaxHeight: 300.h,
                  isExpanded: true,
                  items: assinaturaProvider.listaCedentes
                      .map((e) => DropdownMenuItem(
                            value: e.identificador,
                            child: Text(e.nome,
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: (value) async {
                    setState(() {
                      assinaturaProvider.valorSelecionado = value!;
                    });
                    await authProvider.RelogarTrocarCedente(value!, context);
                  },
                  underline: Container(),
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: Colors.white),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: context.secondaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.82,
              child: RefreshIndicator(
                onRefresh: () => assinaturaProvider.carregarDados(),
                child: FutureBuilder(
                  future: assinaturaProvider.assinaturasFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    if (assinaturas.isEmpty) {
                      return SizedBox(
                        width: context.width,
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                side:
                                    BorderSide(color: context.bordaCardColor)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 116.h),
                                  child: Icon(LineIcons.checkCircle,
                                      color: context.focusColor, size: 137.r),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.h),
                                  child: Text(
                                    "Não há operações a serem apresentadas",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.displayMedium!
                                        .copyWith(
                                            color: context.secondaryColor,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: assinaturas.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CardMonitorAssinaturas(
                            assinatura: assinaturas[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
