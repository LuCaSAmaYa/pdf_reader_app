// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart'; // Importamos file_selector
import 'pdf_viewer.dart';
import '../widgets/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  final Function(String, bool) onThemeChanged;

  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? pdfPath; // Ruta del archivo PDF seleccionada

  // Función para seleccionar un archivo PDF
  Future<void> pickPdfFile() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'PDFs',
      extensions: ['pdf'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

    if (file != null && mounted) {
      setState(() {
        pdfPath = file.path;
      });
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfViewerPage(pdfPath: pdfPath!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lector de PDFs",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))],
          ),
        ),
      ),
      drawer: const MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bienvenido",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: pickPdfFile,
              icon: Icon(
                Icons.picture_as_pdf,
                size: 30,
                color: isDark ? Colors.white : Colors.black,
              ),
              label: Text(
                'SELECCIONAR PDF',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Theme.of(context).primaryColor,
                shadowColor: Colors.black45,
                elevation: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
