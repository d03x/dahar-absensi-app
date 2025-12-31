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
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
      final animate = CurveTween(curve: Curves.ease);

      final anims = CurvedAnimation(parent: animation, curve: Curves.linear);
      final bounce = Tween<double>(begin: 0.5, end: 1);

      return ScaleTransition(
        scale: bounce.animate(anims),
        child: SlideTransition(
          position: animation.drive(tween.chain(animate)),
          child: child,
        ),
      );
    },
  );
}
