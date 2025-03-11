import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_strings.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    bool isDark = themeState.isDarkTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          _buildThemeButton(
            context,
            ref,
            isDark,
            false,
            Icons.wb_sunny,
            appStrings.getString('light'),
            screenWidth * 0.80,
          ),
          const SizedBox(height: 10),
          _buildThemeButton(
            context,
            ref,
            isDark,
            true,
            Icons.nights_stay,
            appStrings.getString('dark'),
            screenWidth * 0.80,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton(
      BuildContext context, WidgetRef ref, bool isDark, bool darkMode, IconData icon,
      String text, double width) {
    bool isSelected = (isDark == darkMode);
    return GestureDetector(
      onTap: () => ref.read(themeProvider.notifier).toggleTheme(darkMode), // <-- Verifica esta línea
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? (darkMode ? Colors.black : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey,
            width: isSelected ? 3 : 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isDark ? Colors.white : Colors.black, size: 28),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}