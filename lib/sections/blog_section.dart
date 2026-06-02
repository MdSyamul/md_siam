import 'package:flutter/material.dart';

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
    final copy = Text(
      'Brief reflections for students and collaborators on how research ideas connect with teaching practice and engineering judgment.',
      style: Theme.of(context).textTheme.bodyLarge,
    );

    final action = ElevatedButton.icon(
      onPressed: onOpenBlog,
      icon: const Icon(Icons.arrow_forward_rounded),
      label: const Text('Visit Blog'),
    );

    return SiteInfoPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [copy, const SizedBox(height: 18), action],
      ),
    );
  }
}
