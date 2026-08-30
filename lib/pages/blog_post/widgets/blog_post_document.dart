import 'package:flutter/material.dart';

import '../../../blogs.dart';
import '../../../widgets/blog_html_view.dart';
import '../../../widgets/site_widgets.dart';
import '../../blog/widgets/blog_asset_url.dart';

class BlogPostDocument extends StatelessWidget {
  const BlogPostDocument({
    super.key,
    required this.post,
    required this.compact,
    required this.scrollController,
  });

  final BlogPost post;
  final bool compact;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ContentShell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: compact ? 20 : 34),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: BlogHtmlView(
              sourceUrl: resolveBlogAssetUrl(post.contentUrl),
              subtitle: post.subtitle,
              compact: compact,
              initialHeight: compact
                  ? post.compactWebContentHeight
                  : post.webContentHeight,
              scrollController: scrollController,
              pointerEventsEnabled: false,
            ),
          ),
        ),
      ),
    );
  }
}
