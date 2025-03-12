import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_strings.dart';

class DrawerItem extends ConsumerWidget {
  final IconData icon;
  final String text;
  final Widget screen;
  const DrawerItem({super.key, required this.icon, required this.text, required this.screen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       final themeState = ref.watch(themeProvider);
       final appStrings = AppStrings(themeState.locale);
    return ListTile(
      leading: Icon(icon, size: 30, color: themeState.isDarkTheme ? Colors.white : Colors.black),
      title: Text(
        appStrings.getString(text),
        style: TextStyle(fontSize: 20, color: themeState.isDarkTheme ? Colors.white : Colors.black),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
