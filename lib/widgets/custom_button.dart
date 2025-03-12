import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../utils/theme_data.dart';

class CustomButton extends ConsumerWidget {
  final IconData? icon;
  final String? text;
  final VoidCallback onPressed;
  final bool showCancelButton;
  final bool showText; //Se crea el nuevo parametro.

  const CustomButton({
    super.key,
    this.icon,
    this.text,
    required this.onPressed,
    this.showCancelButton = false,
    this.showText = true, //Se le da un valor por defecto.
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    //Se crea la variable para comprobar si el subtema es null o no.
    final subThemeColor = subThemes.containsKey(themeState.selectedSubTheme)
        ? subThemes[themeState.selectedSubTheme]
        : Colors.green;
    //Se crea una funcion para mostrar los botones de cancelar y guardar.
    Widget buildButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showCancelButton)
            TextButton.icon(
              icon: const Icon(Icons.cancel, size: 30),
              label: Text(
                appStrings.getString('cancel'),
                style: TextStyle(fontSize: 20, color: subThemeColor),
              ),
              onPressed: onPressed,
            ),
          TextButton.icon(
            icon: Icon(icon ?? Icons.save, size: 30),
            //Se muestra el text dependiendo de si se quiere o no.
            label: Text(
              appStrings.getString(text ?? 'save'), // Se le da el valor por defecto.
              style: TextStyle(fontSize: 20, color: subThemeColor),
            ),
            onPressed: onPressed,
          ),
        ],
      );
    }

    //Se crea una funcion para mostrar solo el icono.
    Widget buildIconButton() {
      return IconButton(
        icon: Icon(icon ?? Icons.save, size: 30, color: subThemeColor),
        onPressed: onPressed,
      );
    }

    //Se comprueba si se deben mostrar los botones o el icono.
    return showCancelButton ? buildButtons() : buildIconButton();
  }
}
