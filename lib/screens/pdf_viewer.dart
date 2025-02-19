import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../services/pdf_functions.dart';
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_data.dart'; // Importa theme_data.dart

class PdfViewerPage extends ConsumerStatefulWidget {
  final String pdfPath;

  const PdfViewerPage({super.key, required this.pdfPath});

  @override
  ConsumerState<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends ConsumerState<PdfViewerPage> {
  late String pdfPath;

  @override
  void initState() {
    super.initState();
    pdfPath = widget.pdfPath;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeState.isDarkTheme ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          appStrings.getString('app_name'),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: const [Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))],
            color: themeState.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: themeState.isDarkTheme ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.save, size: 30, color: subThemes[themeState.selectedSubTheme]), // Cambia el color del icono
            tooltip: appStrings.getString('save_pdf'),
            onPressed: () async {
              final Completer<void> completer = Completer<void>();
              final state = this;

              savePdfAs(context, ref, pdfPath).then((_) {
                completer.complete();
              }).catchError((error) {
                completer.completeError(error);
                if (state.mounted) {
                  ScaffoldMessenger.of(state.context).showSnackBar(
                    SnackBar(content: Text(appStrings.getString('error_saving') + error.toString())),
                  );
                }
              }).whenComplete(() async {
                await completer.future;

                if (state.mounted) {
                  ScaffoldMessenger.of(state.context).showSnackBar(
                    SnackBar(content: Text(appStrings.getString('file_saved'))),
                  );
                }
              });
            },
          ),
        ],
      ),
      backgroundColor: themeState.isDarkTheme ? themeState.darkBackgroundColor : Colors.white,
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}