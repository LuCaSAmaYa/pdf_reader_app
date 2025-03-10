import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pdf_document.dart';

class PdfHistoryNotifier extends StateNotifier<List<PdfDocument>> {
  PdfHistoryNotifier() : super([]) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList('pdfHistory') ?? [];
      state = historyJson
          .map((json) => PdfDocumentJson.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      // Puedes manejar el error de otra manera si es necesario
    }
  }

  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson =
          state.map((pdf) => jsonEncode(pdf.toJson())).toList();
      await prefs.setStringList('pdfHistory', historyJson);
    } catch (e) {
      // Puedes manejar el error de otra manera si es necesario
    }
  }

  void addPdf(PdfDocument pdfDocument) {
    state = [...state, pdfDocument];
    _saveHistory();
  }

  void updatePdf(PdfDocument updatedPdfDocument) {
    final newState = [...state];
    bool updated = false;

    for (int i = 0; i < newState.length; i++) {
      final pdf = newState[i];
      if ((pdf.originalPath == updatedPdfDocument.originalPath && pdf.originalPath.isNotEmpty) || (pdf.path == updatedPdfDocument.path)) {
        newState[i] = updatedPdfDocument;
        updated = true;
        break;
      }
    }
    if (updated == false) {
      newState.add(updatedPdfDocument);
    }

    state = newState;
    _saveHistory();
  }
}

final pdfHistoryProvider =
    StateNotifierProvider<PdfHistoryNotifier, List<PdfDocument>>(
        (ref) => PdfHistoryNotifier());
