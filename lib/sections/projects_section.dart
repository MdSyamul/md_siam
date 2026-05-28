import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({
    super.key,
    required this.compact,
    required this.onOpenLink,
  });

  final bool compact;
  final ValueChanged<String> onOpenLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SiteSubsectionIntro(
          title: 'Funded and Active Research',
          caption:
              'Projects grounded in the CV, university profile, and your recent research direction.',
        ),
        const SizedBox(height: 18),
        AdaptiveWrapGrid(
          minItemWidth: compact ? 240 : 320,
          maxColumns: compact ? 1 : 2,
          spacing: 18,
          children: [
            for (final item in projectEntries)
              SiteHoverPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SiteCategoryPill(label: item.category),
                        Text(
                          item.year,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: SiteColors.cyan),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.summary,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (item.note != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        item.note!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: SiteColors.navy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 30),
        const SiteSubsectionIntro(
          title: 'Selected GitHub Repositories',
          caption:
              'Public repositories that support your research, teaching, and applied modeling work.',
        ),
        const SizedBox(height: 18),
        AdaptiveWrapGrid(
          minItemWidth: compact ? 240 : 320,
          maxColumns: compact ? 1 : 3,
          spacing: 18,
          children: [
            for (final item in featuredRepositories)
              SiteHoverPanel(
                onTap: () => onOpenLink(item.url),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.code_rounded, color: SiteColors.cyan),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.repoName,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.summary,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SiteCategoryPill(label: item.language),
                        TextButton.icon(
                          onPressed: () => onOpenLink(item.url),
                          icon: const Icon(Icons.open_in_new_rounded, size: 18),
                          label: const Text('Repository'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
