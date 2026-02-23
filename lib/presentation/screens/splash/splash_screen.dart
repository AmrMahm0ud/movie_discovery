import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_discovery/config/routes/routes_manager.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/config/theme/font_manager.dart';
import 'package:movie_discovery/config/theme/styles_manager.dart';
import 'package:movie_discovery/core/base/widget/base_stateful_widget.dart';
import 'package:movie_discovery/core/resources/image_paths.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({super.key});

  @override
  BaseState<SplashScreen> baseCreateState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lottieController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);
    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, Routes.movie);
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: Lottie.asset(
                  ImagePaths.splashLogo,
                  controller: _lottieController,
                  onLoaded: (composition) {
                    _lottieController
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Movie Discovery',
                style: getBoldStyle(
                  fontSize: FontSize.s24,
                  color: ColorManager.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover your next favorite movie',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
