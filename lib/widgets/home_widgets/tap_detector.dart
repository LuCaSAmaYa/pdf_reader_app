import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme_data.dart';
import '../../providers/theme_provider.dart';

class TapDetector extends ConsumerWidget {
  final VoidCallback onTap;
  const TapDetector({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return Align(
      alignment: Alignment.bottomLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(bottom: 20, left: 20),
              decoration: BoxDecoration(
                color: subThemes[themeState.selectedSubTheme],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
