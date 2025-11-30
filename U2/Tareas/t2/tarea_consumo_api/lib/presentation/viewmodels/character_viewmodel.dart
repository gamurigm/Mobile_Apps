import 'package:flutter/foundation.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../data/models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final CharacterRepositoryImpl repository;

  bool loading = false;
  List<CharacterModel> characters = [];

  CharacterViewModel(this.repository);

  Future<void> loadCharacters() async {
    loading = true;
    notifyListeners();
    try {
      characters = await repository.getAllCharacters();
    } catch (e) {
      characters = [];
    }
    loading = false;
    notifyListeners();
  }
}
