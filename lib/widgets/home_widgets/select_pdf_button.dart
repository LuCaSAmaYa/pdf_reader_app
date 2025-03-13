import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_strings.dart';
import '../../utils/theme_data.dart';

class SelectPdfButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const SelectPdfButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    bool isDark = themeState.isDarkTheme;
    return ElevatedButton.icon(
      onPressed: onPressed,
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
        backgroundColor: subThemes[themeState.selectedSubTheme],
        shadowColor: Colors.black45,
        elevation: 10,
      ),
    );
  }
}
