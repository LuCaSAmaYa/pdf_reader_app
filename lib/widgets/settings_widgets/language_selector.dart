import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  value: 'es',
                  groupValue: themeState.locale,
                  onChanged: (String? value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setLocale(value);
                    }
                  },
                ),
              ),
              Text(
                'es',
                style: TextStyle(
                  color: themeState.dropdownTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  value: 'en',
                  groupValue: themeState.locale,
                  onChanged: (String? value) {
                    if (value != null) {
                      ref.read(themeProvider.notifier).setLocale(value);
                    }
                  },
                ),
              ),
              Text(
                'en',
                style: TextStyle(
                  color: themeState.dropdownTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
