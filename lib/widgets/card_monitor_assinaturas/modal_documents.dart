import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/widgets/card_monitor_assinaturas/pdf_viewer.dart';
import 'package:modular_study/widgets/wefin_patterns/wefin_default_button.dart';

class ModalListDocuments {
  BuildContext context;

  ModalListDocuments({required this.context});

  Widget get popUp {
    return AlertDialog(
      title: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    LineIcons.file,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 20,
                  ),
                  Text('Lista de documentos',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 1.5,
                      ))
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Lista de Documentos',
                    style: context.textTheme.labelSmall!.copyWith(
                        color: AppColors.azul,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
                Text('Operação 505615',
                    style: context.textTheme.labelSmall!.copyWith(
                      color: AppColors.labelText,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Documento',
                        style: context.textTheme.labelSmall!.copyWith(
                          color: AppColors.labelText,
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        )),
                    Text("Documento.pdf",
                        style: context.textTheme.labelSmall!.copyWith(
                          color: AppColors.azul,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        ButtonBar(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: AppColors.brancoGelo,
                              ),
                              onPressed: () async {
                                String filePath =
                                    'path/to/your/pdf/file.pdf'; // Replace with the actual path

                                // Open the PDF in a new screen
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PDFViewerScreen(filePath: filePath),
                                  ),
                                );
                              },
                              child: Text('Ver',
                                  style: context.textTheme.labelSmall!.copyWith(
                                    color: AppColors.azul,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  )),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: AppColors.brancoGelo,
                              ),
                              onPressed: () {},
                              child: Text('Baixar',
                                  style: context.textTheme.labelSmall!.copyWith(
                                    color: AppColors.azul,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: BotaoPadrao(
                        onPressed: () {},
                        label: 'BAIXAR TODOS OS DOCUMENTOS',
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: BotaoPadrao(
                        onPressed: () {
                          Modular.to.pop();
                        },
                        label: 'FECHAR',
                        filled: false,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
