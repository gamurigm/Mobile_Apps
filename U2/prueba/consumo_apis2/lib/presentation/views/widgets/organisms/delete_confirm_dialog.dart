import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String productName;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteConfirmDialog({
    super.key,
    required this.productName,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: AppColors.advertencia,
        size: 48,
      ),
      title: const Text('¿Eliminar producto?'),
      content: Text(
        '¿Estás seguro de que deseas eliminar "$productName"? Esta acción no se puede deshacer.',
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
          ),
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}
