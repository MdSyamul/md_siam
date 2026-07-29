import 'package:flutter/material.dart';

import '../blogs.dart';
import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';
import '../widgets/blog_html_view.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  static const routeName = '/blog';

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final Future<List<BlogPost>> _postsFuture = const BlogRepository()
      .loadPosts();
  String? _selectedCategory;

  void _openPost(BuildContext context, BlogPost post) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => BlogPostPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [SiteColors.background, Color(0xFFFDF9F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const _BlogTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: ContentShell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: compact ? 30 : 42,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blog',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 12),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            // child: Text(
                            //   'Notes on research, teaching, engineering systems, and applied AI.',
                            //   style: Theme.of(context).textTheme.bodyLarge,
                            // ),
                          ),
                          const SizedBox(height: 22),
                          FutureBuilder<List<BlogPost>>(
                            future: _postsFuture,
                            builder: (context, snapshot) {
                              final posts = snapshot.data ?? blogPosts;
                              final categories = {
                                for (final post in posts) post.category,
                              }.toList()..sort();
                              final filteredPosts = _selectedCategory == null
                                  ? posts
                                  : posts
                                        .where(
                                          (post) =>
                                              post.category ==
                                              _selectedCategory,
                                        )
                                        .toList();

                              if (posts.isEmpty) {
                                return const SiteInfoPanel(
                                  child: Text('No blog posts are available.'),
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      FilterChip(
                                        label: const Text('All'),
                                        selected: _selectedCategory == null,
                                        onSelected: (_) => setState(
                                          () => _selectedCategory = null,
                                        ),
                                      ),
                                      for (final category in categories)
                                        FilterChip(
                                          label: Text(category),
                                          selected:
                                              _selectedCategory == category,
                                          onSelected: (_) => setState(
                                            () => _selectedCategory = category,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      const cardWidth = 370.0;
                                      final width = constraints.maxWidth
                                          .clamp(0.0, cardWidth)
                                          .toDouble();

                                      return Wrap(
                                        spacing: 18,
                                        runSpacing: 18,
                                        children: [
                                          for (final post in filteredPosts)
                                            SizedBox(
                                              width: width,
                                              child: _BlogPostCard(
                                                post: post,
                                                onRead: () =>
                                                    _openPost(context, post),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 34),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({super.key, required this.post});

  final BlogPost post;

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;
    final post = widget.post;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [SiteColors.background, Color(0xFFFDF9F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _BlogTopBar(title: post.title),
              Expanded(
                child: SingleChildScrollView(
                  child: ContentShell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: compact ? 20 : 34,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 980),
                          child: BlogHtmlView(
                            sourceUrl: _blogImageUrl(post.contentUrl),
                            subtitle: post.subtitle,
                            compact: compact,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlogTopBar extends StatelessWidget {
  const _BlogTopBar({this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        border: const Border(bottom: BorderSide(color: SiteColors.line)),
        boxShadow: [
          BoxShadow(
            color: SiteColors.navy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () {
              final navigator = Navigator.of(context);
              if (navigator.canPop()) {
                navigator.pop();
              } else {
                navigator.pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title ?? '$siteName Blog',
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogPostCard extends StatelessWidget {
  const _BlogPostCard({required this.post, required this.onRead});

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
              imageUrl: _blogImageUrl(post.coverImageUrl!),
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
          _blogImageUrl(imageUrl),
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

String _blogImageUrl(String imageUrl) {
  return Uri.parse(imageUrl).hasScheme
      ? imageUrl
      : Uri.base.resolve(imageUrl).toString();
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
