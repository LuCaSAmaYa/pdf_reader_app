import 'package:flutter/material.dart';
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class MoreInfoScreen extends ConsumerWidget {
  const MoreInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appStrings.getString('more_information'), // Corrección aquí (si aplica)
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appStrings.getString('personal_information'), // Corrección aquí (si aplica)
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('${appStrings.getString('name')} Tu nombre'), // Corrección aquí
            Text('${appStrings.getString('email')} Tu correo electrónico'), // Corrección aquí
            Text('${appStrings.getString('phone')} Tu número de teléfono'), // Corrección aquí
            Text('${appStrings.getString('address')} Tu dirección'), // Corrección aquí
            const SizedBox(height: 20),
            Text(
              appStrings.getString('contact_information'), // Corrección principal aquí
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Puedes agregar más información de contacto aquí
          ],
        ),
      ),
    );
  }
}