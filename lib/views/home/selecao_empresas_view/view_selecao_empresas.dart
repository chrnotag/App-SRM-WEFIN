import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/route_labels.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/core/providers/secao_provider.dart';
import 'package:modular_study/models/auth_login_models/cedente_model.dart';
import 'package:modular_study/widgets/appbar_logo_perfil.dart';
import 'package:modular_study/widgets/botao_selecao_empresa.dart';
import 'package:modular_study/widgets/searchbar_person.dart';

import '../../../widgets/loader_widget.dart';

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
      verificarPolitica();
    });
  }

  void verificarPolitica() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Política de privacidade',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColors.globalBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1.5,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
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
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          authProvider.clearDataUser();
                          Modular.to.navigate(Modular.initialRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 204, 91, 91),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
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
                          backgroundColor: AppColors.botaoEnvio,
                          shadowColor: const Color.fromARGB(0, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                  color: AppColors.botaoEnvio, width: 1))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
    final AuthProvider provider = context.watch<AuthProvider>();
    final AssinaturaProvider assinaturaProvider =
        context.watch<AssinaturaProvider>();
    final overlay = Overlay.of(context);
    final overlayLoader = OverlayEntry(
      builder: (context) => Positioned.fill(
          child: Material(
        color: Colors.transparent,
        child: Loader(),
      )),
    );
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
                  nomeEmpresa: provider.empresaSelecionada?.nome ??
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
                          onTap: () async {
                            provider.setEmpresaSelecionada =
                                _searchResults![index];
                            try {
                              setState(() {
                                overlay.insert(overlayLoader);
                              });
                              await assinaturaProvider.pegarAssinaturas(
                                  authProvider.dataUser!.identificadorUsuario);
                              setState(() {
                                overlayLoader.remove();
                              });
                            } finally {
                              Modular.to.pushNamed(AppRoutes.homeAppRoute);
                            }
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
