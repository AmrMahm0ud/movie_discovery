import 'package:flutter/material.dart';
import 'package:movie_discovery/config/theme/color_manager.dart';
import 'package:movie_discovery/config/theme/font_manager.dart';
import 'package:movie_discovery/config/theme/styles_manager.dart';

class CustomEmptyListWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const CustomEmptyListWidget({
    super.key,
    this.message = 'No movies found',
    this.icon = Icons.movie_outlined,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: ColorManager.disabled,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: getMediumStyle(
                fontSize: FontSize.s18,
                color: ColorManager.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
