import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/models/auth_login_models/cedente_model.dart';
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
    });
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
    log('quantidade: ${_searchResults![0].assinaturaPendente}');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: const AppBarLogo()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SearchBarPersonalizada(
                    searchController: _searchController,
                    hint: 'Digite a empresa que deseja buscar'),
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    minHeight: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _searchResults?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      Divider(thickness: 1, height: 0),
                  itemBuilder: (context, index) {
                    BorderRadius borderRadius = BorderRadius.zero;
                    if (index == 0 && index == _searchResults!.length - 1) {
                      // Se houver apenas um item
                      borderRadius = BorderRadius.circular(15);
                    } else {
                      // Primeiro item da lista
                      borderRadius = const BorderRadius.vertical(
                        top: Radius.circular(5),
                        bottom: Radius.circular(5),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            OverlayApp.iniciaOverlay(context);
                          });
                          authProviderAtt.RelogarTrocarCedente(
                              _searchResults![index].identificador);
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                _searchResults![index].nome,
                                style: context.textTheme.bodyMedium,
                              ),
                              Text(
                                '/ CNPJ:${_searchResults![index].identificador}',
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Visibility(
                                visible:
                                    _searchResults![index].assinaturaPendente >
                                        0,
                                child: CircleAvatar(
                                    backgroundColor: AppColors.vermelho,
                                    radius: 10.r,
                                    child: Center(
                                      child: Text(
                                          _searchResults![index]
                                                      .assinaturaPendente >=
                                                  10
                                              ? '9+'
                                              : _searchResults![index]
                                                  .assinaturaPendente
                                                  .toString(),
                                          style: context.textTheme.labelSmall!
                                              .copyWith(color: Colors.white)),
                                    )),
                              ),
                            ],
                          ),
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
