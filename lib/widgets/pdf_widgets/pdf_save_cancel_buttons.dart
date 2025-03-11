import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_strings.dart';
import '../../utils/theme_data.dart';
import '../../providers/theme_provider.dart';

//Widget para los botones del alert dialog
class PdfSaveCancelButtons extends ConsumerWidget {
  final VoidCallback onCancelPressed;
  final VoidCallback onSavePressed;

  const PdfSaveCancelButtons({
    super.key,
    required this.onCancelPressed,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Alinea los botones a la derecha
      children: [
        TextButton.icon(
          icon: const Icon(Icons.cancel, size: 30),
          label: Text(
            appStrings.getString('cancel'),
            style: TextStyle(fontSize: 20, color: subThemes[themeState.selectedSubTheme]),
          ),
          onPressed: onCancelPressed,
        ),
        TextButton.icon(
          icon: const Icon(Icons.save, size: 30),
          label: Text(
            appStrings.getString('save'),
            style: TextStyle(fontSize: 20, color: subThemes[themeState.selectedSubTheme]),
          ),
          onPressed: onSavePressed,
        ),
      ],
    );
  }
}
