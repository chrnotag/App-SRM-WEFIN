import 'package:Srm_Asset/core/constants/extensions/num_extension.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/utils/data_format.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_provider.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';

part 'interior_itens/interior_assinantes.dart';

part 'item_text_card.dart';

part 'item_lista_interno_card.dart';

part 'interior_itens/widget_assinantes.dart';

class CardMonitorOperacoes extends StatefulWidget {
  final MonitorAssinaturasModel assinatura;

  const CardMonitorOperacoes({super.key, required this.assinatura});

  @override
  State<CardMonitorOperacoes> createState() => _CardMonitorOperacoesState();
}

class _CardMonitorOperacoesState extends State<CardMonitorOperacoes>
    with SingleTickerProviderStateMixin {
  bool cardExpandido = false;

  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int ID_PAPEL = 0;
    const int ID_PROCURADOR = 1;

    final assinatura = widget.assinatura;
    List<Widget> buildPapeisAndAssinantes(int idRetorno) {
      List<Widget> textoPapel = [];
      List<Widget> textoProcurador = [];
      final authProvider = Modular.get<AuthProvider>();
      for (var assinante in assinatura.assinantes) {
        if (assinante.identificadorAssinante ==
            authProvider.dataUser!.identificadorUsuario) {
          for (var infoAssinante in assinante.informacoesAssinante) {
            if (infoAssinante.nomeProcurador != null) {
              textoProcurador.add(Text(infoAssinante.nomeProcurador!));
            }
            for (var papel in infoAssinante.papeis) {
              textoPapel.add(Text(
                papel,
                style: context.textTheme.bodyLarge!.copyWith(
                    color: Color(0XFF838383), fontWeight: FontWeight.bold),
              ));
            }
          }
        }
      }
      switch (idRetorno) {
        case ID_PAPEL:
          return textoPapel;
        case ID_PROCURADOR:
          return textoProcurador;
        default:
          throw Exception();
      }
    }

    void _toggleExpand() {
      setState(() {
        cardExpandido = !cardExpandido;
        if (cardExpandido) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    }

    return Container(
      padding: EdgeInsets.all(8.r),
      margin: EdgeInsets.zero,
      width: 389.w,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            side: BorderSide(color: context.bordaCardColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ItemTextCard(
                      titulo: 'Operação',
                      conteudo: "${assinatura.codigoOperacao}"),
                  _ItemTextCard(
                      titulo: "Produto", conteudo: assinatura.siglaProduto),
                  _ItemTextCard(
                      titulo: "Data",
                      conteudo:
                          FormatarData.formatarPtBR(assinatura.dataOperacao))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ItemListaInterior(
                      titulo: "Papéis",
                      conteudo: buildPapeisAndAssinantes(ID_PAPEL)),
                  _ItemTextCard(
                      titulo: 'Valor Bruto',
                      conteudo: assinatura.valorBruto.toBRL)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
                        style: context.textTheme.bodyMedium,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0XFFE1C11A),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.r))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.r, vertical: 4.r),
                          child: Text(
                            assinatura.statusAssinaturaDigital,
                            style: context.textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _ItemListaInterior(
                      titulo: "Procurador",
                      conteudo: buildPapeisAndAssinantes(ID_PROCURADOR))
                ],
              ),
            ),
            Visibility(
                visible: !cardExpandido,
                child: Divider(
                  color: context.bordaCardColor,
                )),
            SizeTransition(
              sizeFactor: _heightAnimation,
              axis: Axis.vertical,
              child: Visibility(
                  visible: cardExpandido,
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _InteriorAssinantes(
                                assinatura: assinatura,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: BotaoPadrao(
                            label: 'Assinar Operação',
                            onPressed: () {
                              final authProvider = Modular.get<AuthProvider>();
                              final assinaturaProvider =
                                  Modular.get<AssinaturaProvider>();
                              assinaturaProvider.assinaturaSelecionada =
                                  assinatura;
                              AssinaturaEletronicaProvider
                                  assinaturaEletronicaProvider =
                                  Modular.get<AssinaturaEletronicaProvider>();
                              assinaturaEletronicaProvider.codigoOperacao =
                                  widget.assinatura.codigoOperacao;
                              IniciarAssinaturaProvider iniciarAssinatura =
                                  Modular.get<IniciarAssinaturaProvider>();
                              iniciarAssinatura.IniciarAssinatura(
                                  iniciarAssinatura
                                      .obterInformacoesUsuarioLogado(
                                          assinatura,
                                          authProvider
                                              .dataUser!.identificadorUsuario),
                                  context);
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              width: context.width,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                onTap: () {
                  _toggleExpand();
                },
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Text(
                    cardExpandido ? "Menos Detalhes" : "Mais Detalhes",
                    style: context.textTheme.displaySmall!.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
