import 'package:flutter/material.dart';

/// Molécula: Barra de búsqueda con filtros
class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String? directorFilter;
  final String sortBy;
  final List<String> availableDirectors;
  final Function(String) onSearchChanged;
  final Function(String?) onDirectorChanged;
  final Function(String?) onSortChanged;
  final VoidCallback onClearFilters;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.directorFilter,
    required this.sortBy,
    required this.availableDirectors,
    required this.onSearchChanged,
    required this.onDirectorChanged,
    required this.onSortChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Campo de búsqueda
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Buscar películas...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    )
                  : null,
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 12),
          
          // Filtros y ordenamiento
          Row(
            children: [
              // Filtro por director
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Director',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: directorFilter?.isEmpty ?? true ? null : directorFilter,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Todos los directores'),
                    ),
                    ...availableDirectors.map((director) {
                      return DropdownMenuItem(
                        value: director,
                        child: Text(
                          director,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                  onChanged: onDirectorChanged,
                ),
              ),
              const SizedBox(width: 12),
              
              // Ordenamiento
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Ordenar por',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: sortBy,
                  items: const [
                    DropdownMenuItem(
                      value: 'title',
                      child: Text('Título'),
                    ),
                    DropdownMenuItem(
                      value: 'release_date',
                      child: Text('Año'),
                    ),
                    DropdownMenuItem(
                      value: 'rt_score',
                      child: Text('Puntuación'),
                    ),
                  ],
                  onChanged: onSortChanged,
                ),
              ),
              const SizedBox(width: 12),
              
              // Botón limpiar filtros
              IconButton(
                icon: const Icon(Icons.filter_list_off),
                tooltip: 'Limpiar filtros',
                onPressed: onClearFilters,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
