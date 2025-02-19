import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'pdf_viewer.dart';
import '../widgets/menu_drawer.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../utils/theme_data.dart'; // Importa theme_data.dart

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  String? pdfPath;

  Future<void> pickPdfFile() async {
    const XTypeGroup typeGroup = XTypeGroup(label: 'PDFs', extensions: ['pdf']);
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
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    bool isDark = themeState.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appStrings.getString('app_name'),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: const [Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))],
            color: isDark ? Colors.white : Colors.black, // Cambia el color del texto del AppBar
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white, // Cambia el color del AppBar
        iconTheme: IconThemeData(color: subThemes[themeState.selectedSubTheme]), // Cambia el color del icono de hamburguesa
        leading: Transform.scale( // <-- Escala el IconButton
          scale: 1.2, // <-- Aumenta el tamaño en un 50%
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                iconSize: 36, // <-- Aumenta el tamaño del icono
              );
            },
          ),
        ),
      ),
      drawer: const MenuDrawer(),
      backgroundColor: isDark ? themeState.darkBackgroundColor : Colors.white, // Cambia el color de fondo del Scaffold
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appStrings.getString('welcome'),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: subThemes[themeState.selectedSubTheme], // Usa el color del subtema
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
                appStrings.getString('select_pdf'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: subThemes[themeState.selectedSubTheme], // Usa el color del subtema para el boton
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