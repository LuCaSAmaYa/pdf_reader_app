// lib/pdf_functions.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

final Logger logger = Logger('PdfFunctionsLogger');

// Muestra un diálogo para que el usuario ingrese el nombre del archivo.
// Retorna el nombre ingresado o null si el usuario cancela.
Future<String?> _askFileName(BuildContext context, String defaultName) async {
  final TextEditingController controller = TextEditingController(text: defaultName);

  return showDialog<String>(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Text('Guardar PDF'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nombre del archivo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final enteredName = controller.text.trim();
              Navigator.of(ctx).pop(enteredName.isEmpty ? null : enteredName);
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

// Función para guardar el archivo PDF en la carpeta privada de la app,
// permitiendo cambiar el nombre antes de guardarlo.
Future<void> savePdfAs(BuildContext context, String pdfPath) async {
  try {
    // Nombre original (sin extensión)
    final originalName = path.basenameWithoutExtension(pdfPath);

    // Pide al usuario un nuevo nombre para el archivo
    final newName = await _askFileName(context, originalName);

    // Si el usuario canceló o no ingresó nada, no guardamos
    if (newName == null) return;

    // Obtener la carpeta de la app en almacenamiento externo privado
    final Directory? extDir = await getExternalStorageDirectory();
    if (extDir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo acceder al almacenamiento')),
      );
      return;
    }

    // Crea una subcarpeta opcional
    final myDir = Directory(path.join(extDir.path, 'pdfdocs'));
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }

    // Construir la ruta final
    // Agrega .pdf si no lo incluye el usuario
    final fileName = newName.endsWith('.pdf') ? newName : '$newName.pdf';
    final savePath = path.join(myDir.path, fileName);

    // Copiar el PDF
    final File pdfFile = File(pdfPath);
    await pdfFile.copy(savePath);

    // Mensaje de éxito
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo guardado en: $savePath')),
      );
    }
    logger.info('Archivo guardado exitosamente en: $savePath');
  } catch (e) {
    logger.severe('Error al guardar el archivo: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar el archivo: $e')),
      );
    }
  }
}
