import 'package:flutter/material.dart';


/// Card genérica y flexible para cualquier tipo de entidad
/// Soporta header personalizado, contenido dinámico y acciones
class GenericEntityCard extends StatelessWidget {
  final String cardTitle;
  final List<CardSection> sections;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double borderRadius;

  const GenericEntityCard({
    super.key,
    required this.cardTitle,
    required this.sections,
    this.onTap,
    this.padding,
    this.borderColor,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.sombra.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: borderColor ?? AppColors.borde.withOpacity(0.5),
          width: 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sections
                .map((section) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: section != sections.last ? 16 : 0,
                    ),
                    child: section.build(context),
                  );
                })
                .toList(),
          ),
        ),
      ),
    );
  }
}

/// Interfaz para secciones de la tarjeta genérica
abstract class CardSection {
  Widget build(BuildContext context);
}

/// Sección simple con solo contenido
class SimpleCardSection extends CardSection {
  final Widget child;

  SimpleCardSection({required this.child});

  @override
  Widget build(BuildContext context) => child;
}

/// Sección con título
class TitledCardSection extends CardSection {
  final String title;
  final Widget content;
  final TextStyle? titleStyle;

  TitledCardSection({
    required this.title,
    required this.content,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.txtSecundario,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}
