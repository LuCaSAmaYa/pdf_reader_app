import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../utils/theme_data.dart';

class ColorSelection extends ConsumerWidget {
  const ColorSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    bool isDark = themeState.isDarkTheme;

    return GridView.count(
      padding: const EdgeInsets.only(top: 10, bottom: 70),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 50,
      childAspectRatio: 1.0,
      physics: const NeverScrollableScrollPhysics(),
      children: subThemes.entries.map((entry) {
        bool isSelected = themeState.selectedSubTheme == entry.key;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                ref.read(themeProvider.notifier).changeSubTheme(entry.key);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Color seleccionado: ${entry.key}')),
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
                      color: Colors.black.withOpacity(0.2),
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
              entry.key,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  IconData _getIconForColor(String colorName) {
    switch (colorName) {
      case 'Verde':
        return Icons.eco;
      case 'Naranja':
        return Icons.local_fire_department;
      case 'Azul Pavo':
        return Icons.waves;
      case 'Rosado':
        return Icons.local_florist;
      case 'Morado':
        return Icons.spa;
      case 'Rojo':
        return Icons.favorite;
      case 'Gris':
        return Icons.cloud;
      case 'Cyan':
        return Icons.pool;
      case 'Indigo':
        return Icons.remove_red_eye;
      case 'Verde Esmeralda':
        return Icons.park;
      case 'Azul Serenity':
        return Icons.air;
      case 'Palo Rosa':
        return Icons.color_lens;
      case 'Naranja Coral':
        return Icons.brightness_5;
      case 'Azul Real':
        return Icons.water_drop;
      default:
        return Icons.circle;
    }
  }
}