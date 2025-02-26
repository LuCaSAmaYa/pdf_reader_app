import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pdf_history_provider.dart';
import 'pdf_viewer.dart';
import '../models/pdf_document.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(pdfHistoryProvider);
    final abiertos = history.where((pdf) => pdf.status == 'abierto').toList();
    final guardados = history.where((pdf) => pdf.status == 'guardado').toList();

    print('Abiertos: ${abiertos.map((pdf) => pdf.path).toList()}'); // Agregado para depuración
    print('Guardados: ${guardados.map((pdf) => pdf.path).toList()}'); // Agregado para depuración

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Abiertos'),
            Tab(text: 'Guardados'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPdfList(abiertos),
          _buildPdfList(guardados),
        ],
      ),
    );
  }

  Widget _buildPdfList(List<PdfDocument> pdfList) {
    print('history_screen: Reconstruyendo lista con ${pdfList.length} elementos'); // Registro

    return ListView.builder(
      itemCount: pdfList.length,
      itemBuilder: (context, index) {
        final pdf = pdfList[index];
        return ListTile(
          title: Text(pdf.name, style: const TextStyle(fontSize: 18)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estado: ${pdf.status}',
                  style: const TextStyle(fontSize: 16)),
              Text('Ruta: ${pdf.path}', style: const TextStyle(fontSize: 16)),
              if (pdf.originalPath.isNotEmpty)
                Text('Original: ${pdf.originalPath}',
                    style: const TextStyle(fontSize: 16)),
              Text(DateFormat('yyyy-MM-dd HH:mm').format(pdf.date),
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfViewerPage(pdfDocument: pdf)),
              );
            },
          ),
        );
      },
    );
  }
}