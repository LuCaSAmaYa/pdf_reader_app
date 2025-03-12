import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import '../main.dart'; // <-- Importa el archivo main.dart.
import '../widgets/custom_button.dart';
import '../widgets/pdf_widgets/pdf_file_name_text_field.dart'; // Importar el antiguo widget

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
    //Se utiliza el context del navigator key
    context: ref.read(navigationProvider).navigatorKey.currentContext!, // <-- Ahora navigationProvider es accesible.
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Guardar Archivo PDF'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Se usa el antiguo widget
            PdfFileNameTextField(fileNameController: fileNameController),
          ],
        ),
        actions: [
          //Se utiliza el nuevo widget.
          CustomButton(
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
                  //Se elimina el uso del context directamente.
                  Navigator.of(ref.read(navigationProvider).navigatorKey.currentContext!).pop(updatedPdf); // <-- Ahora navigationProvider es accesible.
                } catch (e) {
                  //Se elimina el uso del context directamente.
                  Navigator.of(ref.read(navigationProvider).navigatorKey.currentContext!).pop(null); // <-- Ahora navigationProvider es accesible.
                }
              }
            },
            showCancelButton: true,
            showText: true, //Se añade el nuevo parametro.
            text: 'save', //Se añade el nuevo parametro
          )
        ],
      );
    },
  );
}
