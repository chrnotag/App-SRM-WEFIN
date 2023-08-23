import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';

import '../../../constantes/lista_empresas.dart';
import '../../models/usuario_logado/cedente_model.dart';

class ListaEmpresas extends StatelessWidget {
  const ListaEmpresas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.globalBackgroung,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_image.png'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              Divider(color: Colors.blue.shade700, thickness: 0.5),
              const Text(
                'Empresas do grupo econômico',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ListaDeEmpresas.listaEmpresas[0].nome.toString(),
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Digite a empresa que deseja buscar',
                        icon: Icon(Icons.search)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BotaoDropdown(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BotaoDropdown extends StatefulWidget {
  const BotaoDropdown({super.key});

  @override
  State<BotaoDropdown> createState() => _BotaoDropdownState();
}

class _BotaoDropdownState extends State<BotaoDropdown> {
  List<CedenteModel> dropdownValue = ListaDeEmpresas.listaEmpresas;

  CedenteModel? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = dropdownValue.first;
  }

  void _onDropdownChanged(CedenteModel? cedente) {
    setState(() {
      _selectedValue = cedente;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CedenteModel>(
      underline: Container(),
      dropdownColor: Colors.white,
      value: _selectedValue,
      icon: Container(),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: _onDropdownChanged,
      items: dropdownValue.map((CedenteModel cedente) {
        return DropdownMenuItem<CedenteModel>(
          alignment: Alignment.centerLeft,
          value: cedente,
          child: Text('${cedente.nome} | ${cedente.identificador}'),
        );
      }).toList(),
    );
  }
}
