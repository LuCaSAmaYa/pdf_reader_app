import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import '../screens/initial_setup_screen.dart';
import '../widgets/pdf_widgets/pdf_save_dialog.dart'; // Importar PdfSaveDialog

Future<PdfDocument?> savePdfAs(WidgetRef ref, PdfDocument pdfDocument) async {
  String fileName = p.basenameWithoutExtension(pdfDocument.path);
  TextEditingController fileNameController = TextEditingController(text: fileName);
  
  //Se llama a la nueva funcion con los parametros necesarios.
  return _showSaveDialog(ref, fileNameController, pdfDocument);
}

//Funcion para mostrar el dialog
Future<PdfDocument?> _showSaveDialog(
    WidgetRef ref,
    TextEditingController fileNameController,
    PdfDocument pdfDocument) {
  return showDialog<PdfDocument>(
    context: ref.read(navigationProvider).navigatorKey.currentContext!,
    builder: (BuildContext context) {
        //Se llama al nuevo Widget.
      return PdfSaveDialog(
        fileNameController: fileNameController,
        // Se crean las funciones que se llamaran en el Widget.
        onSavePressed: () async {
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
        onCancelPressed: () {
          ref.read(navigationProvider).navigatorKey.currentState!.pop(null);
        },
      );
    },
  );
}
