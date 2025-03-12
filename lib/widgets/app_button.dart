import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../utils/theme_data.dart';

class AppButton extends ConsumerWidget {
  final IconData icon;
  final String? text;
  final VoidCallback onPressed;
  final bool useSubThemeColor;
  final double? iconSize;

  const AppButton({
    super.key,
    required this.icon,
    this.text,
    required this.onPressed,
    this.useSubThemeColor = false,
    this.iconSize = 30, //Se le da un valor por defecto.
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    final subThemeColor = subThemes.containsKey(themeState.selectedSubTheme)
        ? subThemes[themeState.selectedSubTheme]
        : Colors.green;

    //Se crea la funcion que va a crear el boton.
    Widget buildButton() {
      // Dependiendo de si se usa o no el subtema, se asignara un color u otro.
      final iconColor = useSubThemeColor
          ? subThemeColor
          : themeState.isDarkTheme
              ? Colors.white
              : Colors.black;

      return text != null
          ? TextButton.icon(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
              label: Text(
                appStrings.getString(text!),
                style: TextStyle(fontSize: 20, color: subThemeColor),
              ),
            )
          : IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            );
    }

    return buildButton();
  }
}
