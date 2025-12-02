import 'package:flutter/material.dart';

/// Molécula: Barra de paginación
class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final VoidCallback onFirstPage;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final VoidCallback onLastPage;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.onFirstPage,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onLastPage,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: hasPreviousPage ? onFirstPage : null,
            tooltip: 'Primera página',
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: hasPreviousPage ? onPreviousPage : null,
            tooltip: 'Página anterior',
          ),
          const SizedBox(width: 8),
          Text(
            'Página ${currentPage + 1} de $totalPages',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: hasNextPage ? onNextPage : null,
            tooltip: 'Página siguiente',
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: hasNextPage ? onLastPage : null,
            tooltip: 'Última página',
          ),
        ],
      ),
    );
  }
}
