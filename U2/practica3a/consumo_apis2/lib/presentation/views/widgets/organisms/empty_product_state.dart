import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';

class EmptyProductState extends StatelessWidget {
  const EmptyProductState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: AppColors.txtTerciario,
          ),
          const SizedBox(height: 16),
          Text(
            'No hay productos',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.txtPrincipal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tu primer producto',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.txtSecundario,
            ),
          ),
        ],
      ),
    );
  }
}
