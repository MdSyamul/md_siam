import 'package:flutter/material.dart';

import '../../../blogs.dart';
import '../../../widgets/site_widgets.dart';
import '../widgets/blog_post_card.dart';

class BlogPostsSection extends StatelessWidget {
  const BlogPostsSection({
    super.key,
    required this.posts,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onOpenPost,
  });

  final List<BlogPost> posts;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;
  final ValueChanged<BlogPost> onOpenPost;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const SiteInfoPanel(child: Text('No blog posts are available.'));
    }

    final categories = {for (final post in posts) post.category}.toList()
      ..sort();
    final filteredPosts = selectedCategory == null
        ? posts
        : posts.where((post) => post.category == selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('All'),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
            ),
            for (final category in categories)
              FilterChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (_) => onCategorySelected(category),
              ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            const cardWidth = 370.0;
            final width = constraints.maxWidth.clamp(0.0, cardWidth).toDouble();

            return Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                for (final post in filteredPosts)
                  SizedBox(
                    width: width,
                    child: BlogPostCard(
                      post: post,
                      onRead: () => onOpenPost(post),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
