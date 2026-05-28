import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class HighlightsSection extends StatelessWidget {
  const HighlightsSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrapGrid(
      minItemWidth: compact ? 160 : 190,
      maxColumns: compact ? 2 : 5,
      spacing: 16,
      children: [
        for (final item in siteHighlights)
          SiteHoverPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: SiteColors.surfaceMuted,
                  child: Icon(item.icon, color: SiteColors.navy),
                ),
                const SizedBox(height: 18),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: compact ? 24 : 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SiteColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
