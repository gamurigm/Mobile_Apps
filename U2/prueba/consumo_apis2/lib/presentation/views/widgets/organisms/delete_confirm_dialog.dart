import 'package:flutter/material.dart';
import 'package:modern_theme/modern_theme.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String itemName;
  final String itemType;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteConfirmDialog({
    super.key,
    required this.itemName,
    this.itemType = 'elemento',
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
      title: Text('¿Eliminar $itemType?'),
      content: Text(
        '¿Estás seguro de que deseas eliminar "$itemName"? Esta acción no se puede deshacer.',
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
