import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../services/pdf_functions.dart';
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
//import '../utils/theme_data.dart';
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import '../widgets/custom_button.dart';//Se importa el nuevo widget

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
          //Se utiliza el nuevo widget.
            CustomButton(
              onPressed: () async {
                final Completer<PdfDocument?> completer = Completer<PdfDocument?>();
                final state = this;

                savePdfAs(ref, pdfDocument).then((updatedPdfDocument) {
                  completer.complete(updatedPdfDocument);
                }).catchError((error) {
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
               showText: false, //Se añade el nuevo parametro con false.
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
