import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/post.dart';
import '../widgets/app_image.dart';
import '../widgets/image_viewer.dart';

class ArticleScreen extends StatelessWidget {
  final Post post;

  const ArticleScreen({super.key, required this.post});

  Future<void> _openInBrowser() async {
    final uri = Uri.parse(post.link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openImage(BuildContext context, String url) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ImageViewerScreen(imageUrl: url)),
    );
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
                  ? GestureDetector(
                      onTap: () => _openImage(context, post.imageUrl!),
                      child: AppImage(
                        imageUrl: post.imageUrl!,
                        fit: BoxFit.cover,
                      ),
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
                      if (post.authorName.isNotEmpty) ...[
                        const Icon(Icons.person,
                            size: 14, color: Colors.white38),
                        const SizedBox(width: 4),
                        Text(
                          post.authorName,
                          style: const TextStyle(
                              color: Color(0xFFFF7AA8), fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                      ],
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
                  HtmlWidget(
                    post.content,
                    textStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 16,
                      height: 1.55,
                    ),
                    customStylesBuilder: (element) {
                      switch (element.localName) {
                        case 'a':
                          return {
                            'color': '#FF7AA8',
                            'text-decoration': 'none'
                          };
                        case 'h1':
                          return {'font-size': '22px'};
                        case 'h2':
                          return {'font-size': '20px'};
                        case 'h3':
                          return {'font-size': '18px'};
                        case 'img':
                        case 'figure':
                          return {'margin': '12px 0'};
                      }
                      return null;
                    },
                    onTapUrl: (url) async {
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                        return true;
                      }
                      return false;
                    },
                    onTapImage: (imageMetadata) {
                      final sources = imageMetadata.sources;
                      final url =
                          sources.isNotEmpty ? sources.first.url : null;
                      if (url != null && url.isNotEmpty) {
                        _openImage(context, url);
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
