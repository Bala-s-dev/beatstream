import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A cached, memory-capped network image with a lightweight shimmer-style
/// placeholder and graceful error fallback.
///
/// Using [CachedNetworkImage] (disk + memory cache) instead of a bare
/// [Image.network] avoids re-downloading and re-decoding artwork every time
/// a list rebuilds/scrolls back into view - a meaningful performance win for
/// scrollable music grids/lists.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.width,
    this.height,
    this.icon = Icons.music_note_rounded,
  });

  final String url;
  final BoxFit fit;
  final double borderRadius;
  final double? width;
  final double? height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final int? cacheWidth =
        width != null && width!.isFinite ? (width! * 2).round() : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        width: width,
        height: height,
        memCacheWidth: cacheWidth,
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: (context, _) => Container(
          width: width,
          height: height,
          color: AppColors.surfaceContainer,
        ),
        errorWidget: (context, _, __) => Container(
          width: width,
          height: height,
          color: AppColors.surfaceContainer,
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.outline),
        ),
      ),
    );
  }
}
