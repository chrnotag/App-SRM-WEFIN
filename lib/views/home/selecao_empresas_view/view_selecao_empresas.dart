import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/providers/secao_provider.dart';
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
  final SessionProvider sessionProvider = Modular.get<SessionProvider>();

  final TextEditingController _searchController = TextEditingController();
  List<CedenteModel>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    sessionProvider.startListening();
    _searchResults = authProvider.listaCedente;
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
    final AuthProvider _authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppBar().preferredSize, child: AppBarLogo()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SelecaoEmpresa(
                  nomeEmpresa: _authProvider.empresaSelecionada?.nome ??
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
                          onTap: () {
                            _authProvider.setEmpresaSelecionada =
                                _searchResults![index];
                            Modular.to
                                .pushNamed(AppRoutes.monitorOperacoesRoute);
                          },
                          child: ListTile(
                            title: Text(_searchResults![index].nome),
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
      ),
    );
  }
}
