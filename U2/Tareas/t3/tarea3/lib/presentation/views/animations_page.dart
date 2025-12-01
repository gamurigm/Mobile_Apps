import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../themes/app_theme.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({super.key});

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Small delay for fade-in effect
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animaciones')),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 800),
                      child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('Fade In Example', style: AppTheme.headingMedium.copyWith(color: AppTheme.goldColor)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Card(
                    color: Colors.transparent,
                    child: Center(
                      child: Lottie.network(
                        'https://assets2.lottiefiles.com/packages/lf20_usmfx6bp.json',
                        width: 220,
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: Text('Shimmer & Lottie can be used for API load animations', style: AppTheme.bodyMedium)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
