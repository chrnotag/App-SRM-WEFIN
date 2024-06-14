import 'package:Srm_Asset/core/constants/configs_tema/export_config_theme_srm.dart';
import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:Srm_Asset/views/conta_digital/widgets/app_bar_conta_digital.dart';
import 'package:Srm_Asset/widgets/wefin_patterns/wefin_default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class SelecionarDataScreen extends StatefulWidget {
  const SelecionarDataScreen({super.key});

  @override
  State<SelecionarDataScreen> createState() => _SelecionarDataScreenState();
}

TextEditingController _controllerDataInicial = TextEditingController();
TextEditingController _controllerDataFinal = TextEditingController();
DateTime _ultimaData = DateTime.now();
DateTime? _dataInicialSelecionada;
DateTime? _dataFinalSelecionada;

class _SelecionarDataScreenState extends State<SelecionarDataScreen> {
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const AppBarExtrato(),
      ),
      body: Card(
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Text(
                  'Selecione o período:',
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.labelTextColor,
                      fontSize: 18.sp),
                ),
              ),
              Text(
                "A selação por período está limitada a três meses.",
                style: context.textTheme.bodyMedium!
                    .copyWith(color: SRMColors.onBackgorundColor),
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
                          color: SRMColors.onBackgorundColor),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320.w,
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
                                                ultimaData(time);
                                                _controllerDataFinal.text = '';
                                              });
                                              Modular.to.pop();
                                            }),
                                      ));
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              size: 45.r,
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
                          color: SRMColors.onBackgorundColor),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320.w,
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
                            ))
                      ],
                    )
                  ],
                ),
              ),
              BotaoPadrao(
                  label: 'Pesquisar',
                  onPressed: _controllerDataInicial.text.isNotEmpty &&
                          _controllerDataFinal.text.isNotEmpty
                      ? () {
                    final extratoProvider = Modular.get<ExtratoProvider>();
                    extratoProvider.dataInicial = _dataFinalSelecionada!;
                    extratoProvider.dataFinal = _dataInicialSelecionada!;
                    Modular.to.pushNamed(AppRoutes.extratoDataSelecionadaDigitalScreenRoute);
                  }
                      : null)
            ],
          ),
        ),
      ),
    );
  }

  String dateFormatter(DateTime data) {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(data);
  }

  void ultimaData(DateTime dataInicial) {
    DateTime lastDate = dataInicial.add(Duration(days: 90));
    setState(() {
      _ultimaData = lastDate;
    });
  }
}
