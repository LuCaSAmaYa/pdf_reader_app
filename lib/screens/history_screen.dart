import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pdf_history_provider.dart';
import 'pdf_viewer_page.dart';
import '../models/pdf_document.dart';
import 'package:intl/intl.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_data.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(pdfHistoryProvider);
    final themeState = ref.watch(themeProvider);
    final abiertos = history.where((pdf) => pdf.status == 'abierto').toList().reversed.toList();
    final guardados = history.where((pdf) => pdf.status == 'guardado').toList().reversed.toList();

    print('Abiertos: ${abiertos.map((pdf) => pdf.path).toList()}');
    print('Guardados: ${guardados.map((pdf) => pdf.path).toList()}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // Ajustar la altura
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Abiertos',
                            style: TextStyle(
                              fontSize: _selectedTabIndex == 0 ? 20 : 12, // Tamaños de fuente ajustados
                            ),
                          ),
                          if (_selectedTabIndex == 0)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0), // Espacio aumentado
                              child: Icon(Icons.check,
                                  color: subThemes[themeState.selectedSubTheme]!,
                                  size: 24.0), // Icono más grande
                            ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Guardados',
                            style: TextStyle(
                              fontSize: _selectedTabIndex == 1 ? 20 : 12, // Tamaños de fuente ajustados
                            ),
                          ),
                          if (_selectedTabIndex == 1)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0), // Espacio aumentado
                              child: Icon(Icons.check,
                                  color: subThemes[themeState.selectedSubTheme]!,
                                  size: 24.0), // Icono más grande
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 1.0, thickness: 1.0), // Línea divisoria debajo de los títulos
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(height: 16),
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _buildPdfList(abiertos),
                _buildPdfList(guardados),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfList(List<PdfDocument> pdfList) {
    print('history_screen: Reconstruyendo lista con ${pdfList.length} elementos');

    return ListView.builder(
      itemCount: pdfList.length,
      itemBuilder: (context, index) {
        final pdf = pdfList[index];
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
                    child: Text(pdf.name, style: const TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfViewerPage(pdfDocument: pdf)),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ExpansionTile(
                    title: const Icon(Icons.folder),
                    children: [
                      ListTile(
                        title: Text('Ruta: ${pdf.path}', style: const TextStyle(fontSize: 16)),
                      ),
                      if (pdf.originalPath.isNotEmpty)
                        ListTile(
                          title: Text('Original: ${pdf.originalPath}',
                              style: const TextStyle(fontSize: 16)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        );
      },
    );
  }
}