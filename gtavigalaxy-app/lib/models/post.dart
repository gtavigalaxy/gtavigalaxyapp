/// Model for a WordPress post from the GTAVI Galaxy site API.
class Post {
  final int id;
  final DateTime date;
  final String slug;
  final String title;
  final String excerpt;
  final String content;
  final String link;
  final String? imageUrl;

  Post({
    required this.id,
    required this.date,
    required this.slug,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.link,
    this.imageUrl,
  });

  static String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&hellip;', '...')
        .replaceAll('&#8230;', '...')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    try {
      final embedded = json['_embedded'] as Map<String, dynamic>?;
      final media = embedded?['wp:featuredmedia'] as List?;
      if (media != null && media.isNotEmpty) {
        final m = media.first as Map<String, dynamic>;
        // Prefer a mid-size variant to keep list scrolling fast.
        final sizes =
            (m['media_details'] as Map<String, dynamic>?)?['sizes'] as Map<String, dynamic>?;
        imageUrl = sizes?['medium_large']?['source_url'] as String? ??
            sizes?['large']?['source_url'] as String? ??
            sizes?['medium']?['source_url'] as String? ??
            m['source_url'] as String?;
      }
    } catch (_) {
      imageUrl = null;
    }

    return Post(
      id: json['id'] as int,
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      slug: json['slug'] as String? ?? '',
      title: _stripHtml((json['title'] as Map?)?['rendered'] as String? ?? ''),
      excerpt: _stripHtml((json['excerpt'] as Map?)?['rendered'] as String? ?? ''),
      content: (json['content'] as Map?)?['rendered'] as String? ?? '',
      link: json['link'] as String? ?? '',
      imageUrl: imageUrl,
    );
  }
}
