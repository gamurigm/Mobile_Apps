import 'package:flutter/material.dart';
import '../views/main_navigation.dart';
import '../views/films_grid_page.dart';
import '../views/film_detail_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => const MainNavigation(),
    "/films": (_) => const FilmsGridPage(),
    "/film-detail": (_) => const FilmDetailPage(),
  };
}
