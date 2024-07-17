import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PDFUtils {
  static Future<void> sharePDF(Uint8List? pdfBytes, String filename) async {
    if (pdfBytes != null) {
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
}




