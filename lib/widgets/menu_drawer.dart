import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';
import '../screens/more_info_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_data.dart';
import 'settings_widgets/drawer_item.dart'; //Se importa el nuevo widget.
//import 'app_button.dart';//Se importa app button.

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

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
                  color: themeState.isDarkTheme ? Colors.white : Colors.black, //Se modifica el color del texto.
                  fontSize: 24,
                ),
              ),
            ),
          ),
          //Se usa el nuevo widget.
          const DrawerItem(icon: Icons.settings, text: 'settings', screen: SettingsScreen()),
          //Se usa el nuevo widget.
          const DrawerItem(icon: Icons.info, text: 'about', screen: AboutScreen()),
          //Se usa el nuevo widget.
          const DrawerItem(icon: Icons.more, text: 'more_info', screen: MoreInfoScreen()),
        ],
      ),
    );
  }
}
