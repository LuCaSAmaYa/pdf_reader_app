import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../services/pdf_functions.dart';
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_data.dart';
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';

class PdfViewerPage extends ConsumerStatefulWidget {
  final PdfDocument pdfDocument;

  const PdfViewerPage({super.key, required this.pdfDocument});

  @override
  ConsumerState<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends ConsumerState<PdfViewerPage> {
  late PdfDocument pdfDocument;

  @override
  void initState() {
    super.initState();
    pdfDocument = widget.pdfDocument;

    Future.microtask(() {
      if (pdfDocument.originalPath.isEmpty) {
        final updatedPdf = PdfDocument(
          name: pdfDocument.name,
          path: pdfDocument.path,
          status: pdfDocument.status,
          date: pdfDocument.date,
          originalPath: pdfDocument.path,
        );
        ref.read(pdfHistoryProvider.notifier).updatePdf(updatedPdf);
        setState(() {
          pdfDocument = updatedPdf;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: themeState.isDarkTheme ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          appStrings.getString('app_name'),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))
            ],
            color: themeState.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: themeState.isDarkTheme ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.save,
                size: 30, color: subThemes[themeState.selectedSubTheme]),
            tooltip: appStrings.getString('save_pdf'),
            onPressed: () async {
              final Completer<PdfDocument?> completer = Completer<PdfDocument?>();
              final state = this;

              savePdfAs(context, ref, pdfDocument).then((updatedPdfDocument) {
                print('pdf_viewer: savePdfAs completado con: ${updatedPdfDocument?.toJson()}');
                completer.complete(updatedPdfDocument);
              }).catchError((error) {
                print('pdf_viewer: Error en savePdfAs: $error');
                completer.completeError(error);
                if (state.mounted) {
                  ScaffoldMessenger.of(state.context).showSnackBar(
                    SnackBar(
                        content: Text(
                            appStrings.getString('error_saving') +
                                error.toString())),
                  );
                }
              }).whenComplete(() async {
                final updatedPdfDocument = await completer.future;

                if (state.mounted && updatedPdfDocument != null) {
                  print('pdf_viewer: updatePdf llamado con: ${updatedPdfDocument.toJson()}');
                  ref.read(pdfHistoryProvider.notifier).updatePdf(updatedPdfDocument);
                  setState(() {
                    pdfDocument = updatedPdfDocument;
                  });
                  ScaffoldMessenger.of(state.context).showSnackBar(
                    SnackBar(
                        content: Text(
                            '${appStrings.getString('file_saved')} ${updatedPdfDocument.path}')),
                  );
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: themeState.isDarkTheme
          ? themeState.darkBackgroundColor
          : Colors.white,
      body: PDFView(
        filePath: pdfDocument.path,
      ),
    );
  }
}