import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

Future<void> savePdfAs(BuildContext context, WidgetRef ref, String pdfPath) async { // <-- Firma corregida: sin el State
  final appStrings = AppStrings(ref.read(themeProvider).locale);
  try {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        build: (pw.Context context) {
      return pw.Center(
        child: pw.Text(appStrings.getString('file_name'),
            style: pw.TextStyle(fontSize: 20)),
      );
    }));

    final directory = await getDownloadsDirectory();
    final fileName = 'documento_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final filePath = '${directory?.path}/$fileName';
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());

    // Ya no se muestra el SnackBar aquí

  } catch (e) {
    // Ya no se muestra el SnackBar aquí
  }
}