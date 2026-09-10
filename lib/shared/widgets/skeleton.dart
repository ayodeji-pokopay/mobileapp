import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Shimmering placeholder block used while data loads.
class Skeleton extends StatefulWidget {
  const Skeleton({super.key, this.height = 16, this.width, this.radius = 8});

  /// A card-shaped skeleton with a few text lines inside.
  const factory Skeleton.card({Key? key, double height}) = _SkeletonCard;

  final double height;
  final double? width;
  final double radius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = reduce ? 0.5 : _c.value;
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * t - 1, 0),
              end: Alignment(-1 + 2 * t + 1, 0),
              colors: const [
                AppColors.surfaceAlt,
                Color(0xFFF4F3F0),
                AppColors.surfaceAlt,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SkeletonCard extends Skeleton {
  const _SkeletonCard({super.key, super.height = 120});

  @override
  State<Skeleton> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(height: 12, width: 110),
          SizedBox(height: 12),
          Skeleton(height: 22, width: 160),
          SizedBox(height: 10),
          Skeleton(height: 12, width: 90),
        ],
      ),
    );
  }
}
