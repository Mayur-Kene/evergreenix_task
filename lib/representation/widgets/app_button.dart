import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import '../themes/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool enable;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12), // ✅ outer padding
      child: ElevatedButton(
        onPressed: enable ? onPressed : null,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(
            const Size(double.maxFinite, 54),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return lightGrey;
            }
            return lightBlue;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        child: Text(
          title,
          style: AppTheme.textStyle(
            color: Colors.white,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
