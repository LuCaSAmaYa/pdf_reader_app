import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'pdf_viewer.dart'; // Importar pdf_viewer.dart
import '../widgets/menu_drawer.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../utils/theme_data.dart';
import '../screens/initial_setup_screen.dart';
import 'dart:async';
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import 'history_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  String? pdfPath;
  int _tapCount = 0;
  Timer? _timer;

  Future<void> pickPdfFile() async {
    const XTypeGroup typeGroup = XTypeGroup(label: 'PDFs', extensions: ['pdf']);
    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

    if (file != null && mounted) {
      final now = DateTime.now();
      final pdfDocument = PdfDocument(
        name: file.name,
        path: file.path,
        status: 'abierto',
        date: now,
      );
      ref.read(pdfHistoryProvider.notifier).addPdf(pdfDocument);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PdfViewerPage(pdfDocument: pdfDocument)), // Usar PdfViewerPage
        );
      }
    }
  }

  void _handleTap() {
    _tapCount++;
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(seconds: 4), () {
      _tapCount = 0;
    });
    if (_tapCount == 7) {
      _tapCount = 0;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const InitialSetupScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
            shadows: const [
              Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))
            ],
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: subThemes[themeState.selectedSubTheme]),
        leading: Transform.scale(
          scale: 1.2,
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                iconSize: 36,
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            const MenuDrawer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: _handleTap,
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(bottom: 20, left: 20),
                      decoration: BoxDecoration(
                        color: subThemes[themeState.selectedSubTheme],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: isDark ? themeState.darkBackgroundColor : Colors.white,
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
                color: subThemes[themeState.selectedSubTheme],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: subThemes[themeState.selectedSubTheme],
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