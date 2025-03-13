import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'pdf_viewer_page.dart';
import '../widgets/menu_drawer.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
//import '../utils/theme_data.dart';
import '../screens/initial_setup_screen.dart';
import 'dart:async';
import '../models/pdf_document.dart';
import '../providers/pdf_history_provider.dart';
import 'history_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/home_widgets/welcome_message.dart'; //Se añade el import.
import '../widgets/home_widgets/select_pdf_button.dart'; //Se añade el import.
import '../widgets/home_widgets/tap_detector.dart'; //Se añade el import.

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
          MaterialPageRoute(builder: (context) => PdfViewerPage(pdfDocument: pdfDocument)),
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
            shadows: const [Shadow(blurRadius: 5, color: Colors.black26, offset: Offset(2, 2))],
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: Transform.scale(
          scale: 1.2,
          child: Builder(
            builder: (BuildContext context) {
              return AppButton(
                icon: Icons.menu,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                useSubThemeColor: true,
                iconSize: 36,
              );
            },
          ),
        ),
        actions: [
          AppButton(
            icon: Icons.history,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
            useSubThemeColor: true,
            iconSize: 30,
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            const MenuDrawer(),
            TapDetector(onTap: _handleTap), //Se añade el widget.
          ],
        ),
      ),
      backgroundColor: isDark ? themeState.darkBackgroundColor : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WelcomeMessage(), //Se añade el widget.
            const SizedBox(height: 30),
            SelectPdfButton(onPressed: pickPdfFile), //Se añade el widget.
          ],
        ),
      ),
    );
  }
}
