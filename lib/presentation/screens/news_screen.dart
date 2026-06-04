import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/search_provider.dart';
import 'main_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  // debounce timer so we don't fire on every keystroke
  DateTime? _lastTyped;

  void _onChanged(String value) async {
    _lastTyped = DateTime.now();
    final typed = _lastTyped;

    // wait 500ms after user stops typing
    await Future.delayed(const Duration(milliseconds: 500));
    if (typed != _lastTyped) return; // user typed again, skip

    if (mounted) {
      context.read<SearchProvider>().search(value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.read<SearchProvider>().clear();
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 18,
          ),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onChanged,
          decoration: InputDecoration(
            hintText: 'Search news...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black54),
              onPressed: () {
                _controller.clear();
                context.read<SearchProvider>().clear();
              },
            ),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(SearchProvider provider) {
    // initial state
    if (provider.lastQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Search for news',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
            ),
          ],
        ),
      );
    }

    // loading
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // error
    if (provider.error != null) {
      return Center(
        child: Text(provider.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    // empty results
    if (provider.results.isEmpty) {
      return Center(
        child: Text(
          'No results for "${provider.lastQuery}"',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    // results
    return ListView.builder(
      itemCount: provider.results.length,
      itemBuilder: (_, index) => NewsListItem(article: provider.results[index]),
    );
  }
}
