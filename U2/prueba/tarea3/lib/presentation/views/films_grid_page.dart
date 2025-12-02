import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewmodels/film_viewmodel.dart';
import '../../domain/entities/film_entity.dart';
import '../themes/app_theme.dart';

class FilmsGridPage extends StatefulWidget {
  const FilmsGridPage({super.key});

  @override
  State<FilmsGridPage> createState() => _FilmsGridPageState();
}

class _FilmsGridPageState extends State<FilmsGridPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();

    // Cargar películas al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilmViewModel>().loadFilms();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Studio Ghibli Films'),
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => vm.loadFilms(),
                tooltip: 'Recargar',
              ),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    _buildFilters(vm),
                    _buildPaginationInfo(vm),
                    Expanded(child: _buildContent(vm)),
                    _buildPaginationControls(vm),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilters(FilmViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.3),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.goldColor.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          // Búsqueda
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar por título...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: const Icon(Icons.search, color: AppTheme.goldColor),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppTheme.goldColor),
                      onPressed: () {
                        _searchController.clear();
                        vm.searchByTitle('');
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppTheme.surfaceColor.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.goldColor, width: 2),
              ),
            ),
            onChanged: (value) => vm.searchByTitle(value),
          ),
          const SizedBox(height: 12),
          // Filtros por director y año
          Row(
            children: [
              Expanded(
                child: _buildDirectorDropdown(vm),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildYearDropdown(vm),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  vm.clearFilters();
                },
                icon: const Icon(Icons.clear_all, size: 18),
                label: const Text('Limpiar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                  foregroundColor: AppTheme.goldColor,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDirectorDropdown(FilmViewModel vm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
      ),
      child: DropdownButton<String>(
        value: vm.selectedDirector,
        hint: Text(
          'Director',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: AppTheme.surfaceColor,
        icon: const Icon(Icons.arrow_drop_down, color: AppTheme.goldColor),
        style: const TextStyle(color: Colors.white),
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('Todos los directores'),
          ),
          ...vm.directors.map((director) {
            return DropdownMenuItem<String>(
              value: director,
              child: Text(director, overflow: TextOverflow.ellipsis),
            );
          }),
        ],
        onChanged: (value) => vm.filterByDirector(value),
      ),
    );
  }

  Widget _buildYearDropdown(FilmViewModel vm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
      ),
      child: DropdownButton<String>(
        value: vm.selectedYear,
        hint: Text(
          'Año',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: AppTheme.surfaceColor,
        icon: const Icon(Icons.arrow_drop_down, color: AppTheme.goldColor),
        style: const TextStyle(color: Colors.white),
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('Todos los años'),
          ),
          ...vm.years.map((year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(year),
            );
          }),
        ],
        onChanged: (value) => vm.filterByYear(value),
      ),
    );
  }

  Widget _buildPaginationInfo(FilmViewModel vm) {
    if (vm.loading && vm.films.isEmpty) return const SizedBox();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: ${vm.totalFilms} películas',
            style: const TextStyle(
              color: AppTheme.goldColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Página ${vm.currentPage + 1} de ${vm.totalPages}',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(FilmViewModel vm) {
    if (vm.loading && vm.films.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppTheme.goldColor),
            SizedBox(height: 16),
            Text(
              'Cargando películas...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    if (vm.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              vm.error!,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => vm.loadFilms(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
              ),
            ),
          ],
        ),
      );
    }

    if (vm.films.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_outlined, color: Colors.white54, size: 64),
            SizedBox(height: 16),
            Text(
              'No se encontraron películas',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: vm.films.length,
      itemBuilder: (context, index) {
        final film = vm.films[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index % 6 * 80)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: _buildFilmCard(film),
        );
      },
    );
  }

  Widget _buildFilmCard(FilmEntity film) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/film-detail',
          arguments: film,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.goldColor.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.goldColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen
            Expanded(
              flex: 4,
              child: Hero(
                tag: 'film_${film.id}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: film.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.surfaceColor,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.goldColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.surfaceColor,
                      child: const Icon(
                        Icons.movie,
                        color: AppTheme.goldColor,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Información
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      film.title,
                      style: const TextStyle(
                        color: AppTheme.goldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Título original
                    Text(
                      film.originalTitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Director y año
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 12,
                          color: AppTheme.goldColor,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            film.director,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: AppTheme.goldColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              film.releaseDate,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.goldColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: AppTheme.goldColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                film.rtScore,
                                style: const TextStyle(
                                  color: AppTheme.goldColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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

  Widget _buildPaginationControls(FilmViewModel vm) {
    if (vm.films.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.3),
        border: Border(
          top: BorderSide(
            color: AppTheme.goldColor.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: vm.hasPreviousPage ? () => vm.firstPage() : null,
            icon: const Icon(Icons.first_page),
            color: AppTheme.goldColor,
            disabledColor: Colors.grey,
            tooltip: 'Primera página',
          ),
          IconButton(
            onPressed: vm.hasPreviousPage ? () => vm.previousPage() : null,
            icon: const Icon(Icons.chevron_left),
            color: AppTheme.goldColor,
            disabledColor: Colors.grey,
            tooltip: 'Anterior',
          ),
          Text(
            '${vm.currentPage + 1} / ${vm.totalPages}',
            style: const TextStyle(
              color: AppTheme.goldColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: vm.hasNextPage ? () => vm.nextPage() : null,
            icon: const Icon(Icons.chevron_right),
            color: AppTheme.goldColor,
            disabledColor: Colors.grey,
            tooltip: 'Siguiente',
          ),
          IconButton(
            onPressed: vm.hasNextPage ? () => vm.lastPage() : null,
            icon: const Icon(Icons.last_page),
            color: AppTheme.goldColor,
            disabledColor: Colors.grey,
            tooltip: 'Última página',
          ),
        ],
      ),
    );
  }
}
