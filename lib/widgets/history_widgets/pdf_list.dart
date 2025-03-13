import 'package:flutter/material.dart';
import '../../models/pdf_document.dart';
import 'pdf_item.dart';

class PdfList extends StatelessWidget {
  final List<PdfDocument> pdfList;
  const PdfList({super.key, required this.pdfList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pdfList.length,
      itemBuilder: (context, index) {
        final pdf = pdfList[index];
        return PdfItem(pdf: pdf);
      },
    );
  }
}
