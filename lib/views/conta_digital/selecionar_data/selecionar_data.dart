import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/constants/tema_configs.dart';
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
                      color: AppColors.labelText,
                      fontSize: 18.sp),
                ),
              ),
              Text(
                "A selação por período está limitada a três meses.",
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.cinzaEscuro),
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
                          color: AppColors.cinzaEscuro),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320.w,
                          child: TextField(
                            controller: _controllerDataInicial,
                            decoration: const InputDecoration(
                                hintText: 'Selecionar período',
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.labelText),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
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
                                              _dataInicialSelecionada = time;
                                              _controllerDataInicial.text =
                                                  dateFormatter(time);
                                              ultimaData(time);
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
                          color: AppColors.cinzaEscuro),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 320.w,
                          child: TextField(
                            controller: _controllerDataFinal,
                            decoration: const InputDecoration(
                                hintText: 'Selecionar período',
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.labelText),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    surfaceTintColor: Colors.white,
                                    child: CalendarDatePicker(
                                      firstDate: _ultimaData,
                                      initialDate: _ultimaData,
                                      lastDate: DateTime.now(),
                                      onDateChanged: (time){
                                        _dataFinalSelecionada = time;
                                        _controllerDataFinal.text = dateFormatter(time);
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
              BotaoPadrao(label: 'Pesquisar', onPressed: () {})
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
    // Subtrai 2 meses da data inicial
    DateTime lastDate =
        DateTime(dataInicial.year, dataInicial.month - 3, dataInicial.day);

    // Verifica se a data resultante é válida
    if (lastDate.day != dataInicial.day) {
      // Se não for, ajusta para o último dia do mês anterior
      lastDate = DateTime(dataInicial.year, dataInicial.month - 2 + 1, 0);
    }
    setState(() {
      _ultimaData = lastDate;
    });
  }
}
