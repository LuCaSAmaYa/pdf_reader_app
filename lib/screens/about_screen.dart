// lib/about_screen.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Acerca de',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Aplicación para leer archivos PDF, compartirlos y guardarlos de forma eficiente, sin publicidad. Disfruta de una experiencia limpia y rápida en la gestión de tus documentos.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 18,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
