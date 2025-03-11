import 'package:flutter/services.dart';

//Se crea la funcion para obtener la ruta inicial del pdf
  Future<String?> getInitialPdfPath() async {
    const platform = MethodChannel('com.example.pdf_reader_app/pdf');
    try {
      final String? result = await platform.invokeMethod('getInitialPdfPath');
      return result;
    } on PlatformException catch (_) {
      return null;
    }
  }
