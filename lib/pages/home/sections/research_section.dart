import 'package:flutter/material.dart';

import '../../../site_theme.dart';
import '../../../widgets/site_widgets.dart';

class ResearchSection extends StatelessWidget {
  const ResearchSection({
    super.key,
    required this.compact,
    required this.onOpenResearchPage,
    required this.onGoogleScholar,
  });

  final bool compact;
  final VoidCallback onOpenResearchPage;
  final VoidCallback onGoogleScholar;

  @override
  Widget build(BuildContext context) {
    return SiteSectionBlock(
      eyebrow: 'Research',
      title: 'Research Areas',
      subtitle: 'Major research areas and topics of interest.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final interest in _researchInterests)
            _ResearchInterestBullet(label: interest),
          const SizedBox(height: 16),
          Align(
            alignment: compact ? Alignment.centerLeft : Alignment.centerRight,
            child: Wrap(
              alignment: compact ? WrapAlignment.start : WrapAlignment.end,
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: onOpenResearchPage,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: const Text('Explore research directions'),
                  style: _researchButtonStyle,
                ),
                OutlinedButton.icon(
                  key: const Key('research-google-scholar-button'),
                  onPressed: onGoogleScholar,
                  icon: const Icon(Icons.school_rounded, size: 18),
                  label: const Text('Google Scholar'),
                  style: _researchButtonStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final ButtonStyle _researchButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: SiteColors.navy,
  side: const BorderSide(color: SiteColors.cyan),
  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
);

const List<String> _researchInterests = [
  'Additive Manufacturing',
  'Physical AI',
  'System dynamics and control',
  'Generative Mechanical Design',
];

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
