import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';

enum ButtonType { primary, secondary, text }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final bool expanded;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget button;

    switch (type) {
      case ButtonType.primary:
        button = ElevatedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isLoading ? Colors.white : AppColors.txtClaro,
                    ),
                  ),
                )
              : Icon(icon ?? Icons.check),
          label: Text(label),
        );
        break;
      case ButtonType.secondary:
        button = OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: Icon(icon ?? Icons.close),
          label: Text(label),
        );
        break;
      case ButtonType.text:
        button = TextButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: Icon(icon ?? Icons.info),
          label: Text(label),
        );
        break;
    }

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
