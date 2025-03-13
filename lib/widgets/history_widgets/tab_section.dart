import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; //Se añade el import.
import '../../utils/app_strings.dart';
import '../../utils/theme_data.dart';
import '../../providers/theme_provider.dart'; //Se añade el import.

class TabSection extends ConsumerWidget { //Se cambia el widget.
  final int selectedTabIndex;
  final Function(int) onTap;
  final AppStrings appStrings;
  final int tabIndex;
  const TabSection(
      {super.key,
      required this.selectedTabIndex,
      required this.onTap,
      required this.appStrings,
      required this.tabIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) { //Se añade el parametro.
    final themeState = ref.watch(themeProvider); //Se crea la variable.
    return GestureDetector(
      onTap: () => onTap(tabIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tabIndex == 0 ? appStrings.getString('open') : appStrings.getString('saved'),
              style: TextStyle(
                  fontSize: selectedTabIndex == tabIndex ? 24 : 18,
                  fontWeight: FontWeight.bold),
            ),
            if (selectedTabIndex == tabIndex)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.check,
                    color: subThemes[themeState.selectedSubTheme]!, size: 24.0), //Se cambia la variable.
              ),
          ],
        ),
      ),
    );
  }
}
