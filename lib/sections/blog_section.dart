import 'package:flutter/material.dart';

import '../blog_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({
    super.key,
    required this.compact,
    required this.onOpenBlog,
    required this.onOpenPost,
  });

  final bool compact;
  final VoidCallback onOpenBlog;
  final ValueChanged<BlogPost> onOpenPost;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogPost>>(
      future: const BlogRepository().loadPosts(),
      builder: (context, snapshot) {
        final posts = (snapshot.data ?? blogPosts).take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Text(
                'Reflections on research, teaching, philosophy, and engineering judgment.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 18),
            if (posts.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  final availableWidth = constraints.maxWidth;
                  final cardWidth = availableWidth < 360
                      ? availableWidth
                      : compact
                      ? 300.0
                      : 320.0;

                  return Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: [
                      for (final post in posts)
                        SizedBox(
                          width: cardWidth,
                          child: _FeaturedBlogCard(
                            post: post,
                            onRead: () => onOpenPost(post),
                          ),
                        ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onOpenBlog,
                  icon: const Icon(Icons.library_books_rounded),
                  label: const Text('Visit Blog'),
                ),
                TextButton.icon(
                  onPressed: onOpenBlog,
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: const Text('Browse all writing'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _FeaturedBlogCard extends StatelessWidget {
  const _FeaturedBlogCard({required this.post, required this.onRead});

  final BlogPost post;
  final VoidCallback onRead;

  @override
  Widget build(BuildContext context) {
    return SiteHoverPanel(
      onTap: onRead,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.coverImageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  Uri.base.resolve(post.coverImageUrl!).toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: SiteColors.surfaceMuted,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: SiteColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SiteCategoryPill(label: post.category),
              if (post.displayDate != null)
                SiteCategoryPill(label: post.displayDate!),
            ],
          ),
          const SizedBox(height: 12),
          Text(post.title, style: Theme.of(context).textTheme.titleLarge),
          if (post.summary.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              post.summary,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 14),
          TextButton.icon(
            onPressed: onRead,
            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
            label: const Text('Read'),
          ),
        ],
      ),
    );
  }
}
