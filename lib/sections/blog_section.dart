import 'package:flutter/material.dart';

import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({
    super.key,
    required this.compact,
    required this.onOpenBlog,
  });

  final bool compact;
  final VoidCallback onOpenBlog;

  @override
  Widget build(BuildContext context) {
    final icon = CircleAvatar(
      radius: compact ? 22 : 26,
      backgroundColor: SiteColors.surfaceMuted,
      child: const Icon(Icons.article_outlined, color: SiteColors.navy),
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Research notes and teaching reflections',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          'A dedicated space for short writing on engineering systems, applied AI, control, and classroom practice.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );

    final action = ElevatedButton.icon(
      onPressed: onOpenBlog,
      icon: const Icon(Icons.arrow_forward_rounded),
      label: const Text('Visit Blog'),
    );

    return SiteInfoPanel(
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon,
                const SizedBox(height: 18),
                copy,
                const SizedBox(height: 20),
                action,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 20),
                Expanded(child: copy),
                const SizedBox(width: 20),
                action,
              ],
            ),
    );
  }
}
