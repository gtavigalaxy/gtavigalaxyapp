import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> _posts = [];
  final ScrollController _scroll = ScrollController();
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels >=
              _scroll.position.maxScrollExtent - 400 &&
          !_loading &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final posts = await WpApi.fetchPosts(page: 1);
      setState(() {
        _posts
          ..clear()
          ..addAll(posts);
        _page = 1;
        _hasMore = posts.length == 10;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadMore() async {
    setState(() => _loading = true);
    try {
      final posts = await WpApi.fetchPosts(page: _page + 1);
      setState(() {
        _posts.addAll(posts);
        _page += 1;
        _hasMore = posts.length == 10;
      });
    } catch (_) {
      // keep existing posts on pagination failure
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF2D78), Color(0xFF9D4EDD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text('VI',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 15)),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GTAVI GALAXY',
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
                Text('GTA 6 News & Countdown',
                    style: TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        color: const Color(0xFFFF2D78),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null && _posts.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 120),
          const Icon(Icons.wifi_off, size: 56, color: Colors.white24),
          const SizedBox(height: 16),
          const Center(
              child: Text('Could not load news.\nCheck your connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54))),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _load,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF2D78)),
              child: const Text('Retry'),
            ),
          ),
        ],
      );
    }
    if (_posts.isEmpty && _loading) {
      return const Center(
          child: CircularProgressIndicator(color: Color(0xFFFF2D78)));
    }
    return ListView.builder(
      controller: _scroll,
      itemCount: _posts.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, i) {
        if (i >= _posts.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Color(0xFFFF2D78))),
          );
        }
        return PostCard(post: _posts[i], hero: i == 0);
      },
    );
  }
}
