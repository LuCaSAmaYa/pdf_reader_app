import 'package:flutter/material.dart';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

final Logger logger = Logger('PdfFunctionsLogger');

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

Future<void> savePdfAs(BuildContext context, String pdfPath) async {
  try {
    final originalName = path.basenameWithoutExtension(pdfPath);
    final newName = await _askFileName(context, originalName);

    if (newName == null) return;

    final Directory? extDir = await getExternalStorageDirectory();
    if (extDir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo acceder al almacenamiento')),
      );
      return;
    }

    final myDir = Directory(path.join(extDir.path, 'pdfdocs'));
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }

    final fileName = newName.endsWith('.pdf') ? newName : '$newName.pdf';
    final savePath = path.join(myDir.path, fileName);

    final File pdfFile = File(pdfPath);
    if (!await pdfFile.exists()) {
      logger.severe('El archivo PDF no existe en la ruta: $pdfPath');
      return;
    }

    await pdfFile.copy(savePath);

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