import 'package:flutter/material.dart';

import '../../../site_content.dart';
import '../../../site_theme.dart';

enum HomePageSection { home, research, teaching, blog, contact }

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    required this.compact,
    required this.onSectionSelected,
  });

  final bool compact;
  final ValueChanged<HomePageSection> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 18 : 28,
        vertical: compact ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        border: const Border(bottom: BorderSide(color: SiteColors.line)),
        boxShadow: [
          BoxShadow(
            color: SiteColors.navy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  siteName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: compact ? 20 : 22),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Assistant Professor, Mechanical Engineering, SUST',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: compact ? 12 : 13,
                    color: SiteColors.textMuted,
                  ),
                  maxLines: compact ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (compact)
            IconButton(
              tooltip: 'Open navigation',
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: SiteColors.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  builder: (sheetContext) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final item in _visibleNavItems)
                              ListTile(
                                title: Text(item.label),
                                onTap: () {
                                  Navigator.of(sheetContext).pop();
                                  onSectionSelected(item.section);
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.menu_rounded),
            )
          else ...[
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 6,
                runSpacing: 4,
                children: [
                  for (final item in _visibleNavItems)
                    TextButton(
                      onPressed: () => onSectionSelected(item.section),
                      child: Text(item.label),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HomeNavItem {
  const _HomeNavItem(this.label, this.section);

  final String label;
  final HomePageSection section;
}

const List<_HomeNavItem> _visibleNavItems = [
  _HomeNavItem('Home', HomePageSection.home),
  _HomeNavItem('Research', HomePageSection.research),
  _HomeNavItem('Teaching', HomePageSection.teaching),
  _HomeNavItem('Blog', HomePageSection.blog),
  _HomeNavItem('Contact', HomePageSection.contact),
];
