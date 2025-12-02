import 'package:flutter/material.dart';

import '../atoms/atoms.dart';

/// Molecule genérica para headers con acciones
/// Puede usarse en Productos, Pedidos, Clientes, etc.
class CardHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<HeaderAction> actions;

  const CardHeader({
    super.key,
    required this.title,
    this.subtitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return GenericHeader(
      title: title,
      subtitle: subtitle,
      actions: actions,
    );
  }
}
