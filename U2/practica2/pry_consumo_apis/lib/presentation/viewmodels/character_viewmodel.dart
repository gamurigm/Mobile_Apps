import '../../domain/entities/character.dart';
import '../../domain/usecases/get_data.dart';
import 'base_viewmodel.dart';

class CharacterViewModel extends BaseViewModel<CharacterEntity> {
  CharacterViewModel(GetDataUseCase<CharacterEntity> useCase) : super(useCase);
}
