import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';

enum BadgeType { success, warning, error, info }

class CustomBadge extends StatelessWidget {
  final String label;
  final BadgeType type;
  final IconData? icon;

  const CustomBadge({
    super.key,
    required this.label,
    this.type = BadgeType.info,
    this.icon,
  });

  Color get _backgroundColor {
    switch (type) {
      case BadgeType.success:
        return AppColors.exito;
      case BadgeType.warning:
        return AppColors.advertencia;
      case BadgeType.error:
        return AppColors.error;
      case BadgeType.info:
        return AppColors.informacion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.txtClaro),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: AppColors.txtClaro,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
