import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

/// WordPress REST API client for gtavigalaxy.com
class WpApi {
  static const String _base = 'https://www.gtavigalaxy.com/wp-json/wp/v2';
  static const int _perPage = 10;

  static Future<List<Post>> fetchPosts({int page = 1}) async {
    final uri = Uri.parse(
        '$_base/posts?per_page=$_perPage&page=$page&_embed=1&orderby=date&order=desc');
    final res = await http.get(uri).timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('Failed to load posts (${res.statusCode})');
    }
    final List data = json.decode(res.body) as List;
    return data
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<Post> fetchPost(int id) async {
    final uri = Uri.parse('$_base/posts/$id?_embed=1');
    final res = await http.get(uri).timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('Failed to load article (${res.statusCode})');
    }
    return Post.fromJson(json.decode(res.body) as Map<String, dynamic>);
  }

  static Future<List<Post>> searchPosts(String query) async {
    final uri = Uri.parse(
        '$_base/posts?search=${Uri.encodeQueryComponent(query)}&per_page=20&_embed=1&orderby=relevance');
    final res = await http.get(uri).timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('Search failed (${res.statusCode})');
    }
    final List data = json.decode(res.body) as List;
    return data
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
