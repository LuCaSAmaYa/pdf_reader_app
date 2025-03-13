import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_strings.dart';
import '../../utils/theme_data.dart';

class WelcomeMessage extends ConsumerWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    return Text(
      appStrings.getString('welcome'),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: subThemes[themeState.selectedSubTheme],
      ),
      textAlign: TextAlign.center,
    );
  }
}
