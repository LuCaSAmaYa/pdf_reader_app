import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_strings.dart';
import '../../providers/theme_provider.dart';
import '../app_button.dart';//Se modifica el import.
import 'pdf_file_name_text_field.dart';

//Widget para el alert dialog completo.
class PdfSaveDialog extends ConsumerWidget {
  final TextEditingController fileNameController;
  final VoidCallback onSavePressed;
  final VoidCallback onCancelPressed;

  const PdfSaveDialog({
    super.key,
    required this.fileNameController,
    required this.onSavePressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return AlertDialog(
      backgroundColor: themeState.isDarkTheme ? themeState.darkBackgroundColor : Colors.white,
      title: Text(
        appStrings.getString('save_pdf'),
        style: TextStyle(color: themeState.isDarkTheme ? Colors.white : Colors.black),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: PdfFileNameTextField(fileNameController: fileNameController),
      ),
      actions: <Widget>[
          //Se utiliza el nuevo widget.
          AppButton(
            onPressed: onCancelPressed,
            icon: Icons.cancel,
            text: 'cancel',
            useSubThemeColor: true,
          ),
            AppButton(
            onPressed: onSavePressed,
            icon: Icons.save,
            text: 'save',
            useSubThemeColor: true,
          ),
      ],
    );
  }
}
