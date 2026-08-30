import 'package:flutter/material.dart';

import '../../../blogs.dart';
import '../../../site_theme.dart';
import '../../../widgets/site_widgets.dart';
import 'blog_asset_url.dart';

class BlogPostCard extends StatelessWidget {
  const BlogPostCard({super.key, required this.post, required this.onRead});

  final BlogPost post;
  final VoidCallback onRead;

  @override
  Widget build(BuildContext context) {
    return SiteHoverPanel(
      onTap: onRead,
      child: Column(
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
          if (post.coverImageUrl != null) ...[
            const SizedBox(height: 16),
            _BlogCardImage(
              imageUrl: post.coverImageUrl!,
              semanticLabel: post.title,
            ),
          ],
          const SizedBox(height: 16),
          Text(post.title, style: Theme.of(context).textTheme.titleLarge),
          if (post.subtitle.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              post.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onRead,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('Read'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogCardImage extends StatelessWidget {
  const _BlogCardImage({required this.imageUrl, required this.semanticLabel});

  final String imageUrl;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Image.network(
          resolveBlogAssetUrl(imageUrl),
          fit: BoxFit.cover,
          semanticLabel: semanticLabel,
          loadingBuilder: _imageLoadingBuilder,
          errorBuilder: _imageErrorBuilder,
        ),
      ),
    );
  }
}

Widget _imageLoadingBuilder(
  BuildContext context,
  Widget child,
  ImageChunkEvent? loadingProgress,
) {
  if (loadingProgress == null) {
    return child;
  }

  return ColoredBox(
    color: SiteColors.surfaceMuted,
    child: Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes == null
            ? null
            : loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!,
      ),
    ),
  );
}

Widget _imageErrorBuilder(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) {
  return ColoredBox(
    color: SiteColors.surfaceMuted,
    child: Center(
      child: Icon(
        Icons.broken_image_rounded,
        color: SiteColors.textMuted.withValues(alpha: 0.7),
        size: 38,
      ),
    ),
  );
}
