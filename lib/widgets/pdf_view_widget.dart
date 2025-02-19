import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewWidget extends StatelessWidget {
  final String pdfPath;

  const PdfViewWidget({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: pdfPath,
    );
  }
}