import 'package:flutter/material.dart';

import '../../blogs.dart';
import '../../site_theme.dart';
import '../blog/widgets/blog_top_bar.dart';
import 'widgets/blog_post_document.dart';

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({super.key, required this.post});

  final BlogPost post;

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              BlogTopBar(title: post.title),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: BlogPostDocument(
                    post: post,
                    compact: compact,
                    scrollController: _scrollController,
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
