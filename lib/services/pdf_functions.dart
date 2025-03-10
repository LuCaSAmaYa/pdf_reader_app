import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_reader_app/providers/theme_provider.dart';
import 'package:pdf_reader_app/utils/app_strings.dart';
import 'package:path/path.dart' as p;
import '../utils/theme_data.dart';
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import '../screens/initial_setup_screen.dart';

Future<PdfDocument?> savePdfAs(WidgetRef ref, PdfDocument pdfDocument) async {
  final themeState = ref.read(themeProvider);
  final appStrings = AppStrings(themeState.locale);

  String fileName = p.basenameWithoutExtension(pdfDocument.path);
  TextEditingController fileNameController = TextEditingController(text: fileName);
  
  return _showSaveDialog(ref, fileNameController, appStrings, themeState, pdfDocument);
}

Future<PdfDocument?> _showSaveDialog(
    WidgetRef ref,
    TextEditingController fileNameController,
    AppStrings appStrings,
    ThemeState themeState,
    PdfDocument pdfDocument,
    ) {
  return showDialog<PdfDocument>(
    context: ref.read(navigationProvider).navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: themeState.isDarkTheme ? themeState.darkBackgroundColor : Colors.white,
        title: Text(
          appStrings.getString('save_pdf'),
          style: TextStyle(color: themeState.isDarkTheme ? Colors.white : Colors.black),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: fileNameController,
            decoration: InputDecoration(
              labelText: appStrings.getString('file_name'),
              labelStyle: TextStyle(
                color: themeState.isDarkTheme ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            style: TextStyle(color: themeState.isDarkTheme ? Colors.white : Colors.black),
            maxLines: 3,
          ),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.cancel, size: 30),
            label: Text(
              appStrings.getString('cancel'),
              style: TextStyle(fontSize: 20, color: subThemes[themeState.selectedSubTheme]),
            ),
            onPressed: () {
              ref.read(navigationProvider).navigatorKey.currentState!.pop(null);
            },
          ),
          TextButton.icon(
            icon: const Icon(Icons.save, size: 30),
            label: Text(
              appStrings.getString('save'),
              style: TextStyle(fontSize: 20, color: subThemes[themeState.selectedSubTheme]),
            ),
            onPressed: () async {
              if (fileNameController.text.isNotEmpty) {
                try {
                  Directory? directory = await getExternalStorageDirectory();
                  directory ??= await getApplicationDocumentsDirectory();
                  String newPath = p.join(directory.path, '${fileNameController.text}.pdf');
                  File originalFile = File(pdfDocument.path);
                  await originalFile.copy(newPath);

                  final updatedPdf = PdfDocument(
                    name: '${fileNameController.text}.pdf',
                    path: newPath,
                    status: 'guardado',
                    date: DateTime.now(),
                    originalPath: pdfDocument.path,
                  );

                  ref.read(pdfHistoryProvider.notifier).updatePdf(updatedPdf);
                  ref.read(navigationProvider).navigatorKey.currentState!.pop(updatedPdf);
                } catch (e) {
                  ref.read(navigationProvider).navigatorKey.currentState!.pop(null);
                }
              }
            },
          ),
        ],
      );
    },
  );
}
