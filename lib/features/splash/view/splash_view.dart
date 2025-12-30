import 'package:dakos/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                    "ABSENSI",
                    style: context.textTheme.displayMedium!.copyWith(
                      fontFamily: GoogleFonts.akronim().fontFamily,
                    ),
                  )
                  .animate()
                  .fade(duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),

              const SizedBox(height: 8),
              Text(
                    "PT. Internusa Technology",
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontFamily: GoogleFonts.akronim().fontFamily,
                    ),
                  )
                  .animate(delay: 300.ms)
                  .fade(duration: 600.ms)
                  .shimmer(
                    duration: 1.seconds,
                    delay: 900.ms,
                    color: context.colorScheme.primary,
                  )
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuad),
            ],
          ),
        ),
      ),
    );
  }
}
