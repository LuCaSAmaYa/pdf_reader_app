import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/theme_widgets/color_selector.dart';
import '../../utils/app_strings.dart';
import '../../providers/theme_provider.dart';

class ColorSection extends ConsumerWidget {
  const ColorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final themeState = ref.watch(themeProvider);
        final appStrings = AppStrings(themeState.locale);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appStrings.getString('color_selection'),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: themeState.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        const ColorSelector(),
      ],
    );
  }
}
