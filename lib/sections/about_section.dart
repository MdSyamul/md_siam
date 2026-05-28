import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Column(
        children: [
          const SiteInfoPanel(child: _AboutNarrative()),
          const SizedBox(height: 20),
          const SiteInfoPanel(child: SiteDetailList(items: aboutDetails)),
        ],
      );
    }

    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: SiteInfoPanel(child: _AboutNarrative())),
        SizedBox(width: 20),
        Expanded(
          child: SiteInfoPanel(child: SiteDetailList(items: aboutDetails)),
        ),
      ],
    );
  }
}

class _AboutNarrative extends StatelessWidget {
  const _AboutNarrative();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Research-led teaching with applied engineering impact',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(siteBiography, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: SiteColors.surfaceMuted,
          ),
          child: Text(
            'My academic path began with numerical investigation of blood flow through the human common carotid artery and has grown toward intelligent control, robotics, thermal comfort modeling, and data-driven aerodynamic design.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: SiteColors.navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
