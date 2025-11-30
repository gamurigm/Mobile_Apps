import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/rick_morty_datasource.dart';
import 'data/repositories/character_repository.dart';
import 'domain/usecases/get_data.dart';
import 'presentation/viewmodels/character_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  final datasource = RickMortyDatasource();
  final repository = CharacterRepositoryImpl(datasource);
  final useCase = GetDataUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterViewModel(useCase)..loadData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: AppRoutes.routes,
      ),
    ),
  );
}
