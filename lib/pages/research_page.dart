import 'package:flutter/material.dart';

import '../research_content.dart';
import '../site_content.dart';
import '../site_theme.dart';
import '../utils/external_link.dart' as external_link;
import '../widgets/site_widgets.dart';

class ResearchPage extends StatefulWidget {
  const ResearchPage({super.key});

  static const routeName = '/research';

  @override
  State<ResearchPage> createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  ResearchContentType? _selectedType;

  List<ResearchContentItem> get _filteredItems {
    final normalizedQuery = _query.trim().toLowerCase();

    return researchItems.where((item) {
      final matchesType =
          _selectedType == null || item.type.id == _selectedType!.id;
      final matchesSearch =
          normalizedQuery.isEmpty ||
          item.searchableText.contains(normalizedQuery);

      return matchesType && matchesSearch;
    }).toList();
  }

  void _openItem(ResearchContentItem item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ResearchDetailPage(item: item)),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;
    final filteredItems = _filteredItems;

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
                          const SizedBox(height: 24),
                          _ResearchFilters(
                            controller: _searchController,
                            query: _query,
                            selectedType: _selectedType,
                            onQueryChanged: (value) {
                              setState(() => _query = value);
                            },
                            onTypeChanged: (value) {
                              setState(() => _selectedType = value);
                            },
                          ),
                          const SizedBox(height: 22),
                          if (filteredItems.isEmpty)
                            const SiteInfoPanel(child: _NoResearchFound())
                          else
                            AdaptiveWrapGrid(
                              minItemWidth: compact ? 260 : 330,
                              maxColumns: 3,
                              spacing: 18,
                              children: [
                                for (final item in filteredItems)
                                  _ResearchCard(
                                    item: item,
                                    onOpen: () => _openItem(item),
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

class _ResearchFilters extends StatelessWidget {
  const _ResearchFilters({
    required this.controller,
    required this.query,
    required this.selectedType,
    required this.onQueryChanged,
    required this.onTypeChanged,
  });

  final TextEditingController controller;
  final String query;
  final ResearchContentType? selectedType;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<ResearchContentType?> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 620;

    return SiteInfoPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            onChanged: onQueryChanged,
            decoration: InputDecoration(
              hintText: 'Search research',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear search',
                      onPressed: () {
                        controller.clear();
                        onQueryChanged('');
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: SiteColors.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: SiteColors.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: SiteColors.cyan, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: selectedType == null,
                onSelected: (_) => onTypeChanged(null),
                avatar: compact ? null : const Icon(Icons.apps_rounded),
              ),
              for (final type in researchTypes)
                ChoiceChip(
                  label: Text(type.label),
                  selected: selectedType?.id == type.id,
                  onSelected: (_) => onTypeChanged(type),
                  avatar: compact ? null : Icon(type.icon),
                ),
            ],
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

class _NoResearchFound extends StatelessWidget {
  const _NoResearchFound();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: SiteColors.surfaceMuted,
          child: Icon(
            Icons.search_off_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No research items found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Try a different keyword or research type.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
