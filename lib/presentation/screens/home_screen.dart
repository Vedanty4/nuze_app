import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuze_app/presentation/screens/breaking_news_card.dart';
import 'package:nuze_app/presentation/screens/main_list_item.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _breakingPage = 0;

  Future<bool> _onBack() async {
    if (!context.mounted) return false;
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Exit App"),
            content: const Text("Do you want to exit?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  // This is the trigger point
  // addPostFrameCallback - “Wait until UI is built, then fetch data”
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<NewsProvider>().fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onBack();
        if (shouldPop && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F2),
        body: RefreshIndicator(
          onRefresh: () => provider.fetchAll(),
          child: _buildBody(provider),
        ),
        bottomNavigationBar: AppBottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: (i) {
            if (i == 2) {
              context.push('/search'); // index 2 is the search icon
              return;
            }
            setState(() => _selectedIndex = i);
          },
        ),
      ),
    );
  }

  Widget _buildBody(NewsProvider provider) {
    if (provider.isLoading) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(),
          const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    if (provider.error != null) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => provider.fetchAll(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (provider.breaking.isEmpty && provider.normal.isEmpty) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(),
          const SliverFillRemaining(
            child: Center(child: Text("No news available")),
          ),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        _buildAppBar(),

        /// ── Horizontally scrollable breaking news cards ──────────────
        if (provider.breaking.isNotEmpty)
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.88),
                    itemCount: provider.breaking.length,
                    onPageChanged: (i) => setState(() => _breakingPage = i),
                    itemBuilder: (_, index) =>
                        BreakingNewsCard(article: provider.breaking[index]),
                  ),
                ),

                // Animated page indicator dots
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    provider.breaking!.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _breakingPage ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: i == _breakingPage
                            ? Colors.black
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),

        /// ── Latest News section title ─────────────────────────────────
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest News",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
          ),
        ),

        /// ── Normal news list ──────────────────────────────────────────
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => NewsListItem(article: provider.normal[index]),
            childCount: provider.normal.length,
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      floating: true,
      centerTitle: true,
      title: const Text(
        "NewsApp",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.black, size: 18),
      ),
    );
  }
}

// ── Bottom Navigation Bar ────────────────────────────────────────────────────

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    Icons.home_outlined,
    Icons.bookmark_border,
    Icons.search,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _items[i],
                  size: 22,
                  color: selected ? Colors.black : Colors.grey.shade400,
                ),
                const SizedBox(height: 4),
                if (selected)
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
