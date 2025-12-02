import 'package:flutter/material.dart';

/// Átomo genérico para mostrar información con icono
/// Puede usarse para producto, pedido, cliente, etc.
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final EdgeInsetsGeometry? padding;

  const InfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.labelStyle,
    this.valueStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: labelStyle ??
                      Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                ),
                Text(
                  value,
                  style: valueStyle ??
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
