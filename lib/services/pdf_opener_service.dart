import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import '../screens/pdf_viewer_page.dart';
import 'dart:async';

class PdfOpenerService {
  final WidgetRef ref;
  final BuildContext context;

  PdfOpenerService(this.ref, this.context);

  Future<void> pickPdfFile() async {
    const XTypeGroup typeGroup = XTypeGroup(label: 'PDFs', extensions: ['pdf']);
    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      _openPdf(file.path, null, 'abierto');
    }
  }

  Future<void> openPdfFromExternalApp(String path) async {
    _openPdf(path, path, 'abierto');
  }

  void _openPdf(String path, String? originalPath, String status) {
    final now = DateTime.now();
    final pdfDocument = PdfDocument(
      name: path.split('/').last,
      path: path,
      originalPath: originalPath ?? '',
      status: status,
      date: now,
    );
    ref.read(pdfHistoryProvider.notifier).updatePdf(pdfDocument);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PdfViewerPage(pdfDocument: pdfDocument)),
    );
  }
}
