import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/enuns/enum_selecionar_data_relatorio.dart';
import 'package:Srm_Asset/core/constants/enuns/relatorio_enum.dart';
import 'package:Srm_Asset/core/constants/extensions/date_extensions.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/relatorio_titulos_provider/relatorio_titulos_provider.dart';
import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:Srm_Asset/models/relatorio_titulos/query_status_model/query_parameters.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class SelecionarDataRelatorioScreen extends StatefulWidget {
  final SelecionarDataRelatorioEnum chave;

  const SelecionarDataRelatorioScreen({super.key, required this.chave});

  @override
  State<SelecionarDataRelatorioScreen> createState() =>
      _SelecionarDataRelatorioScreenState();
}

class _SelecionarDataRelatorioScreenState
    extends State<SelecionarDataRelatorioScreen> {
  TextEditingController _controllerDataInicial = TextEditingController();
  TextEditingController _controllerDataFinal = TextEditingController();
  DateTime _ultimaData = DateTime.now();
  DateTime? _dataInicialSelecionada;
  DateTime? _dataFinalSelecionada;
  final relatorioProvider = Modular.get<RelatorioTitulosProvider>();

  @override
  void dispose() {
    super.dispose();
    _dataFinalSelecionada = null;
    _dataInicialSelecionada = null;
    _controllerDataFinal.text = '';
    _controllerDataInicial.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Text(
                'Selecione o período de até 3 meses para filtrar os Títulos ${widget.chave.label}.',
                style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: SRMColors.textBodyColor,
                    fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 64.h, bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data inicial',
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: SRMColors.textBodyColor),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          controller: _controllerDataInicial,
                          decoration: InputDecoration(
                              hintText: 'Selecionar período',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.labelTextColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                          onChanged: (value) {
                            setState(() {
                              _controllerDataInicial.text = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      surfaceTintColor: Colors.white,
                                      child: CalendarDatePicker(
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now(),
                                          onDateChanged: (time) {
                                            setState(() {
                                              _dataInicialSelecionada = time;
                                              _controllerDataInicial.text =
                                                  dateFormatter(time);
                                              _controllerDataFinal.text = '';
                                              ultimaData(
                                                  _dataInicialSelecionada!);
                                            });
                                            Modular.to.pop();
                                          }),
                                    ));
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            size: 45.r,
                            color: context.primaryColor,
                          ))
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 64.h, top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data final',
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: SRMColors.textBodyColor),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          controller: _controllerDataFinal,
                          decoration: InputDecoration(
                              hintText: 'Selecionar período',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: context.labelTextColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                          onChanged: (value) {
                            setState(() {
                              _controllerDataFinal.text = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      surfaceTintColor: Colors.white,
                                      child: CalendarDatePicker(
                                        firstDate: _dataInicialSelecionada!,
                                        initialDate: _dataInicialSelecionada!,
                                        lastDate: _ultimaData,
                                        onDateChanged: (time) {
                                          setState(() {
                                            _dataFinalSelecionada = time;
                                            _controllerDataFinal.text =
                                                dateFormatter(time);
                                          });
                                          Modular.to.pop();
                                        },
                                      ),
                                    ));
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            size: 45.r,
                            color: context.primaryColor,
                          ))
                    ],
                  )
                ],
              ),
            ),
            BotaoPadrao(
                label: 'Filtrar',
                onPressed: _controllerDataInicial.text.isNotEmpty &&
                        _controllerDataFinal.text.isNotEmpty
                    ? () async {
                        late RelatorioQueryParams params;
                        switch (widget.chave.relatorioEnum) {
                          case RelatorioEnum.VENCIDO:
                          case RelatorioEnum.A_VENCER:
                            params = RelatorioQueryParams(
                                dataInicialAVencer:
                                    _dataInicialSelecionada!.formatarIso8601,
                                dataFinalAVencer:
                                    _dataFinalSelecionada!.formatarIso8601);
                          case RelatorioEnum.LIQUIDADO:
                            params = RelatorioQueryParams(
                                dataInicialLiquidacao:
                                    _dataInicialSelecionada!.formatarIso8601,
                                dataFinalLiquidacao:
                                    _dataFinalSelecionada!.formatarIso8601);
                          default:
                            throw Exception(
                                'Status inválido ${widget.chave.relatorioEnum?.name}');
                        }
                        OverlayApp.iniciaOverlay(context);
                        await relatorioProvider.recuperarTitulos(params);
                        OverlayApp.terminaOverlay();
                        Modular.to.pop();
                      }
                    : null)
          ],
        ),
      ),
    );
  }

  String dateFormatter(DateTime data) {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(data);
  }

  void ultimaData(DateTime dataInicial) {
    // Calcula a diferença em dias entre a data inicial e a data atual
    int diferencaDias = DateTime.now().difference(dataInicial).inDays;

    // Define a quantidade de dias a adicionar, garantindo que não ultrapasse 90 dias
    int diasParaAdicionar = (diferencaDias > 90) ? 90 : diferencaDias;

    // Adiciona a quantidade de dias calculada
    DateTime lastDate = dataInicial.add(Duration(days: diasParaAdicionar));

    // Atualiza o estado com a nova data
    setState(() {
      _ultimaData = lastDate;
    });
  }
}
