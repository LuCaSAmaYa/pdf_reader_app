import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../utils/theme_data.dart'; // Importa 'theme_data.dart'
import '../../utils/app_strings.dart';

class ColorSelector extends ConsumerWidget {
  const ColorSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 70),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 50,
        childAspectRatio: 1.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subThemes.length,
      itemBuilder: (BuildContext context, int index) {
        final entry = subThemes.entries.elementAt(index);
        bool isSelected = themeState.selectedSubTheme == entry.key;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                ref.read(themeProvider.notifier).changeSubTheme(entry.key);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${appStrings.getString('color_selection')}: ${appStrings.getColorName(entry.key)}'), // Usamos getColorName
                  ),
                );
              },
              child: Container(
                width: 130,
                height: 90,
                decoration: BoxDecoration(
                  color: entry.value,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.redAccent : Colors.transparent,
                    width: isSelected ? 3 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(0x33),
                      spreadRadius: 2,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    _getIconForColor(entry.key),
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              appStrings.getColorName(entry.key), // Usamos getColorName
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: themeState.isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForColor(String colorName) {
    switch (colorName) {
      case 'Green':
        return Icons.eco;
      case 'Orange':
        return Icons.local_fire_department;
      case 'Teal':
        return Icons.waves;
      case 'Pink':
        return Icons.local_florist;
      case 'Purple':
        return Icons.spa;
      case 'Red':
        return Icons.favorite;
      case 'Gray':
        return Icons.cloud;
      case 'Cyan':
        return Icons.pool;
      case 'Indigo':
        return Icons.remove_red_eye;
      case 'Emerald Green':
        return Icons.park;
      case 'Serenity Blue':
        return Icons.air;
      case 'Brown':
        return Icons.color_lens;
      case 'Coral Orange':
        return Icons.brightness_5;
      case 'Royal Blue':
        return Icons.water_drop;
      default:
        return Icons.circle;
    }
  }
}