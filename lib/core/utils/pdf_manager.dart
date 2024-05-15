import 'dart:io';
import 'dart:typed_data';
import 'package:Srm_Asset/core/providers/conta_digital/extrato/extrato_provider.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFUtils {
  static Future<void> sharePDF(Uint8List pdfBytes) async {
    final formatarData = DateFormat('MM-yyyy');
    final extratoProvider = Modular.get<ExtratoProvider>();
    final filename =
        "extrato_conta_digital_${formatarData.format(extratoProvider.dataFinal())}";

    // Obter o diretório temporário
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$filename.pdf';

    // Escrever os bytes como um arquivo PDF no diretório temporário
    final File pdfFile = File(path);
    await pdfFile.writeAsBytes(pdfBytes);

    // Compartilhar o arquivo PDF
    Share.shareFiles([path], text: filename);
  }
}




