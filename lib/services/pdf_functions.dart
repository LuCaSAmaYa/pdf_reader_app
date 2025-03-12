import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import '../main.dart';
import '../widgets/app_button.dart';
import '../widgets/pdf_widgets/pdf_file_name_text_field.dart';
import '../providers/theme_provider.dart'; //Se importa el provider
import '../utils/app_strings.dart';//Se importa appStrings

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
       final themeState = ref.watch(themeProvider);
       final appStrings = AppStrings(themeState.locale);//Se crea la variable.
  return showDialog<PdfDocument>(
    //Se utiliza el context del navigator key
    context: ref.read(navigationProvider).navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(appStrings.getString('save_pdf')), //Se modifica el texto para que utilice appStrings
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Se usa el widget
            PdfFileNameTextField(fileNameController: fileNameController),
          ],
        ),
        actions: [
          //Se utiliza el nuevo widget para cancelar.
          AppButton(
            onPressed: () {
              Navigator.of(ref.read(navigationProvider).navigatorKey.currentContext!).pop(null);
            },
            icon: Icons.cancel,
            text: 'cancel',
            useSubThemeColor: false, //Se modifica el parametro
             iconSize: 35, //Se añade el parametro.
          ),
          //Se utiliza el nuevo widget para guardar.
          AppButton(
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
                  Navigator.of(ref.read(navigationProvider).navigatorKey.currentContext!).pop(updatedPdf);
                } catch (e) {
                  //Se elimina el uso del context directamente.
                  Navigator.of(ref.read(navigationProvider).navigatorKey.currentContext!).pop(null);
                }
              }
            },
            icon: Icons.save,
            text: 'save',
            useSubThemeColor: false, //Se modifica el parametro
            iconSize: 35,//Se añade el parametro.
          ),
        ],
      );
    },
  );
}
