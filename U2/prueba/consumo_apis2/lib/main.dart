import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modern_theme/modern_theme.dart';

import 'presentation/viewmodels/film_viewmodel.dart';
import 'domain/usecases/get_films_usecase.dart';
import 'domain/usecases/get_film_by_id_usecase.dart';
import 'data/repositories/film_repository_impl.dart';
import 'data/datasource/film_api_datasource.dart';

import 'presentation/routes/app_routes.dart';

void main() {
  // Inyección de dependencias para Ghibli Films
  final filmDataSource = FilmApiDataSource();
  final filmRepo = FilmRepositoryImpl(filmDataSource);
  final getFilmsUseCase = GetFilmsUseCase(filmRepo);
  final getFilmByIdUseCase = GetFilmByIdUseCase(filmRepo);

  runApp(
    MyApp(
      getFilmsUseCase: getFilmsUseCase,
      getFilmByIdUseCase: getFilmByIdUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetFilmsUseCase getFilmsUseCase;
  final GetFilmByIdUseCase getFilmByIdUseCase;

  const MyApp({
    super.key,
    required this.getFilmsUseCase,
    required this.getFilmByIdUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FilmViewModel(
            getFilmsUseCase: getFilmsUseCase,
            getFilmByIdUseCase: getFilmByIdUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        title: "Studio Ghibli Films",
        debugShowCheckedModeBanner: false,
        theme: TemaGeneral.temaClaro,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
