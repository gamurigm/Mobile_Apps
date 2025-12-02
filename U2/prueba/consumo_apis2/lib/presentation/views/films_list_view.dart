import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/film_viewmodel.dart';
import 'widgets/atoms/film_grid_card.dart';
import 'widgets/molecules/search_filter_bar.dart';
import 'widgets/molecules/pagination_bar.dart';
import 'widgets/organisms/film_detail_modal.dart';

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
              // Barra de búsqueda y filtros - Usando widget molecule
              SearchFilterBar(
                searchController: _searchController,
                directorFilter: viewModel.directorFilter,
                sortBy: viewModel.sortBy,
                availableDirectors: viewModel.availableDirectors,
                onSearchChanged: (value) => viewModel.setSearchQuery(value),
                onDirectorChanged: (value) => viewModel.setDirectorFilter(value ?? ''),
                onSortChanged: (value) {
                  if (value != null) viewModel.setSortBy(value);
                },
                onClearFilters: () {
                  _searchController.clear();
                  viewModel.clearFilters();
                },
              ),
              
              // Grid de películas - Usando widget atom FilmGridCard
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
                          return FilmGridCard(
                            film: film,
                            onTap: () {
                              // Mostrar modal con detalle de película
                              FilmDetailModal.show(context, film);
                            },
                          );
                        },
                      ),
              ),
              
              // Paginación - Usando widget molecule
              PaginationBar(
                currentPage: viewModel.currentPage,
                totalPages: viewModel.totalPages,
                hasPreviousPage: viewModel.hasPreviousPage,
                hasNextPage: viewModel.hasNextPage,
                onFirstPage: () => viewModel.goToPage(0),
                onPreviousPage: () => viewModel.previousPage(),
                onNextPage: () => viewModel.nextPage(),
                onLastPage: () => viewModel.goToPage(viewModel.totalPages - 1),
              ),
            ],
          );
        },
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
