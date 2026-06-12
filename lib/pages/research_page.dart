import 'package:flutter/material.dart';

import '../research_content.dart';
import '../site_content.dart';
import '../site_theme.dart';
import '../utils/external_link.dart' as external_link;
import '../widgets/site_widgets.dart';

class ResearchPage extends StatelessWidget {
  const ResearchPage({super.key});

  static const routeName = '/research';

  void _openItem(BuildContext context, ResearchContentItem item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ResearchDetailPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [SiteColors.background, Color(0xFFFDF9F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const _ResearchTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: ContentShell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: compact ? 30 : 42,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Research',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 12),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 760),
                            child: Text(
                              'Research areas, active projects, and publications across Physical AI, intelligent engineering systems, control, and design.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: 22),
                          AdaptiveWrapGrid(
                            minItemWidth: compact ? 260 : 330,
                            maxColumns: 3,
                            spacing: 18,
                            children: [
                              for (final item in researchItems)
                                _ResearchCard(
                                  item: item,
                                  onOpen: () => _openItem(context, item),
                                ),
                            ],
                          ),
                          const SizedBox(height: 34),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResearchDetailPage extends StatelessWidget {
  const ResearchDetailPage({super.key, required this.item});

  final ResearchContentItem item;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [SiteColors.background, Color(0xFFFDF9F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _ResearchTopBar(title: item.title),
              Expanded(
                child: SingleChildScrollView(
                  child: ContentShell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: compact ? 28 : 42,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 860),
                          child: SiteInfoPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: compact ? 22 : 26,
                                  backgroundColor: SiteColors.surfaceMuted,
                                  child: Icon(
                                    item.icon,
                                    color: SiteColors.navy,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    SiteCategoryPill(label: item.type.label),
                                    SiteCategoryPill(label: item.meta),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  item.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontSize: compact ? 29 : 36),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  item.summary,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                if (item.details.isNotEmpty) ...[
                                  const SizedBox(height: 22),
                                  const Divider(color: SiteColors.line),
                                  const SizedBox(height: 14),
                                  for (final detail in item.details)
                                    SiteMiniBullet(label: detail),
                                ],
                                if (item.url != null) ...[
                                  const SizedBox(height: 22),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        external_link.openExternal(item.url!),
                                    icon: const Icon(Icons.open_in_new_rounded),
                                    label: const Text('Open Link'),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResearchTopBar extends StatelessWidget {
  const _ResearchTopBar({this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title ?? '$siteName Research',
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResearchCard extends StatelessWidget {
  const _ResearchCard({required this.item, required this.onOpen});

  final ResearchContentItem item;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return SiteHoverPanel(
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: SiteColors.surfaceMuted,
            child: Icon(item.icon, color: SiteColors.navy),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SiteCategoryPill(label: item.type.label),
              SiteCategoryPill(label: item.meta),
            ],
          ),
          const SizedBox(height: 16),
          Text(item.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(item.summary, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onOpen,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('View'),
            ),
          ),
        ],
      ),
    );
  }
}
