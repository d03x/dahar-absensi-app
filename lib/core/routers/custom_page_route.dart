import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScalePageTransision extends PageRouteBuilder {
  final Widget child;

  ScalePageTransision({required this.child})
    : super(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //curved animation
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          );
          final scaleTween = Tween<double>(begin: 0.95, end: 1.0);
          return FadeTransition(
            opacity: curve,
            child: ScaleTransition(
              scale: scaleTween.animate(curve),
              child: child,
            ),
          );
        },
      );
}

CustomTransitionPage buildTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Menggunakan Logic "Premium Zoom" yang tadi saya buatkan
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      );
      final tweenAnimated = Tween<double>(begin: 0.95, end: 1.0);
      return FadeTransition(
        opacity: curve,
        child: ScaleTransition(
          scale: tweenAnimated.animate(curve),
          child: child,
        ),
      );
    },
  );
}
