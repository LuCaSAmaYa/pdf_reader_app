import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/pdf_document.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_strings.dart';
import '../../widgets/app_button.dart';
import '../../screens/pdf_viewer_page.dart';

class PdfItem extends ConsumerWidget {
  final PdfDocument pdf;
  const PdfItem({super.key, required this.pdf});

  void _showFileInfo(BuildContext context, AppStrings appStrings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appStrings.getString('file_information')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${appStrings.getString('path')} ${pdf.path}'),
              if (pdf.originalPath.isNotEmpty)
                Text('${appStrings.getString('original')} ${pdf.originalPath}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(appStrings.getString('close')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(DateFormat('yyyy-MM-dd HH:mm').format(pdf.date)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(pdf.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              flex: 1,
              child: AppButton(
                icon: Icons.open_in_new,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PdfViewerPage(pdfDocument: pdf)),
                  );
                },
                useSubThemeColor: false,
                iconSize: 30,
              ),
            ),
            Expanded(
              flex: 2,
              child: AppButton(
                icon: Icons.info_outline,
                onPressed: () => _showFileInfo(context, appStrings),
                useSubThemeColor: false,
                iconSize: 30,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
