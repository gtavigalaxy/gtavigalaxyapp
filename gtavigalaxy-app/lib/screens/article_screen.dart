import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/post.dart';

class ArticleScreen extends StatelessWidget {
  final Post post;

  const ArticleScreen({super.key, required this.post});

  Future<void> _openInBrowser() async {
    final uri = Uri.parse(post.link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => Share.share('${post.title}\n${post.link}',
                    subject: post.title),
              ),
              IconButton(
                icon: const Icon(Icons.open_in_browser),
                onPressed: _openInBrowser,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: post.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: post.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.white10),
                      errorWidget: (_, __, ___) =>
                          Container(color: Colors.white10),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF2D78), Color(0xFF9D4EDD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold, height: 1.25),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 14, color: Colors.white38),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('d MMM yyyy, HH:mm')
                            .format(post.date.toLocal()),
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                  const Divider(height: 28, color: Colors.white12),
                  Html(
                    data: post.content,
                    style: {
                      'body': Style(
                        color: Colors.white.withValues(alpha: 0.87),
                        fontSize: FontSize(16),
                        lineHeight: const LineHeight(1.55),
                      ),
                      'a': Style(color: const Color(0xFFFF7AA8)),
                      'h1': Style(fontSize: FontSize(22)),
                      'h2': Style(fontSize: FontSize(20)),
                      'h3': Style(fontSize: FontSize(18)),
                      'img': Style(margin: Margins.symmetric(vertical: 12)),
                      'figure':
                          Style(margin: Margins.symmetric(vertical: 12)),
                    },
                    onLinkTap: (url, _, __) async {
                      if (url == null) return;
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton.icon(
                      onPressed: _openInBrowser,
                      icon: const Icon(Icons.open_in_browser, size: 16),
                      label: const Text('Read on gtavigalaxy.com'),
                      style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFFF7AA8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
