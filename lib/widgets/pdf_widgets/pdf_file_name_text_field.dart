import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_strings.dart';
import '../../providers/theme_provider.dart';

//Widget para el TextField del nombre del archivo.
class PdfFileNameTextField extends ConsumerWidget {
  final TextEditingController fileNameController;

  const PdfFileNameTextField({super.key, required this.fileNameController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return TextField(
      controller: fileNameController,
      decoration: InputDecoration(
        labelText: appStrings.getString('file_name'),
        labelStyle: TextStyle(
          color: themeState.isDarkTheme ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
      style: TextStyle(color: themeState.isDarkTheme ? Colors.white : Colors.black),
      maxLines: 3,
    );
  }
}
