import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';
import '../atoms/info_item.dart';

/// Molecule genérica para mostrar información de una entidad
/// Útil para Productos, Pedidos, Clientes, etc.
class InfoSection extends StatelessWidget {
  final String title;
  final List<InfoItemData> items;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;

  const InfoSection({
    super.key,
    required this.title,
    required this.items,
    this.padding,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.txtSecundario,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InfoItem(
                  icon: entry.value.icon,
                  label: entry.value.label,
                  value: entry.value.value,
                  iconColor: entry.value.iconColor,
                  padding: EdgeInsets.zero,
                ),
              ),
              if (!isLast && showDivider)
                Divider(
                  height: 1,
                  color: AppColors.borde.withOpacity(0.3),
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ],
    );
  }
}

class InfoItemData {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  InfoItemData({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });
}
