import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class ResearchSection extends StatelessWidget {
  const ResearchSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrapGrid(
      minItemWidth: compact ? 240 : 260,
      maxColumns: compact ? 1 : 3,
      spacing: 18,
      children: [
        for (final item in researchAreas)
          SiteHoverPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: SiteColors.surfaceMuted,
                  child: Icon(item.icon, color: SiteColors.navy),
                ),
                const SizedBox(height: 18),
                Text(item.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Text(
                  item.summary,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                for (final application in item.applications)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: SiteColors.cyan,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            application,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
