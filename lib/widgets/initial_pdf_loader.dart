import 'package:flutter/material.dart';
import 'package:pdf_reader_app/models/pdf_document.dart';
import 'package:pdf_reader_app/screens/home_screen.dart';
import 'package:pdf_reader_app/screens/pdf_viewer_page.dart';
import '../utils/utils.dart';

class InitialPdfLoader extends StatelessWidget {
  const InitialPdfLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getInitialPdfPath(),
      builder: (context, pdfSnapshot) {
        if (pdfSnapshot.connectionState == ConnectionState.done &&
            pdfSnapshot.hasData &&
            pdfSnapshot.data != null) {
          final pdfPath = pdfSnapshot.data!;
          final pdfDocument = PdfDocument(
            name: pdfPath.split('/').last,
            path: pdfPath,
            status: 'abierto',
            date: DateTime.now(),
          );
          return PdfViewerPage(pdfDocument: pdfDocument);
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
