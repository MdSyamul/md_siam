import 'package:flutter/material.dart';

import '../site_theme.dart';

class BlogHtmlView extends StatelessWidget {
  const BlogHtmlView({
    super.key,
    required this.sourceUrl,
    required this.subtitle,
    required this.compact,
    required this.initialHeight,
    this.scrollController,
    this.pointerEventsEnabled = true,
  });

  final String sourceUrl;
  final String subtitle;
  final bool compact;
  final double initialHeight;
  final ScrollController? scrollController;
  final bool pointerEventsEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SiteColors.line),
      ),
      child: Text(
        'HTML blog content is rendered in the web build.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
