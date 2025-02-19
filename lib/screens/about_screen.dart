import 'package:flutter/material.dart';
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            appStrings.getString('about'), // Corrección aquí
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          appStrings.getString('about_text'), // Corrección aquí
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 18,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}