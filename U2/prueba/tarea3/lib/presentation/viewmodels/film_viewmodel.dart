import 'package:flutter/foundation.dart';
import '../../domain/entities/film_entity.dart';
import '../../domain/usecases/film_usecases.dart';

class FilmViewModel extends ChangeNotifier {
  final GetFilmsUseCase getFilmsUseCase;

  FilmViewModel(this.getFilmsUseCase);

  bool _loading = false;
  String? _error;
  
  List<FilmEntity> _allFilms = [];
  List<FilmEntity> _filteredFilms = [];

  // Paginación
  static const int itemsPerPage = 6; // Para grid 2x3
  int _currentPage = 0;

  // Filtros
  String? _selectedDirector;
  String? _selectedYear;
  String _searchQuery = '';
  
  List<String> _directors = [];
  List<String> _years = [];

  // Getters
  bool get loading => _loading;
  String? get error => _error;
  List<FilmEntity> get films => _paginatedFilms;
  
  List<FilmEntity> get _paginatedFilms {
    final startIndex = _currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage > _filteredFilms.length)
        ? _filteredFilms.length
        : startIndex + itemsPerPage;
    
    if (_filteredFilms.isEmpty || startIndex >= _filteredFilms.length) {
      return [];
    }
    
    return _filteredFilms.sublist(startIndex, endIndex);
  }

  int get currentPage => _currentPage;
  int get totalPages => (_filteredFilms.length / itemsPerPage).ceil();
  bool get hasNextPage => _currentPage < totalPages - 1;
  bool get hasPreviousPage => _currentPage > 0;
  int get totalFilms => _filteredFilms.length;

  String? get selectedDirector => _selectedDirector;
  String? get selectedYear => _selectedYear;
  String get searchQuery => _searchQuery;
  
  List<String> get directors => _directors;
  List<String> get years => _years;

  /// Carga todas las películas
  Future<void> loadFilms() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _allFilms = await getFilmsUseCase.call();
      _filteredFilms = List.from(_allFilms);
      _extractFilters();
      _currentPage = 0;
      _loading = false;
    } catch (e) {
      _error = 'Error cargando películas: $e';
      _allFilms = [];
      _filteredFilms = [];
      _loading = false;
    }
    notifyListeners();
  }

  /// Extrae directores y años únicos de las películas
  void _extractFilters() {
    final directorSet = <String>{};
    final yearSet = <String>{};

    for (var film in _allFilms) {
      if (film.director.isNotEmpty) {
        directorSet.add(film.director);
      }
      if (film.releaseDate.isNotEmpty) {
        yearSet.add(film.releaseDate);
      }
    }

    _directors = directorSet.toList()..sort();
    _years = yearSet.toList()..sort((a, b) => b.compareTo(a)); // Orden descendente
  }

  /// Filtra por director
  void filterByDirector(String? director) {
    _selectedDirector = director;
    _currentPage = 0;
    _applyFilters();
  }

  /// Filtra por año
  void filterByYear(String? year) {
    _selectedYear = year;
    _currentPage = 0;
    _applyFilters();
  }

  /// Búsqueda por título
  void searchByTitle(String query) {
    _searchQuery = query;
    _currentPage = 0;
    _applyFilters();
  }

  /// Limpia todos los filtros
  void clearFilters() {
    _selectedDirector = null;
    _selectedYear = null;
    _searchQuery = '';
    _currentPage = 0;
    _applyFilters();
  }

  /// Aplica todos los filtros activos
  void _applyFilters() {
    _filteredFilms = _allFilms.where((film) {
      // Filtro por director
      if (_selectedDirector != null && _selectedDirector!.isNotEmpty) {
        if (film.director != _selectedDirector) return false;
      }

      // Filtro por año
      if (_selectedYear != null && _selectedYear!.isNotEmpty) {
        if (film.releaseDate != _selectedYear) return false;
      }

      // Búsqueda por título
      if (_searchQuery.isNotEmpty) {
        if (!film.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !film.originalTitle.toLowerCase().contains(_searchQuery.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();

    notifyListeners();
  }

  /// Navegación de páginas
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

  void firstPage() {
    _currentPage = 0;
    notifyListeners();
  }

  void lastPage() {
    _currentPage = totalPages - 1;
    notifyListeners();
  }
}
