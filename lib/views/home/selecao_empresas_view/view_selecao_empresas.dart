import 'package:Srm_Asset/assets_config/assets_config.dart';
import 'package:Srm_Asset/core/constants/classes_abstratas/envirioment.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/string_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/deslogar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/route_labels.dart';

class ListaSelecaoEmpresas extends StatefulWidget {
  const ListaSelecaoEmpresas({super.key});

  @override
  State<ListaSelecaoEmpresas> createState() => _ListaSelecaoEmpresasState();
}

class _ListaSelecaoEmpresasState extends State<ListaSelecaoEmpresas> {
  final AuthProvider authProvider = Modular.get<AuthProvider>();

  // final TextEditingController _searchController = TextEditingController();
  // List<CedenteModel>? _searchResults;

  @override
  void initState() {
    super.initState();
    // _searchController.addListener(_onSearchChanged);
    // _searchResults = authProvider.listaCedente;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final SessionProvider sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.startListening();
    });
  }

  // _onSearchChanged() {
  //   final query = _searchController.text.toLowerCase();
  //   if (query.isNotEmpty) {
  //     setState(() {
  //       _searchResults = authProvider.listaCedente
  //           ?.where((item) =>
  //               item.nome.toLowerCase().contains(query) ||
  //               item.identificador.contains(query)) // Considera CNPJ
  //           .toList();
  //     });
  //   } else {
  //     setState(() {
  //       _searchResults = authProvider.listaCedente;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProviderAtt = context.watch<AuthProvider>();
    final ambiente = Modular.get<Environment>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),
      body: Column(
        children: [
          Container(
            height: 230.h,
            width: context.width,
            decoration: BoxDecoration(
              color: context.secondaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            ambiente.logoAppBar,
                            width: 32.w,
                          ),
                          InkWell(
                            onTap: () => DeslogarUsuario(context: context).encerrarSessao(),
                            child: SvgPicture.asset(
                              AssetsConfig.imagesExitIcone,
                              width: 32.w,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Grupo Econômico',
                            style: context.textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                          Text(
                            'Essas são as empresas do Grupo Econômico.',
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    left: 16.w,
                    bottom: -20.h,
                    child: SvgPicture.asset(
                      ambiente.logoAppBar,
                      color: Color(0x1affffff),
                      width: context.width * 0.5,
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome/Razão Social',
                          style: context.textTheme.displaySmall!.copyWith(
                              color: context.labelTextColor,
                              fontWeight: FontWeight.w900),
                        ),
                        Text('Selecione a empresa do Grupo Econômico.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: authProviderAtt.listaCedente!.length,
              itemBuilder: (context, index) {
                BorderRadius borderRadius = BorderRadius.zero;
                return InkWell(
                  onTap: () async {
                    await authProviderAtt.RelogarTrocarCedente(
                        authProviderAtt.listaCedente![index].identificador,
                        context);
                    Modular.to.navigate(AppRoutes.homeAppNavigatorRoute);
                  },
                  child: SizedBox(
                    height: 90.h,
                    child: Card(
                      color: Color(0xffFFFDFD),
                      elevation: 0,
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 34.r,
                            backgroundColor: Color(0xffF8F9FB),
                            child: SvgPicture.asset(
                              AssetsConfig.srmMaleta,
                              color: context.primaryColor,
                              width: 30.w,
                            ),
                          ),
                          title: Text(
                            authProviderAtt.listaCedente![index].nome,
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w900),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            'CNPJ: ${authProviderAtt.listaCedente![index].identificador.formatarDocumento()}', style: context.textTheme.bodyLarge,
                          ),
                          trailing: Visibility(
                            visible: authProviderAtt
                                    .listaCedente![index].assinaturaPendente >
                                0,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 15.r,
                              child: Center(
                                child: Text(
                                    authProvider.dataUser!.listaCedente[index]
                                                .assinaturaPendente >=
                                            10
                                        ? '9+'
                                        : authProvider
                                            .dataUser!
                                            .listaCedente[index]
                                            .assinaturaPendente
                                            .toString(),
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Spacer(),
          // Padding(
          //   padding: EdgeInsets.all(16.r),
          //   child: BotaoPadrao(label: 'Ver Consolidado do grupo', onPressed: (){}),
          // ),
        ],
      ),
    );
  }
}
