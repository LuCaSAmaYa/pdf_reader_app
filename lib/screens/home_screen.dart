import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'pdf_viewer_page.dart';
import '../widgets/menu_drawer.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../screens/initial_setup_screen.dart';
import 'dart:async';
import 'package:uni_links/uni_links.dart'; //Se añade.
import '../widgets/app_button.dart';
import '../widgets/home_widgets/welcome_message.dart';
import '../widgets/home_widgets/select_pdf_button.dart';
import '../widgets/home_widgets/tap_detector.dart';
import '../services/pdf_opener_service.dart'; //Se añade el import.
//import 'dart:io' show Platform; //Se añade el import.
import 'dart:developer'; //Se añade el import.
import 'history_screen.dart';
import 'package:flutter/services.dart';//Se añade el import.

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver { //Se añade WidgetsBindingObserver
  int _tapCount = 0;
  Timer? _timer;
  StreamSubscription? _sub;
  //Uri? _initialUri;
  //  Uri? _latestUri;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addObserver(this);
    _initURIHandler(); //Se llama a la nueva funcion.
     _incomingLinkHandler(); //Se llama a la nueva funcion.
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sub?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

    Future<void> _initURIHandler() async { //Se cambia la funcion.
    if(!mounted) return; //Se añade esta linea.
    try {
      final initialUri = await getInitialUri(); //Se utiliza la funcion de la dependencia.
      if (initialUri != null) {
        _handleExternalIntent(initialUri.path);
      }
    } on PlatformException {
      log('Failed to get initial uri');
    } on FormatException {
      log('Malformed initial uri');
    }
  }

  void _incomingLinkHandler() { //Se crea esta funcion.
    if (!mounted) return; //Se añade esta linea.
      _sub = uriLinkStream.listen((Uri? uri) { //Se utiliza la variable de la dependencia.
        if(uri!=null){
           _handleExternalIntent(uri.path);
        }
      }, onError: (Object err) {
        if (!mounted) return;
      });
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

  Future<void> _handleExternalIntent(String path) async {
    final pdfOpener = PdfOpenerService(ref, context);
    pdfOpener.openPdfFromExternalApp(path);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    bool isDark = themeState.isDarkTheme;
    final pdfOpener = PdfOpenerService(ref, context);

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
            TapDetector(onTap: _handleTap),
          ],
        ),
      ),
      backgroundColor: isDark ? themeState.darkBackgroundColor : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WelcomeMessage(),
            const SizedBox(height: 30),
            SelectPdfButton(onPressed: pdfOpener.pickPdfFile), //Se llama a la nueva funcion.
          ],
        ),
      ),
    );
  }
}
