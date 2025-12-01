import 'package:flutter/material.dart';
import '../../../domain/entities/character_entity.dart';
import '../atoms/shimmer_loading.dart';
import '../atoms/empty_state.dart';
import '../molecules/character_card.dart';

/// ORGANISM: Lista completa de personajes con estados
class CharacterListOrganism extends StatelessWidget {
  final bool isLoading;
  final List<CharacterEntity> characters;
  final Function(CharacterEntity)? onCharacterTap;
  final ScrollController? scrollController;

  const CharacterListOrganism({
    super.key,
    required this.isLoading,
    required this.characters,
    this.onCharacterTap,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && characters.isEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, __) => const ShimmerLoading.rectangular(height: 100),
      );
    }

    if (characters.isEmpty) {
      return const EmptyState(
        icon: Icons.person_search,
        title: 'No se encontraron personajes',
        subtitle: 'Intenta con otro filtro de familia',
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      physics: const BouncingScrollPhysics(),
      itemCount: characters.length + 1, // +1 for loading indicator at bottom
      itemBuilder: (context, index) {
        if (index == characters.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final character = characters[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(
            milliseconds: 300 + (index % 5 * 50),
          ), // Staggered effect
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: CharacterCard(
            character: character,
            onTap: () => onCharacterTap?.call(character),
          ),
        );
      },
    );
  }
}
