import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/film_entity.dart';
import '../themes/app_theme.dart';

class FilmDetailPage extends StatefulWidget {
  const FilmDetailPage({super.key});

  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final film = ModalRoute.of(context)!.settings.arguments as FilmEntity;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context, film),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildContent(film),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, FilmEntity film) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            film.title,
            style: const TextStyle(
              color: AppTheme.goldColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'film_${film.id}',
              child: CachedNetworkImage(
                imageUrl: film.movieBanner.isNotEmpty 
                    ? film.movieBanner 
                    : film.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppTheme.surfaceColor,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.goldColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppTheme.surfaceColor,
                  child: const Icon(
                    Icons.movie,
                    color: AppTheme.goldColor,
                    size: 80,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(FilmEntity film) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título original
          _buildSectionTitle('Título Original'),
          const SizedBox(height: 8),
          Text(
            film.originalTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            film.originalTitleRomanised,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Información general
          _buildInfoCards(film),
          const SizedBox(height: 24),

          // Descripción
          _buildSectionTitle('Sinopsis'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.goldColor.withOpacity(0.3),
              ),
            ),
            child: Text(
              film.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 24),

          // Detalles adicionales
          _buildAdditionalDetails(film),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppTheme.goldColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.goldColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCards(FilmEntity film) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Icons.person,
            label: 'Director',
            value: film.director,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            icon: Icons.calendar_today,
            label: 'Año',
            value: film.releaseDate,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.goldColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.goldColor, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetails(FilmEntity film) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Detalles'),
        const SizedBox(height: 12),
        _buildDetailRow(Icons.movie_creation, 'Productor', film.producer),
        _buildDetailRow(Icons.timer, 'Duración', '${film.runningTime} min'),
        _buildDetailRow(Icons.star, 'Rotten Tomatoes Score', '${film.rtScore}/100'),
        
        if (film.people.isNotEmpty)
          _buildDetailRow(Icons.groups, 'Personajes', '${film.people.length} personajes'),
        
        if (film.locations.isNotEmpty)
          _buildDetailRow(Icons.location_on, 'Locaciones', '${film.locations.length} locaciones'),
        
        if (film.vehicles.isNotEmpty)
          _buildDetailRow(Icons.directions_car, 'Vehículos', '${film.vehicles.length} vehículos'),
        
        if (film.species.isNotEmpty)
          _buildDetailRow(Icons.pets, 'Especies', '${film.species.length} especies'),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.goldColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.goldColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
