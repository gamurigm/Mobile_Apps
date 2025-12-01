import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/character_viewmodel.dart';
import '../widgets/atoms/shimmer_loading.dart';
import '../themes/app_theme.dart';
import '../themes/family_colors.dart';

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final viewModel = Provider.of<CharacterViewModel>(context, listen: false);
      if (!viewModel.loading && viewModel.hasNextPage) {
        viewModel.nextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterViewModel>(
      builder: (context, vm, child) {
        final items = vm.characters;

        return Scaffold(
          appBar: AppBar(title: const Text('Grid View')),
          body: Container(
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildContent(vm, items),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(CharacterViewModel vm, List items) {
    if (vm.loading && items.isEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: 12,
        itemBuilder: (_, __) => const ShimmerLoading.rectangular(height: 150),
      );
    }

    if (items.isEmpty) {
      return const Center(
        child: Text('No hay personajes', style: TextStyle(color: Colors.white)),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      // Add 1 for the loading indicator at the bottom if we are not at the end
      itemCount: items.length + (vm.hasNextPage ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == items.length) {
          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(color: AppTheme.goldColor),
            ),
          );
        }

        final character = items[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index % 8 * 60)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: _buildGridCard(character),
        );
      },
    );
  }

  Widget _buildGridCard(character) {
    return GestureDetector(
      onTap: () => _showCharacterDetail(context, character),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: AppTheme.smallRadius,
          border: Border.all(
            color: FamilyColors.getColorByFamily(
              character.family,
            ).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: FamilyColors.getColorByFamily(
                character.family,
              ).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Avatar image
                  Hero(
                    tag: 'character_grid_${character.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(character.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Family badge overlay
                  if (character.family.isNotEmpty)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: FamilyColors.getColorByFamily(
                            character.family,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.shield,
                              size: 10,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              character.family.length > 8
                                  ? '${character.family.substring(0, 6)}..'
                                  : character.family,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Info section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name
                    Text(
                      character.fullName,
                      style: const TextStyle(
                        color: AppTheme.goldColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    // Title
                    if (character.title.isNotEmpty)
                      Text(
                        character.title,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 9,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCharacterDetail(BuildContext context, character) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Imagen grande
                    Hero(
                      tag:
                          'character_grid_${character.id}', // Unique tag for grid
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.goldColor,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.goldColor.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(character.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Nombre
                    Text(
                      character.fullName,
                      style: AppTheme.headingLarge.copyWith(
                        color: AppTheme.goldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Título
                    if (character.title.isNotEmpty)
                      Text(
                        character.title,
                        style: AppTheme.bodyMedium.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 24),
                    // Información adicional
                    _buildInfoRow(Icons.shield, 'Casa', character.family),
                    _buildInfoRow(Icons.person, 'Nombre', character.firstName),
                    _buildInfoRow(Icons.badge, 'Apellido', character.lastName),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.3),
        borderRadius: AppTheme.smallRadius,
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.goldColor, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTheme.caption),
              Text(value, style: AppTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}
