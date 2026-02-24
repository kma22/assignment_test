import 'package:flutter/material.dart';
import 'package:pipes/presentation/theme/app_colors.dart';
import 'package:pipes/presentation/theme/app_fonts.dart';


class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (final bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            'PIPES',
            textAlign: TextAlign.center,
            style: AppFonts.heading(fontSize: 36).copyWith(
              color: AppColors.white,
              letterSpacing: 8,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Logopotam Assignment',
          textAlign: TextAlign.center,
          style: AppFonts.body(fontSize: 14).copyWith(
            color: AppColors.primary.withValues(alpha: 0.6),
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}
