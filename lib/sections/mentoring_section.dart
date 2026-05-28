import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class MentoringSection extends StatelessWidget {
  const MentoringSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrapGrid(
      minItemWidth: compact ? 240 : 320,
      maxColumns: compact ? 1 : 2,
      spacing: 18,
      children: [
        for (final item in mentoringItems)
          SiteHoverPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SiteStatusBadge(label: item.status),
                    const Icon(Icons.school_outlined, color: SiteColors.cyan),
                  ],
                ),
                const SizedBox(height: 16),
                Text(item.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Text(
                  item.summary,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
