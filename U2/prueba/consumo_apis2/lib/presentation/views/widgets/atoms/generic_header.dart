import 'package:flutter/material.dart';

/// Átomo genérico para mostrar encabezados con acciones
/// Puede usarse para producto, pedido, cliente, etc.
class GenericHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<HeaderAction> actions;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const GenericHeader({
    super.key,
    required this.title,
    this.subtitle,
    required this.actions,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: subtitleStyle ??
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                    ),
                  ],
                ],
              ),
            ),
            ...actions.map((action) => IconButton(
              icon: Icon(action.icon, size: 20),
              onPressed: action.onPressed,
              tooltip: action.tooltip,
              color: action.color,
            )),
          ],
        ),
      ],
    );
  }
}

class HeaderAction {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final Color color;

  HeaderAction({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.color = const Color(0xFF6366F1),  // Primary color por defecto
  });
}
