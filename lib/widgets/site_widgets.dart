import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';

class SiteSectionBlock extends StatelessWidget {
  const SiteSectionBlock({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final narrow = width < 420;

    return ContentShell(
      child: Padding(
        padding: EdgeInsets.only(top: narrow ? 32 : 42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 1.6,
                color: SiteColors.cyan,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontSize: narrow ? 28 : null),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 24),
            child,
            const SiteSectionEndMarker(),
          ],
        ),
      ),
    );
  }
}

class SiteSectionEndMarker extends StatelessWidget {
  const SiteSectionEndMarker({super.key, this.onDark = false});

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 760;
    final lineColor = onDark
        ? Colors.white.withValues(alpha: 0.34)
        : SiteColors.line;
    return Padding(
      padding: EdgeInsets.only(top: narrow ? 26 : 34),
      child: Center(
        child: SizedBox(
          width: narrow ? 96 : 132,
          height: 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [
                  lineColor.withValues(alpha: 0),
                  lineColor,
                  lineColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SiteInfoPanel extends StatelessWidget {
  const SiteInfoPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 420;

    return Container(
      padding: EdgeInsets.all(narrow ? 18 : 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(narrow ? 20 : 28),
        border: Border.all(color: SiteColors.line),
        boxShadow: [
          BoxShadow(
            color: SiteColors.navy.withValues(alpha: 0.05),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}

class SiteHoverPanel extends StatefulWidget {
  const SiteHoverPanel({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<SiteHoverPanel> createState() => _SiteHoverPanelState();
}

class _SiteHoverPanelState extends State<SiteHoverPanel> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 420;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(narrow ? 20 : 28),
          border: Border.all(
            color: _hovering ? SiteColors.cyan : SiteColors.line,
          ),
          boxShadow: [
            BoxShadow(
              color: SiteColors.navy.withValues(alpha: _hovering ? 0.10 : 0.05),
              blurRadius: _hovering ? 32 : 22,
              offset: Offset(0, _hovering ? 18 : 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(narrow ? 20 : 28),
            onTap: widget.onTap,
            child: Padding(
              padding: EdgeInsets.all(narrow ? 18 : 24),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class SiteMetricCard extends StatelessWidget {
  const SiteMetricCard({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0x16FFFFFF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0x26FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFFDCEAF0)),
          ),
        ],
      ),
    );
  }
}

class SiteDetailList extends StatelessWidget {
  const SiteDetailList({super.key, required this.items});

  final List<DetailItem> items;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 420;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile at a glance',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 18),
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const Divider(height: 26, color: SiteColors.line),
          if (narrow)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[i].label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: SiteColors.cyan),
                ),
                const SizedBox(height: 4),
                Text(
                  items[i].value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 118,
                  child: Text(
                    items[i].label,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: SiteColors.cyan),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    items[i].value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
        ],
      ],
    );
  }
}

class SitePublicationCard extends StatelessWidget {
  const SitePublicationCard({
    super.key,
    required this.item,
    required this.onOpenLink,
  });

  final PublicationItem item;
  final ValueChanged<String> onOpenLink;

  @override
  Widget build(BuildContext context) {
    return SiteHoverPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SiteStatusBadge(label: item.status),
              SiteCategoryPill(label: item.year),
            ],
          ),
          const SizedBox(height: 16),
          Text(item.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(
            item.venue,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: SiteColors.navy,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (item.note != null) ...[
            const SizedBox(height: 10),
            Text(item.note!, style: Theme.of(context).textTheme.bodyMedium),
          ],
          if (item.url != null) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => onOpenLink(item.url!),
              icon: const Icon(Icons.open_in_new_rounded, size: 18),
              label: const Text('Open paper'),
            ),
          ],
        ],
      ),
    );
  }
}

class SiteStatusBadge extends StatelessWidget {
  const SiteStatusBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final color = switch (label) {
      'Published' => const Color(0xFF1E6C55),
      'Submitted' => const Color(0xFF8A5C12),
      'Manuscript Ready' => const Color(0xFF6B4AA1),
      _ => SiteColors.navy,
    };
    final maxWidth = math.max(120.0, MediaQuery.sizeOf(context).width - 72);

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        softWrap: true,
      ),
    );
  }
}

class SiteCategoryPill extends StatelessWidget {
  const SiteCategoryPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final maxWidth = math.max(120.0, MediaQuery.sizeOf(context).width - 72);

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: SiteColors.surfaceMuted,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: SiteColors.navy,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        softWrap: true,
      ),
    );
  }
}

class SiteSkillChip extends StatelessWidget {
  const SiteSkillChip({
    super.key,
    required this.label,
    this.emphasized = false,
  });

  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final maxWidth = math.max(128.0, MediaQuery.sizeOf(context).width - 72);

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: emphasized ? SiteColors.navy : SiteColors.surfaceMuted,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: emphasized ? Colors.white : SiteColors.navy,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        softWrap: true,
      ),
    );
  }
}

class SiteSubsectionIntro extends StatelessWidget {
  const SiteSubsectionIntro({
    super.key,
    required this.title,
    required this.caption,
  });

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(caption, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class SiteContactRow extends StatelessWidget {
  const SiteContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 420;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: narrow ? 16 : 18,
          backgroundColor: SiteColors.surfaceMuted,
          child: Icon(icon, size: narrow ? 16 : 18, color: SiteColors.navy),
        ),
        SizedBox(width: narrow ? 10 : 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: SiteColors.cyan),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: onTap,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: onTap != null
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AdaptiveWrapGrid extends StatelessWidget {
  const AdaptiveWrapGrid({
    super.key,
    required this.children,
    required this.minItemWidth,
    required this.maxColumns,
    this.spacing = 18,
  });

  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (children.isEmpty) {
          return const SizedBox.shrink();
        }

        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final estimatedColumns = ((width + spacing) / (minItemWidth + spacing))
            .floor();
        final columns = estimatedColumns.clamp(1, maxColumns);
        final visibleColumns = math.min(columns, children.length);
        final itemWidth =
            (width - (visibleColumns - 1) * spacing) / visibleColumns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

class ContentShell extends StatelessWidget {
  const ContentShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 380
        ? 14.0
        : width < 720
        ? 18.0
        : width < 1100
        ? 28.0
        : 40.0;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1240),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            0,
            horizontalPadding,
            0,
          ),
          child: child,
        ),
      ),
    );
  }
}

class SiteAnimatedReveal extends StatefulWidget {
  const SiteAnimatedReveal({
    super.key,
    required this.delay,
    required this.child,
  });

  final Duration delay;
  final Widget child;

  @override
  State<SiteAnimatedReveal> createState() => _SiteAnimatedRevealState();
}

class _SiteAnimatedRevealState extends State<SiteAnimatedReveal> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.delay, () {
      if (!mounted) {
        return;
      }
      setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : const Offset(0, 0.03),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

class BackgroundDecorations extends StatelessWidget {
  const BackgroundDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -60,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x35C88C4A), Color(0x00C88C4A)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 280,
            right: -120,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x2863A7B5), Color(0x0063A7B5)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 40,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x18B88E58), Color(0x00B88E58)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SiteMiniBullet extends StatelessWidget {
  const SiteMiniBullet({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 6, color: SiteColors.cyan),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: SiteColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 760;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SiteColors.navy.withValues(alpha: 0.06),
            SiteColors.navy.withValues(alpha: 0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SizedBox(height: narrow ? 54 : 78, width: double.infinity),
    );
  }
}
