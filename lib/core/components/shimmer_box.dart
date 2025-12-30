import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final bool isCircle;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 4,
    this.margin,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget shimmerContent = Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 0),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        color: Colors.white.withValues(alpha: 0.1),
        width: width,
        height: height,
      ),
    );

    // 2. Bungkus Container utama
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: isCircle
          ? ClipOval(child: shimmerContent)
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: shimmerContent,
            ),
    );
  }
}
