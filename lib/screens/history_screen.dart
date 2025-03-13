import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pdf_history_provider.dart';
//import '../models/pdf_document.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../widgets/history_widgets/pdf_list.dart';
import '../widgets/history_widgets/tab_section.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends ConsumerState<HistoryScreen> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(pdfHistoryProvider);
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);
    final abiertos = history.where((pdf) => pdf.status == 'abierto').toList();
    abiertos.sort((a, b) => b.date.compareTo(a.date)); //Se ordena la lista.
    //final abiertosReversed = abiertos.reversed.toList();//Se elimina la linea.
    final guardados = history.where((pdf) => pdf.status == 'guardado').toList();
    guardados.sort((a, b) => b.date.compareTo(a.date)); //Se ordena la lista.
    //final guardadosReversed = guardados.reversed.toList();//Se elimina la linea.

    return Scaffold(
      appBar: AppBar(
        title: Text(appStrings.getString('history')),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabSection(
                    selectedTabIndex: _selectedTabIndex,
                    onTap: _onTabSelected,
                    appStrings: appStrings,
                    tabIndex: 0,
                  ),
                  TabSection(
                    selectedTabIndex: _selectedTabIndex,
                    onTap: _onTabSelected,
                    appStrings: appStrings,
                    tabIndex: 1,
                  ),
                ],
              ),
              const Divider(height: 1.0, thickness: 1.0),
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
                PdfList(pdfList: abiertos), //Se modifica la lista.
                PdfList(pdfList: guardados), //Se modifica la lista.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
