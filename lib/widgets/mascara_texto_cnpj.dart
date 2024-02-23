import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class CNPJText extends StatelessWidget {
  final String cnpjOuCpf;

  CNPJText({required this.cnpjOuCpf});

  @override
  Widget build(BuildContext context) {
    String cnpjFormatado = formatarDocumento(cnpjOuCpf);

    return Text(
      cnpjFormatado,
      style: TextStyle(fontSize: 18.0),
    );
  }

  String formatarDocumento(String documento) {
    if (documento.length == 11) {
      // Se o tamanho for 11, é CPF
      return 'CPF ${documento.substring(0, 3)}.${documento.substring(3, 6)}.${documento.substring(6, 9)}-${documento.substring(9)}';
    } else if (documento.length == 14) {
      // Se o tamanho for 14, é CNPJ
      return 'CNPJ ${documento.substring(0, 2)}.${documento.substring(2, 5)}.${documento.substring(5, 8)}/${documento.substring(8, 12)}-${documento.substring(12)}';
    } else {
      // Se o tamanho for diferente de 11 ou 14, não é um CPF nem CNPJ válido
      return 'Documento inválido';
    }
  }
}
