import 'package:Srm_Asset/widgets/mascara_texto_cnpj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/models/auth_login_models/SRM/cedente_model.dart';
import 'package:Srm_Asset/widgets/botao_selecao_empresa.dart';
import 'package:Srm_Asset/widgets/searchbar_person.dart';

import '../../../core/providers/conta_digital/conta_digital_provider.dart';
import '../../../core/providers/conta_digital/extrato/extrato_provider.dart';

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
            ?.where((item) =>
        item.nome.toLowerCase().contains(query) ||
            item.identificador.contains(query)) // Considera CNPJ
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
                    maxHeight: _searchResults!.length * 70.h, minHeight: 0),
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
                        final extratoProvider = Modular.get<ExtratoProvider>();
                        final contaProvider = Modular.get<ContaDigitalProvider>();
                        final dados = await extratoProvider.pegarExtratos(contaProvider.dadosContaDigital!.conta, DateTime.now().toIso8601String(), DateTime.now().toIso8601String());

                      },
                      child: SizedBox(
                        height: 70.h,
                        child: ListTile(
                          title:  Text(
                            _searchResults![index].nome,
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle:  CNPJText(
                            cnpjOuCpf: _searchResults![index]
                                .identificador,
                          ),
                          trailing: Visibility(
                            visible: _searchResults![index]
                                .assinaturaPendente >
                                0,
                            child: CircleAvatar(
                                backgroundColor: Color(0xffF29146),
                                radius: 15.r,
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
                                          .textTheme.bodyMedium!
                                          .copyWith(
                                          color: Colors.white)),
                                )),
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
