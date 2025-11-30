import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewmodels/character_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper method to wrap image URL with CORS proxy when running on web
  String _getImageUrl(String originalUrl) {
    if (kIsWeb && originalUrl.isNotEmpty) {
      // Use a CORS proxy for web platform
      return 'https://corsproxy.io/?${Uri.encodeComponent(originalUrl)}';
    }
    return originalUrl;
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharacterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Characters - Thrones API")),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.characters.length,
              itemBuilder: (_, i) {
                final c = vm.characters[i];
                return ListTile(
                  leading: c.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: _getImageUrl(c.imageUrl),
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            width: 48,
                            height: 48,
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 48,
                            height: 48,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 32,
                            ),
                          ),
                        )
                      : Container(
                          width: 48,
                          height: 48,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 32,
                          ),
                        ),
                  title: Text(c.fullName),
                  subtitle: Text('${c.title} — ${c.family}'),
                );
              },
            ),
    );
  }
}
