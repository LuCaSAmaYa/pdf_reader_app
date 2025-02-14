import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'pdf_viewer.dart';
import '../widgets/menu_drawer.dart';
import '../providers/theme_provider.dart';

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
    bool isDark = themeState.isDarkTheme;

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
