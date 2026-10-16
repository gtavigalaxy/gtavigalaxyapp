import 'dart:async';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api.dart';
import '../widgets/post_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<Post> _results = [];
  bool _loading = false;
  bool _searched = false;
  String? _error;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (q.trim().length >= 2) {
        _search(q.trim());
      } else {
        setState(() {
          _results = [];
          _searched = false;
        });
      }
    });
  }

  Future<void> _search(String q) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await WpApi.searchPosts(q);
      setState(() {
        _results = results;
        _searched = true;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (q) {
                if (q.trim().length >= 2) _search(q.trim());
              },
              decoration: InputDecoration(
                hintText: 'Search GTA 6 news...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            _results = [];
                            _searched = false;
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF16161F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(color: Color(0xFFFF2D78)),
            )
          else if (_error != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Search failed. Try again.',
                  style: TextStyle(color: Colors.white54)),
            )
          else if (_searched && _results.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.white24),
                  SizedBox(height: 12),
                  Text('No results found.',
                      style: TextStyle(color: Colors.white54)),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, i) => PostCard(post: _results[i]),
              ),
            ),
        ],
      ),
    );
  }
}
