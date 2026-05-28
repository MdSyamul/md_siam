import 'package:flutter/material.dart';

import '../site_content.dart';
import '../widgets/site_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrapGrid(
      minItemWidth: compact ? 240 : 320,
      maxColumns: compact ? 1 : 3,
      spacing: 18,
      children: [
        for (final group in skillGroups)
          SiteInfoPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  group.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final skill in group.skills)
                      SiteSkillChip(label: skill),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
