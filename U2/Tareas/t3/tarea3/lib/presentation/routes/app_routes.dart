import 'package:flutter/material.dart';
import '../views/main_navigation.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "/": (_) => const MainNavigation(),
  };
}
