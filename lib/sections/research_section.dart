import 'package:flutter/material.dart';

import '../widgets/site_widgets.dart';

class ResearchSection extends StatelessWidget {
  const ResearchSection({
    super.key,
    required this.compact,
    required this.onOpenResearchProfile,
    required this.onOpenResearchPage,
  });

  final bool compact;
  final VoidCallback onOpenResearchProfile;
  final VoidCallback onOpenResearchPage;

  @override
  Widget build(BuildContext context) {
    final copy = Text(
      'A focused research profile spanning Physical AI, intelligent engineering systems, control, and learning-driven mechanical design.',
      style: Theme.of(context).textTheme.bodyLarge,
    );

    final pageAction = ElevatedButton.icon(
      onPressed: onOpenResearchPage,
      icon: const Icon(Icons.arrow_forward_rounded),
      label: const Text('Explore Research'),
    );

    final profileAction = OutlinedButton.icon(
      onPressed: onOpenResearchProfile,
      icon: const Icon(Icons.school_rounded),
      label: const Text('View Scholar Profile'),
    );

    return SiteInfoPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          copy,
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [pageAction, profileAction],
          ),
        ],
      ),
    );
  }
}
