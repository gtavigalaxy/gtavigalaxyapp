import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';

/// Smart network image: uses AVIF decoding for .avif URLs (which Flutter
/// can't decode natively) and CachedNetworkImage for everything else.
class AppImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  static bool _isAvif(String url) =>
      url.toLowerCase().split('?').first.endsWith('.avif');

  @override
  Widget build(BuildContext context) {
    if (_isAvif(imageUrl)) {
      return CachedNetworkAvifImage(
        imageUrl,
        fit: fit,
        width: width ?? double.infinity,
        height: height,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.white10,
          child: const Center(
            child: Icon(Icons.broken_image_outlined,
                color: Colors.white30, size: 40),
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width ?? double.infinity,
      height: height,
      placeholder: (_, __) => Container(
        color: Colors.white10,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (_, __, ___) => Container(
        color: Colors.white10,
        child: const Center(
          child:
              Icon(Icons.broken_image_outlined, color: Colors.white30),
        ),
      ),
    );
  }
}
