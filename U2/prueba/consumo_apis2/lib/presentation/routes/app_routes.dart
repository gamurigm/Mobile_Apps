import 'package:flutter/material.dart';
import '../views/films_list_view.dart';
import '../views/film_detail_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => const FilmsListView(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/film-detail') {
      final filmId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => FilmDetailView(filmId: filmId),
      );
    }
    return null;
  }
}
