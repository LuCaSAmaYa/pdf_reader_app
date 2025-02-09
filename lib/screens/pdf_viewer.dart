// lib/pdf_viewer.dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../services/pdf_functions.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Visor de PDFs",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, size: 30),
            tooltip: 'Guardar PDF',
            onPressed: () => savePdfAs(context, pdfPath),
          ),
        ],
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
