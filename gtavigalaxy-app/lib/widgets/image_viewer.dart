import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Full-screen image viewer with pinch-to-zoom.
class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF2D78)),
            ),
            errorWidget: (_, __, ___) => const Center(
              child:
                  Icon(Icons.broken_image_outlined, size: 64, color: Colors.white30),
            ),
          ),
        ),
      ),
    );
  }
}
