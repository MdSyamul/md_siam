import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';

class ResearchSection extends StatelessWidget {
  const ResearchSection({
    super.key,
    required this.compact,
    required this.onOpenResearchProfile,
  });

  final bool compact;
  final VoidCallback onOpenResearchProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final interest in researchInterests)
          _ResearchInterestBullet(label: interest),
        const SizedBox(height: 16),
        Align(
          alignment: compact ? Alignment.centerLeft : Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onOpenResearchProfile,
            icon: const Icon(Icons.school_rounded, size: 18),
            label: const Text('View Scholar Profile'),
          ),
        ),
      ],
    );
  }
}

class _ResearchInterestBullet extends StatelessWidget {
  const _ResearchInterestBullet({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 9),
            child: Icon(Icons.circle, size: 7, color: SiteColors.cyan),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 17, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}
