import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/viewmodels/character_viewmodel.dart';
import 'presentation/viewmodels/film_viewmodel.dart';
import 'data/repositories/character_repository_impl.dart';
import 'data/repositories/film_repository_impl.dart';
import 'data/datasource/characters_api_datasource.dart';
import 'data/datasource/films_api_datasource.dart';
import 'domain/usecases/get_characters_usecase.dart';
import 'domain/usecases/film_usecases.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/themes/app_theme.dart';

void main() {
  // Inyección de dependencias para Characters
  final charactersDs = CharactersApiDataSource();
  final charactersRepo = CharacterRepositoryImpl(charactersDs);
  final getCharactersUseCase = GetCharactersUseCase(charactersRepo);
  final characterVm = CharacterViewModel(getCharactersUseCase)..loadCharacters();

  // Inyección de dependencias para Films (Studio Ghibli)
  final filmsDs = FilmsApiDataSource();
  final filmsRepo = FilmRepositoryImpl(filmsDs);
  final getFilmsUseCase = GetFilmsUseCase(filmsRepo);
  final filmVm = FilmViewModel(getFilmsUseCase);

  runApp(MyApp(
    characterVm: characterVm,
    filmVm: filmVm,
  ));
}

class MyApp extends StatelessWidget {
  final CharacterViewModel characterVm;
  final FilmViewModel filmVm;

  const MyApp({
    super.key,
    required this.characterVm,
    required this.filmVm,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: characterVm),
        ChangeNotifierProvider.value(value: filmVm),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Studio Ghibli & Game of Thrones",
        theme: AppTheme.theme,
        routes: AppRoutes.routes,
        initialRoute: "/",
      ),
    );
  }
}
