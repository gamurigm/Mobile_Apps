import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';

/// Átomo genérico para mostrar un estado/badge dinámico
/// Usado para estados (activo, pendiente, cancelado), prioridades, etc.
enum StatusType { success, warning, error, info, neutral }

class StatusBadge extends StatelessWidget {
  final String label;
  final StatusType type;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const StatusBadge({
    super.key,
    required this.label,
    this.type = StatusType.info,
    this.icon,
    this.padding,
    this.textStyle,
  });

  Color get _backgroundColor {
    switch (type) {
      case StatusType.success:
        return AppColors.exito;
      case StatusType.warning:
        return AppColors.advertencia;
      case StatusType.error:
        return AppColors.error;
      case StatusType.info:
        return AppColors.informacion;
      case StatusType.neutral:
        return AppColors.txtTerciario;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.txtClaro),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: textStyle ??
                const TextStyle(
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
