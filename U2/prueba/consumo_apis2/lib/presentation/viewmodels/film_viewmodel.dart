import 'package:flutter/material.dart';
import '../../domain/entities/film_entity.dart';
import '../../domain/usecases/get_films_usecase.dart';
import '../../domain/usecases/get_film_by_id_usecase.dart';

class FilmViewModel extends ChangeNotifier {
  final GetFilmsUseCase getFilmsUseCase;
  final GetFilmByIdUseCase getFilmByIdUseCase;

  FilmViewModel({
    required this.getFilmsUseCase,
    required this.getFilmByIdUseCase,
  });

  // Estado
  List<FilmEntity> _allFilms = [];
  List<FilmEntity> _filteredFilms = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Paginación
  int _currentPage = 0;
  final int _itemsPerPage = 6;

  // Filtros
  String _searchQuery = '';
  String _directorFilter = '';
  String _sortBy = 'title'; // 'title', 'release_date', 'rt_score'

  // Getters
  List<FilmEntity> get allFilms => _allFilms;
  List<FilmEntity> get paginatedFilms {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    if (startIndex >= _filteredFilms.length) return [];
    return _filteredFilms.sublist(
      startIndex,
      endIndex > _filteredFilms.length ? _filteredFilms.length : endIndex,
    );
  }
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get totalPages => (_filteredFilms.length / _itemsPerPage).ceil();
  bool get hasNextPage => _currentPage < totalPages - 1;
  bool get hasPreviousPage => _currentPage > 0;
  String get searchQuery => _searchQuery;
  String get directorFilter => _directorFilter;
  String get sortBy => _sortBy;
  
  List<String> get availableDirectors {
    final directors = _allFilms.map((film) => film.director).toSet().toList();
    directors.sort();
    return directors;
  }

  // Cargar películas
  Future<void> loadFilms() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allFilms = await getFilmsUseCase();
      _applyFiltersAndSort();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Búsqueda
  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _currentPage = 0;
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Filtro por director
  void setDirectorFilter(String director) {
    _directorFilter = director;
    _currentPage = 0;
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Ordenamiento
  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Paginación
  void nextPage() {
    if (hasNextPage) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (hasPreviousPage) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  // Limpiar filtros
  void clearFilters() {
    _searchQuery = '';
    _directorFilter = '';
    _sortBy = 'title';
    _currentPage = 0;
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Aplicar filtros y ordenamiento
  void _applyFiltersAndSort() {
    _filteredFilms = _allFilms.where((film) {
      final matchesSearch = _searchQuery.isEmpty ||
          film.title.toLowerCase().contains(_searchQuery) ||
          film.description.toLowerCase().contains(_searchQuery);
      
      final matchesDirector = _directorFilter.isEmpty ||
          film.director == _directorFilter;

      return matchesSearch && matchesDirector;
    }).toList();

    // Ordenar
    switch (_sortBy) {
      case 'title':
        _filteredFilms.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'release_date':
        _filteredFilms.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
        break;
      case 'rt_score':
        _filteredFilms.sort((a, b) {
          final scoreA = int.tryParse(a.rtScore) ?? 0;
          final scoreB = int.tryParse(b.rtScore) ?? 0;
          return scoreB.compareTo(scoreA);
        });
        break;
    }
  }

  // Obtener película por ID
  Future<FilmEntity?> getFilmById(String id) async {
    try {
      return await getFilmByIdUseCase(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}
