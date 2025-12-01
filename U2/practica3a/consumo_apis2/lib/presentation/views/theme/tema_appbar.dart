
import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class TemaAppBar {
  static const AppBarTheme temaAppBar = AppBarTheme(
    backgroundColor: AppColors.primario,
    foregroundColor: AppColors.txtClaro,
    centerTitle: true,
    elevation: 2,
    scrolledUnderElevation: 4,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      color: AppColors.txtClaro,
    ),
    iconTheme: IconThemeData(
      color: AppColors.txtClaro,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.txtClaro,
      size: 24,
    ),
  );
}
