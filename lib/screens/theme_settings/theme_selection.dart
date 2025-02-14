import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';

class ThemeSelection extends ConsumerWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    bool isDark = themeState.isDarkTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          'Temas:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            _buildThemeButton(context, ref, isDark, false, Icons.wb_sunny, 'Claro', screenWidth * 0.80),
            const SizedBox(height: 10),
            _buildThemeButton(context, ref, isDark, true, Icons.nights_stay, 'Oscuro', screenWidth * 0.80),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeButton(BuildContext context, WidgetRef ref, bool isDark, bool darkMode, IconData icon, String text, double width) {
    bool isSelected = (isDark == darkMode);
    return GestureDetector(
      onTap: () => ref.read(themeProvider.notifier).toggleTheme(darkMode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? (darkMode ? Colors.black : Colors.white) : Colors.transparent,
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
