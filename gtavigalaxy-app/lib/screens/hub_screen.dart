import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/hub_data.dart';
import 'facts_screen.dart';

/// Hub tab: entry point to Trailers, Facts and more collections.
class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  Future<void> _openTrailer(BuildContext context, Trailer trailer) async {
    final uri = Uri.parse(trailer.watchUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the trailer')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GTA VI Hub')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Trailers'),
          const SizedBox(height: 8),
          for (final trailer in trailers)
            _trailerCard(context, trailer),
          const SizedBox(height: 20),
          _sectionTitle('Facts'),
          const SizedBox(height: 8),
          _hubCard(
            context,
            icon: Icons.lightbulb_outline,
            title: 'GTA VI Facts',
            subtitle: '${gtaFacts.length} things to know before launch',
            gradient: const [Color(0xFFFF2D78), Color(0xFF9D4EDD)],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FactsScreen()),
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle('Coming soon'),
          const SizedBox(height: 8),
          _hubCard(
            context,
            icon: Icons.photo_library_outlined,
            title: 'Screenshots & Artworks',
            subtitle: 'Official galleries from Rockstar',
            gradient: const [Color(0xFF3A3A5C), Color(0xFF23233A)],
            onTap: null,
          ),
          const SizedBox(height: 10),
          _hubCard(
            context,
            icon: Icons.people_outline,
            title: 'Characters',
            subtitle: 'Meet Lucia, Jason and the Leonida cast',
            gradient: const [Color(0xFF3A3A5C), Color(0xFF23233A)],
            onTap: null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 0.5),
    );
  }

  Widget _trailerCard(BuildContext context, Trailer trailer) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _openTrailer(context, trailer),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: trailer.thumbnailUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: Colors.white10),
                    errorWidget: (_, __, ___) =>
                        Container(color: Colors.white10),
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.play_arrow,
                          size: 36, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        trailer.duration,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trailer.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trailer.date,
                    style: const TextStyle(
                        color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hubCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback? onTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                onTap == null ? Icons.lock_outline : Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
