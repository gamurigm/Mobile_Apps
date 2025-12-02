import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';
import '../atoms/atoms.dart';

class ProductFormDialog extends StatefulWidget {
  final String title;
  final String? initialName;
  final double? initialPrice;
  final int? initialStock;
  final String? initialCategory;
  final VoidCallback onCancel;
  final Function(String nombre, double precio, int stock, String categoria) onSave;

  const ProductFormDialog({
    super.key,
    required this.title,
    this.initialName,
    this.initialPrice,
    this.initialStock,
    this.initialCategory,
    required this.onCancel,
    required this.onSave,
  });

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  late TextEditingController nombreController;
  late TextEditingController precioController;
  late TextEditingController stockController;
  late TextEditingController categoriaController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.initialName ?? '');
    precioController = TextEditingController(
      text: widget.initialPrice?.toString() ?? '',
    );
    stockController = TextEditingController(
      text: widget.initialStock?.toString() ?? '',
    );
    categoriaController = TextEditingController(
      text: widget.initialCategory ?? '',
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    precioController.dispose();
    stockController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        widget.initialName == null
            ? Icons.add_circle_outline
            : Icons.edit_outlined,
        color: AppColors.primario,
        size: 48,
      ),
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: nombreController,
              labelText: "Nombre del producto",
              hintText: "Ej: Laptop HP",
              prefixIcon: Icons.shopping_bag_outlined,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: precioController,
              labelText: "Precio",
              hintText: "0.00",
              prefixIcon: Icons.attach_money,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: stockController,
              labelText: "Stock",
              hintText: "0",
              prefixIcon: Icons.inventory_2_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: categoriaController,
              labelText: "Categoría",
              hintText: "Ej: Electrónica",
              prefixIcon: Icons.category_outlined,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _handleSave,
          child: const Text("Guardar"),
        ),
      ],
    );
  }

  void _handleSave() {
    final nombre = nombreController.text.trim();
    final precio = double.tryParse(precioController.text) ?? 0.0;
    final stock = int.tryParse(stockController.text) ?? 0;
    final categoria = categoriaController.text.trim();

    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El nombre es obligatorio'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    widget.onSave(nombre, precio, stock, categoria);
  }
}
