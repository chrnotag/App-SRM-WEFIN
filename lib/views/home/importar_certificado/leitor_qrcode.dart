import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/baixar_certificado_impl.dart';
import 'package:Srm_Asset/core/providers/certificado_provider/importar_certificado_provider.dart';

class LeitorQrCode extends StatefulWidget {
  const LeitorQrCode({super.key});

  @override
  State<LeitorQrCode> createState() => _LeitorQrCodeState();
}

class _LeitorQrCodeState extends State<LeitorQrCode> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    ImportarCertificadoProvider provider =
        context.watch<ImportarCertificadoProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              onDetect: (capture) async {
                if (_isProcessing) return;
                _isProcessing = true;
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  BaixarCertificadoImpl.baixar(barcodes.first.rawValue!);
                  _controller.stop();
                }
                _isProcessing = false;
              },
            ),
          ),
          CustomPaint(
            size: Size.infinite,
            painter: ExpandedCornerBorderedHolePainter(context: context),
          ),
        ],
      ),
    );
  }
}

class ExpandedCornerBorderedHolePainter extends CustomPainter {
  BuildContext context;

  ExpandedCornerBorderedHolePainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.black.withOpacity(0.7);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    var squareSize = size.width * 0.6;
    var offset =
        Offset((size.width - squareSize) / 2, (size.height - squareSize) / 2);

    var holeRect = Rect.fromLTWH(offset.dx, offset.dy, squareSize, squareSize);
    var holeRRect = RRect.fromRectAndRadius(holeRect, Radius.circular(10));
    var holePath = Path()..addRRect(holeRRect);

    canvas.drawPath(
        holePath,
        Paint()
          ..color = Colors.transparent
          ..blendMode = BlendMode.clear);

    var borderPaint = Paint()
      ..color = context.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    var cornerRadius = 10.0;
    var arcLength = 0.5 * pi;

    canvas.drawArc(
        Rect.fromLTWH(offset.dx, offset.dy, 2 * cornerRadius, 2 * cornerRadius),
        pi,
        arcLength,
        false,
        borderPaint);
    canvas.drawArc(
        Rect.fromLTWH(offset.dx + squareSize - 2 * cornerRadius, offset.dy,
            2 * cornerRadius, 2 * cornerRadius),
        1.5 * pi,
        arcLength,
        false,
        borderPaint);
    canvas.drawArc(
        Rect.fromLTWH(offset.dx, offset.dy + squareSize - 2 * cornerRadius,
            2 * cornerRadius, 2 * cornerRadius),
        0.5 * pi,
        arcLength,
        false,
        borderPaint);
    canvas.drawArc(
        Rect.fromLTWH(
            offset.dx + squareSize - 2 * cornerRadius,
            offset.dy + squareSize - 2 * cornerRadius,
            2 * cornerRadius,
            2 * cornerRadius),
        0,
        arcLength,
        false,
        borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
