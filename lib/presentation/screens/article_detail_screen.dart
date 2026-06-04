import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          /// ── Hero image + back button ──────────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Hero image
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child:
                      article.imageUrl != null && article.imageUrl!.isNotEmpty
                      ? Image.network(
                          article.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),

                // Gradient at bottom of image for smooth transition
              ],
            ),
          ),

          /// ── Content ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Author row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade200,
                        child: Text(
                          (article.source ?? 'N')[0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        article.source ?? 'Unknown Source',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  /// Category
                  Text(
                    (article.source ?? 'NEWS').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Colors.black45,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Title
                  Text(
                    article.title,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      color: Colors.black,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Date
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 20),

                  /// Description / body
                  Text(
                    article.description ?? article.title,
                    maxLines: 7,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.75,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /// ── Bottom action bar ─────────────────────────────────────────────
    );
  }

  Widget _actionIcon(IconData icon) {
    return Icon(icon, size: 22, color: Colors.black54);
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.grey,
          size: 48,
        ),
      ),
    );
  }
}
