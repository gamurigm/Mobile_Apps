import 'package:flutter/foundation.dart';
import '../../domain/usecases/get_characters_usecase.dart';
import '../../domain/entities/character_entity.dart';

class CharacterViewModel extends ChangeNotifier {
  final GetCharactersUseCase getCharactersUseCase;

  bool loading = false;
  List<CharacterEntity> _allCharacters = [];
  List<CharacterEntity> _filteredCharacters = [];

  // Paginación
  static const int itemsPerPage = 10;
  int _currentPage = 0;

  // Filtro por familia
  String? _selectedFamily;
  List<String> _families = [];

  CharacterViewModel(this.getCharactersUseCase);

  // Getters
  List<CharacterEntity> get characters => _paginatedCharacters;
  List<CharacterEntity> get _paginatedCharacters {
    // Infinite Scroll: Show all items from 0 to current limit
    final limit = (_currentPage + 1) * itemsPerPage;
    if (_filteredCharacters.isEmpty) return [];
    return _filteredCharacters.sublist(
      0,
      limit > _filteredCharacters.length ? _filteredCharacters.length : limit,
    );
  }

  int get currentPage => _currentPage;
  int get totalPages => (_filteredCharacters.length / itemsPerPage).ceil();
  bool get hasNextPage => _currentPage < totalPages - 1;
  bool get hasPreviousPage => _currentPage > 0;

  String? get selectedFamily => _selectedFamily;
  List<String> get families => _families;

  Future<void> loadCharacters() async {
    loading = true;
    notifyListeners();
    try {
      _allCharacters = await getCharactersUseCase.call();
      _filteredCharacters = _allCharacters;
      _extractFamilies();
      _currentPage = 0;
    } catch (e) {
      _allCharacters = [];
      _filteredCharacters = [];
    }
    loading = false;
    notifyListeners();
  }

  void _extractFamilies() {
    final familySet = <String>{};
    for (var character in _allCharacters) {
      if (character.family.isNotEmpty) {
        familySet.add(character.family);
      }
    }
    _families = familySet.toList()..sort();
  }

  void filterByFamily(String? family) {
    _selectedFamily = family;
    _currentPage = 0;

    if (family == null || family.isEmpty) {
      _filteredCharacters = _allCharacters;
    } else {
      _filteredCharacters = _allCharacters
          .where((c) => c.family == family)
          .toList();
    }
    notifyListeners();
  }

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
}
