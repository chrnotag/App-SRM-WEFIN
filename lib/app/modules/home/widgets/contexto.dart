import 'package:flutter/material.dart';
import 'package:flutter_mobile_project/app/core/ui/theme/globals.dart';

class ContextoWidget extends StatefulWidget {
  const ContextoWidget({Key? key}) : super(key: key);

  @override
  _ContextoWidgetState createState() => _ContextoWidgetState();
}

class _ContextoWidgetState extends State<ContextoWidget> {
  List<String> gruposEmpresariais = [
    'Grupo 1',
    'Grupo 2',
    'Grupo 3',
    // Adicione mais grupos aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20), // Adiciona espaçamento
              const Text(
                'Empresas do grupo econômico',
                style: TextStyle(
                  fontSize: AppSizes.fontSizeMedium,
                  color: AppColors.branco,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10), // Adiciona espaçamento
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: const Border.fromBorderSide(
                    BorderSide(
                      color: AppColors.branco,
                      width: 1,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Center(
                  child: Text(
                    'VER CONSOLIDADO DO GRUPO',
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeSmall,
                      color: AppColors.branco,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildGrupoEmpresarialSelection(),
      ],
    );
  }

  Widget _buildGrupoEmpresarialSelection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Digite a empresa que deseja buscar',
                hintStyle: const TextStyle(color: AppColors.labelText, fontSize: AppSizes.fontSizeRegular),
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.labelText,
                  size: 30.0,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ListView.builder(
            shrinkWrap: true,
            itemCount: gruposEmpresariais.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(gruposEmpresariais[index]),
                value: false,
                onChanged: (value) {},
              );
            },
          ),
        ],
      ),
    );
  }
}
