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
            if (posts.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  final availableWidth = constraints.maxWidth;
                  final cardWidth = availableWidth < 360
                      ? availableWidth
                      : compact
                      ? availableWidth
                      : availableWidth.clamp(520.0, 620.0);

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
            const SizedBox(height: 16),
            Align(
              alignment: compact ? Alignment.centerLeft : Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onOpenBlog,
                icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: const Text('Browse all writing'),
              ),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontal = constraints.maxWidth >= 520;
          final image = post.coverImageUrl == null
              ? null
              : _FeaturedBlogImage(
                  imageUrl: Uri.base.resolve(post.coverImageUrl!).toString(),
                );
          final details = _FeaturedBlogDetails(post: post);

          if (!horizontal || image == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null) ...[image, const SizedBox(height: 14)],
                details,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 240, child: image),
              const SizedBox(width: 20),
              Expanded(child: details),
            ],
          );
        },
      ),
    );
  }
}

class _FeaturedBlogImage extends StatelessWidget {
  const _FeaturedBlogImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          imageUrl,
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
    );
  }
}

class _FeaturedBlogDetails extends StatelessWidget {
  const _FeaturedBlogDetails({required this.post});

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}
