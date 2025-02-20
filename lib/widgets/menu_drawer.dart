import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';
import '../screens/more_info_screen.dart';
import '../utils/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_data.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return Drawer(
      backgroundColor: themeState.isDarkTheme ? Colors.black : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: subThemes[themeState.selectedSubTheme] ?? Theme.of(context).primaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 30, color: themeState.isDarkTheme ? Colors.white : Colors.black), // Iconos más grandes
            title: Text(
              appStrings.getString('settings'),
              style: TextStyle(fontSize: 20, color: themeState.isDarkTheme ? Colors.white : Colors.black), // Texto más grande
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, size: 30, color: themeState.isDarkTheme ? Colors.white : Colors.black), // Iconos más grandes
            title: Text(
              appStrings.getString('about'),
              style: TextStyle(fontSize: 20, color: themeState.isDarkTheme ? Colors.white : Colors.black), // Texto más grande
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.more, size: 30, color: themeState.isDarkTheme ? Colors.white : Colors.black), // Iconos más grandes
            title: Text(
              appStrings.getString('more_info'),
              style: TextStyle(fontSize: 20, color: themeState.isDarkTheme ? Colors.white : Colors.black), // Texto más grande
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoreInfoScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}