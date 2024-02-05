import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/screen_util_extension.dart';
import 'package:modular_study/core/constants/extensions/size_screen_media_query.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/models/auth_login_models/SRM/cedente_model.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/searchbar_person.dart';

class ListaSelecaoEmpresas extends StatefulWidget {
  const ListaSelecaoEmpresas({super.key});

  @override
  State<ListaSelecaoEmpresas> createState() => _ListaSelecaoEmpresasState();
}

class _ListaSelecaoEmpresasState extends State<ListaSelecaoEmpresas> {
  final AuthProvider authProvider = Modular.get<AuthProvider>();

  final TextEditingController _searchController = TextEditingController();
  List<CedenteModel>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchResults = authProvider.listaCedente;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final SessionProvider sessionProvider = Modular.get<SessionProvider>();
      sessionProvider.startListening();
      // verificarPolitica();
    });
  }

  void verificarPolitica() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Text('Política de privacidade',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColors.azulPrimarioSRM,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    letterSpacing: 1.5.sp,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: GestureDetector(
                onTap: () {
                  Modular.to.pop();
                },
                child: Text('Clique aqui para vizualizar',
                    style: context.textTheme.labelMedium!
                        .copyWith(color: AppColors.labelText)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          authProvider.limparDadosUsuario();
                          Modular.to.navigate(Modular.initialRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 204, 91, 91),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: const Text(
                              'Recusar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.azul,
                          shadowColor: const Color.fromARGB(0, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                              side: const BorderSide(
                                  color: AppColors.azul, width: 1))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Text('Aceitar',
                              style: context.textTheme.labelSmall!
                                  .copyWith(color: Colors.white)),
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = authProvider.listaCedente
            ?.where((item) => item.nome.toLowerCase().contains(query))
            .toList();
      });
    } else {
      setState(() {
        _searchResults = authProvider.listaCedente;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProviderAtt = context.watch<AuthProvider>();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: const AppBarLogo()),
      body: Padding(
        padding: EdgeInsets.all(8.r),
        child: Center(
          child: Column(
            children: [
              SelecaoEmpresa(
                nomeEmpresa: authProviderAtt.empresaSelecionada?.nome ??
                    'Não existem empresas no grupo',
                tituloPagina: 'Empresas do grupo ecônomico',
                changeble: false,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: SearchBarPersonalizada(
                    searchController: _searchController,
                    hint: 'Digite a empresa que deseja buscar'),
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: context.height * 0.7, minHeight: 80.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.white,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _searchResults?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 1, height: 0),
                  itemBuilder: (context, index) {
                    BorderRadius borderRadius = BorderRadius.zero;
                    if (index == 0 && index == _searchResults!.length - 1) {
                      // Se houver apenas um item
                      borderRadius = BorderRadius.circular(15.r);
                    } else {
                      // Primeiro item da lista
                      borderRadius = BorderRadius.vertical(
                        top: Radius.circular(5.r),
                        bottom: Radius.circular(5.r),
                      );
                    }

                    return InkWell(
                      onTap: () async {
                        authProviderAtt.RelogarTrocarCedente(
                            _searchResults![index].identificador, context);
                      },
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: _searchResults![index].nome,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                      TextSpan(
                                        text:
                                            ' CNPJ:${_searchResults![index].identificador}',
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ]),
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: _searchResults![index]
                                            .assinaturaPendente >
                                        0,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 10.r,
                                        child: Center(
                                          child: Text(
                                              authProvider
                                                          .dataUser!
                                                          .listaCedente[index]
                                                          .assinaturaPendente >=
                                                      10
                                                  ? '9+'
                                                  : authProvider
                                                      .dataUser!
                                                      .listaCedente[index]
                                                      .assinaturaPendente
                                                      .toString(),
                                              style: context
                                                  .textTheme.labelSmall!
                                                  .copyWith(
                                                      color: Colors.white)),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
