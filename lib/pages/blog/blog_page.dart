import 'package:flutter/material.dart';

import '../../blogs.dart';
import '../../site_theme.dart';
import '../../widgets/site_widgets.dart';
import '../blog_post/blog_post_page.dart';
import 'sections/blog_posts_section.dart';
import 'widgets/blog_top_bar.dart';

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
              const BlogTopBar(),
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
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(fontSize: compact ? 32 : null),
                          ),
                          const SizedBox(height: 22),
                          FutureBuilder<List<BlogPost>>(
                            future: _postsFuture,
                            builder: (context, snapshot) {
                              final posts = snapshot.data ?? blogPosts;
                              return BlogPostsSection(
                                posts: posts,
                                selectedCategory: _selectedCategory,
                                onCategorySelected: (category) => setState(
                                  () => _selectedCategory = category,
                                ),
                                onOpenPost: (post) => _openPost(context, post),
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
