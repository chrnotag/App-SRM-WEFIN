import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/enuns/status_minhas_transferencias_enum.dart';
import 'package:Srm_Asset/core/constants/enuns/tipo_conta_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/size_screen_media_query.dart';
import 'package:Srm_Asset/core/constants/extensions/string_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/utils/cpf_cnpj_fomatter.dart';
import 'package:Srm_Asset/core/providers/conta_digital/conta_digital_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/solicitacao_ted/solicitacao_ted_provider.dart';
import 'package:Srm_Asset/core/providers/conta_digital/solicitar_ted/solicitar_ted_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/views/transferencias/widgets/banco_dropdown.dart';
import 'package:Srm_Asset/widgets/loader_widget.dart';
import 'package:Srm_Asset/widgets/mensagem_tela_vazia.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/constants/classes_abstratas/envirioment.dart';
import '../../core/providers/ted_terceiros/ted_terceiros_impl.dart';
import '../../models/conta_digital/bancos/bancos_model.dart';
import '../ted_terceiros/widgets/item_card_ted.dart';
import '../ted_terceiros/widgets/visualizar_pdf_ted.dart';

part 'widgets/campo_texto.dart';

part 'widgets/alert_codigo_verificacao.dart';

part 'widgets/alert_completo.dart';

part 'widgets/campo_texto_codigo.dart';

part 'widgets/card_minhas_transferencias.dart';

part 'minhas_transferencias.dart';

part 'transferencia_ted.dart';

class Transferencias extends StatefulWidget {
  const Transferencias({super.key});

  @override
  State<Transferencias> createState() => _TransferenciasState();
}

class _TransferenciasState extends State<Transferencias>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transferência',
          style: context.textTheme.displaySmall!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Expanded(
            child: Container(
              color: context.backgroundColor,
              child: TabBar(
                dividerColor: Colors.transparent,
                unselectedLabelColor: context.labelTextColor,
                controller: _tabController,
                tabs: [
                  Tab(text: "Transferência TED"),
                  Tab(text: "Minhas Transferências"),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TransferenciasTed(),
          _MinhasTransferencias(),
        ],
      ),
    );
  }
}
