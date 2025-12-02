import 'package:flutter/material.dart';
import '../molecules/molecules.dart';
import '../atoms/atoms.dart';
import '../../../../../domain/entities/producto_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductoEntity product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 2,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.5), width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con nombre y acciones
              CardHeader(
                title: product.nombre,
                actions: [
                  HeaderAction(
                    icon: Icons.edit_outlined,
                    onPressed: onEdit,
                    tooltip: 'Editar',
                    color: colorScheme.primary,
                  ),
                  HeaderAction(
                    icon: Icons.delete_outline,
                    onPressed: onDelete,
                    tooltip: 'Eliminar',
                    color: colorScheme.error,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Precio destacado
              HighlightCard(
                title: 'Precio',
                value: '\$${product.precio.toStringAsFixed(2)}',
                icon: Icons.attach_money,
                primaryColor: colorScheme.primary,
                secondaryColor: colorScheme.primaryContainer,
              ),
              const SizedBox(height: 12),

              // Información adicional
              Row(
                children: [
                  if (product.categoria.isNotEmpty)
                    Expanded(
                      child: InfoItem(
                        icon: Icons.category_outlined,
                        label: 'Categoría',
                        value: product.categoria,
                      ),
                    ),
                  if (product.categoria.isNotEmpty) const SizedBox(width: 16),
                  Expanded(
                    child: _buildStockIndicator(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockIndicator() {
    final stockColor = product.stock > 10
        ? const Color(0xFF10B981)  // Verde esmeralda
        : product.stock > 0
            ? const Color(0xFFF97316)  // Naranja cálido
            : const Color(0xFFEF4444);  // Rojo coral

    return InfoItem(
      icon: Icons.inventory_2_outlined,
      label: 'Stock',
      value: product.stock.toString(),
      iconColor: stockColor,
    );
  }
}
