import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/pdf_viewer.dart';
import 'utils/theme_provider.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';

void main() async {
  // Asegura que los bindings de Flutter se inicialicen antes de ejecutar la app
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Crea una instancia de ThemeProvider
  final themeProvider = ThemeProvider();

  // 2. Carga las preferencias del usuario (tema, color) antes de iniciar la interfaz
  await themeProvider.loadPreferences();

  // 3. Inicia la aplicación con MultiProvider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String? sharedPdfPath;

  @override
  void initState() {
    super.initState();

    // Escuchar PDFs compartidos cuando la app está abierta
    FlutterSharingIntent.instance.getMediaStream().listen((value) {
      if (value.isNotEmpty) {
        setState(() {
          sharedPdfPath = value.first.value;
        });
      }
    });

    // Capturar PDFs compartidos cuando la app es abierta desde otro lugar
    FlutterSharingIntent.instance.getInitialSharing().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          sharedPdfPath = value.first.value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Lector de PDFs',
          theme: themeProvider.getThemeData(),
          home: sharedPdfPath != null
              ? PdfViewerPage(pdfPath: sharedPdfPath!) // Si se recibe un PDF, lo abre directamente
              : HomeScreen(onThemeChanged: (String subTheme, bool isDark) {
                  themeProvider.changeSubTheme(subTheme);
                  themeProvider.toggleTheme(isDark);
                }),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
