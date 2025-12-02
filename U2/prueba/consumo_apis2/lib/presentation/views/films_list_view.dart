import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/film_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FilmsListView extends StatefulWidget {
  const FilmsListView({super.key});

  @override
  State<FilmsListView> createState() => _FilmsListViewState();
}

class _FilmsListViewState extends State<FilmsListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilmViewModel>().loadFilms();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studio Ghibli Films'),
        elevation: 2,
      ),
      body: Consumer<FilmViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.allFilms.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${viewModel.errorMessage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.loadFilms(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Barra de búsqueda y filtros
              _buildSearchAndFilters(context, viewModel),
              
              // Grid de películas
              Expanded(
                child: viewModel.paginatedFilms.isEmpty
                    ? const Center(
                        child: Text(
                          'No se encontraron películas',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(context),
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: viewModel.paginatedFilms.length,
                        itemBuilder: (context, index) {
                          final film = viewModel.paginatedFilms[index];
                          return _buildFilmCard(context, film);
                        },
                      ),
              ),
              
              // Paginación
              _buildPagination(context, viewModel),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context, FilmViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Campo de búsqueda
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar películas...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        viewModel.setSearchQuery('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
            ),
            onChanged: (value) => viewModel.setSearchQuery(value),
          ),
          const SizedBox(height: 12),
          
          // Filtros y ordenamiento
          Row(
            children: [
              // Filtro por director
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Director',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: viewModel.directorFilter.isEmpty
                      ? null
                      : viewModel.directorFilter,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Todos los directores'),
                    ),
                    ...viewModel.availableDirectors.map((director) {
                      return DropdownMenuItem(
                        value: director,
                        child: Text(
                          director,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    viewModel.setDirectorFilter(value ?? '');
                  },
                ),
              ),
              const SizedBox(width: 12),
              
              // Ordenamiento
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Ordenar por',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: viewModel.sortBy,
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
                  onChanged: (value) {
                    if (value != null) {
                      viewModel.setSortBy(value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              
              // Botón limpiar filtros
              IconButton(
                icon: const Icon(Icons.filter_list_off),
                tooltip: 'Limpiar filtros',
                onPressed: () {
                  _searchController.clear();
                  viewModel.clearFilters();
                },
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilmCard(BuildContext context, film) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/film-detail',
          arguments: film.id,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: film.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.movie,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            
            // Información
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      film.director,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                film.rtScore,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          film.releaseDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, FilmViewModel viewModel) {
    if (viewModel.totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            onPressed: viewModel.hasPreviousPage
                ? () => viewModel.goToPage(0)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: viewModel.hasPreviousPage
                ? () => viewModel.previousPage()
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            'Página ${viewModel.currentPage + 1} de ${viewModel.totalPages}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: viewModel.hasNextPage
                ? () => viewModel.nextPage()
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: viewModel.hasNextPage
                ? () => viewModel.goToPage(viewModel.totalPages - 1)
                : null,
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 2;
  }
}
