import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/initial_setup_screen.dart';
import 'initial_pdf_loader.dart';
import 'loading_screen.dart';

class InitialSetupChecker extends StatelessWidget {
  const InitialSetupChecker({super.key});
  Future<bool> _isInitialSetupComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('initialSetupComplete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isInitialSetupComplete(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }
        if (snapshot.data == false) {
          return const InitialSetupScreen();
        }
          return const InitialPdfLoader();
      },
    );
  }
}
