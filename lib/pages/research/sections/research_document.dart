import 'package:flutter/material.dart';

import '../../../site_theme.dart';
import '../../../utils/external_link.dart' as external_link;
import '../widgets/research_image.dart';

const _resourceColor = Color(0xFFA94731);

class ResearchDocument extends StatelessWidget {
  const ResearchDocument({super.key, required this.compact});

  final bool compact;

  static const _projects = <_ResearchArea>[
    _ResearchArea(
      title: 'Additive Manufacturing',
      subtitle:
          'Finite Element Analysis; Process-Structure-Property Modeling; '
          'In-situ Monitoring & Adaptive Control.',
      summary:
          'Our research investigates the relationships among process '
          'parameters, microstructure, and material properties, leveraging '
          'these relationships to develop process-optimization models and '
          'adaptive control policies.',
      imagePath: 'research/additive-manufacturing.svg',
      imageLabel: 'An ongoing additive manufacturing process.',
      projects: [
        _ResearchProject(
          title:
              'A Computational Process-Structure-Property Dataset of Wire Arc '
              'Additive Manufacturing (ongoing).',
        ),
        _ResearchProject(
          title:
              'A Stacked Ensemble Learning Framework for Surface Roughness '
              'Prediction in Additively Manufactured Parts (Completed).',
        ),
        _ResearchProject(
          title:
              'A Cross-Machine Transfer Learning Framework for Mechanical '
              'Property Prediction in Laser Powder Bed Fusion (Completed).',
        ),
        _ResearchProject(
          title:
              'Explainable Machine Learning for Melt-Pool Geometry Prediction '
              'and Defect-Risk Assessment in SS316L Directed Energy Deposition '
              '(Completed).',
        ),
        _ResearchProject(
          title:
              'Defect-Constrained Process Parameter Optimization for Target '
              'Mechanical Properties in Additive Manufacturing (Completed).',
        ),
      ],
    ),
    _ResearchArea(
      title: 'Physical AI',
      subtitle: 'Robotic Manipulator; Industrial Robots.',
      summary:
          'Our research in Physical AI focuses on developing embodied '
          'intelligent systems that can perceive their surroundings, reason '
          'about physical interactions, and adapt their behavior in real time.',
      imagePath: 'research/physical-ai.svg',
      imageLabel: 'A robotic manipulator picking an object.',
      projects: [
        _ResearchProject(
          title:
              'Adaptive Vision–Language–Action Policy for Robotic Manipulation '
              'Under Joint Malfunction',
        ),
      ],
    ),
    _ResearchArea(
      title: 'Indoor Environment Control',
      subtitle: 'Thermal Comfort Control; Indoor Farming.',
      summary:
          'Our research focuses on developing intelligent and adaptive control '
          'strategies for maintaining indoor thermal comfort while reducing '
          'energy consumption.',
      imagePath: 'research/thermal-comfort.svg',
      imageLabel: 'A cozy indoor environment.',
      projects: [
        _ResearchProject(
          title:
              'Sensor-Lite Model for Thermal Comfort Prediction Using '
              'Contextual Proxy Features',
          resources: [
            _ResearchResource(
              label: 'Paper',
              url:
                  'https://scholar.google.com/citations?view_op=view_citation&hl=en&user=6Xqz7xgAAAAJ&citation_for_view=6Xqz7xgAAAAJ:Tyk-4Ss8FVUC',
            ),
            _ResearchResource(
              label: 'Code',
              url:
                  'https://github.com/MdSyamul/Sensor-Lite-Model-for-Thermal-Comfort-Prediction-Using-Contextual-Proxy-Features',
            ),
          ],
        ),
      ],
    ),
    _ResearchArea(
      title: 'Generative Design',
      subtitle:
          'Airfoil Design; Microstructure Generation in Additive Manufacturing.',
      summary:
          'Our current research focuses on developing conditional generative '
          'models that produce optimized airfoil geometries for target flow '
          'regimes while satisfying specified design constraints.',
      imagePath: 'research/generative-design.svg',
      imageLabel: 'An airfoil moving through a fluid flow.',
      projects: [
        _ResearchProject(
          title:
              'Conditional Generative Inverse Design of Airfoils in the '
              'Incompressible Flow Regime',
          resources: [
            _ResearchResource(
              label: 'Paper',
              url:
                  'https://scholar.google.com/citations?view_op=view_citation&hl=en&user=6Xqz7xgAAAAJ&citation_for_view=6Xqz7xgAAAAJ:Y0pCki6q_DkC',
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = compact ? 24.0 : 54.0;

    return Container(
      key: const Key('research-content-underlay'),
      margin: EdgeInsets.fromLTRB(
        compact ? 16 : 0,
        compact ? 20 : 34,
        compact ? 16 : 0,
        compact ? 28 : 44,
      ),
      decoration: BoxDecoration(
        color: SiteColors.surface,
        borderRadius: BorderRadius.circular(compact ? 10 : 12),
        border: Border.all(color: SiteColors.line),
        boxShadow: [
          BoxShadow(
            color: SiteColors.navy.withValues(alpha: 0.06),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          compact ? 24 : 38,
          horizontalPadding,
          compact ? 38 : 54,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Research Direction',
              style: compact
                  ? Theme.of(context).textTheme.displaySmall
                  : Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                'Engineering intelligence—whether embodied or not—must remain '
                'grounded in physical reality. Our research advances intelligent '
                'engineering systems, particularly in additive manufacturing, '
                'generative design, control, and robotics. Across these fields, '
                'we seek to bridge the gap between algorithmic intelligence and '
                'engineering practice, where data are scarce, operations are '
                'safety-critical, and components degrade over time. To address '
                'these challenges, we generate simulated data and develop '
                'approaches based on transfer learning, physics-informed neural '
                'networks, and adaptive control policies.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SiteColors.textMuted,
                  fontSize: 16,
                  height: 1.7,
                ),
              ),
            ),
            SizedBox(height: compact ? 26 : 34),
            for (final project in _projects)
              _ResearchAreaView(area: project, compact: compact),
            const Divider(height: 1, color: SiteColors.line),
          ],
        ),
      ),
    );
  }
}

class _ResearchAreaView extends StatelessWidget {
  const _ResearchAreaView({required this.area, required this.compact});

  final _ResearchArea area;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final image = _ResearchImage(area: area);
    final content = _ResearchAreaContent(area: area, compact: compact);

    return Container(
      padding: EdgeInsets.symmetric(vertical: compact ? 28 : 34),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: SiteColors.line)),
      ),
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [image, const SizedBox(height: 22), content],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 8, child: image),
                const SizedBox(width: 42),
                Expanded(flex: 17, child: content),
              ],
            ),
    );
  }
}

class _ResearchImage extends StatelessWidget {
  const _ResearchImage({required this.area});

  final _ResearchArea area;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: area.imageLabel,
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: SiteColors.surfaceMuted,
            border: Border.all(color: SiteColors.line),
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: ResearchImage(
              path: area.imagePath,
              semanticsLabel: area.imageLabel,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResearchAreaContent extends StatelessWidget {
  const _ResearchAreaContent({required this.area, required this.compact});

  final _ResearchArea area;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          area.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: compact ? 24 : 28,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          area.subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: SiteColors.textMuted,
            fontSize: compact ? 14 : 14.5,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          area.summary,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: compact ? 15.5 : 16,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'CURRENT RESEARCH PROJECTS:',
          style: theme.textTheme.labelSmall?.copyWith(
            letterSpacing: 1.05,
            color: SiteColors.navy,
          ),
        ),
        const SizedBox(height: 8),
        for (final project in area.projects)
          _ResearchProjectView(project, compact: compact),
      ],
    );
  }
}

class _ResearchProjectView extends StatelessWidget {
  const _ResearchProjectView(this.project, {required this.compact});

  static final _statusPattern = RegExp(
    r'\b(?:ongoing|completed)\b',
    caseSensitive: false,
  );

  final _ResearchProject project;
  final bool compact;

  List<InlineSpan> _titleSpans() {
    final spans = <InlineSpan>[];
    var start = 0;

    for (final match in _statusPattern.allMatches(project.title)) {
      if (match.start > start) {
        spans.add(TextSpan(text: project.title.substring(start, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: const TextStyle(color: _resourceColor),
        ),
      );
      start = match.end;
    }

    if (start < project.title.length) {
      spans.add(TextSpan(text: project.title.substring(start)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1, right: 10),
            child: Text('•'),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: compact ? 15 : 15.5,
                  height: 1.6,
                ),
                children: [
                  ..._titleSpans(),
                  if (project.resources.isNotEmpty)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _ResourceLinks(project.resources),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceLinks extends StatelessWidget {
  const _ResourceLinks(this.resources);

  final List<_ResearchResource> resources;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < resources.length; index++) ...[
          if (index > 0) const SizedBox(width: 10),
          _ResourceLink(resource: resources[index]),
        ],
      ],
    );
  }
}

class _ResourceLink extends StatelessWidget {
  const _ResourceLink({required this.resource});

  final _ResearchResource resource;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: resource.label,
      child: InkWell(
        onTap: () => external_link.openExternal(resource.url),
        borderRadius: BorderRadius.circular(3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _resourceColor, width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                resource.label,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: _resourceColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResearchArea {
  const _ResearchArea({
    required this.title,
    required this.subtitle,
    required this.summary,
    required this.imagePath,
    required this.imageLabel,
    required this.projects,
  });

  final String title;
  final String subtitle;
  final String summary;
  final String imagePath;
  final String imageLabel;
  final List<_ResearchProject> projects;
}

class _ResearchProject {
  const _ResearchProject({required this.title, this.resources = const []});

  final String title;
  final List<_ResearchResource> resources;
}

class _ResearchResource {
  const _ResearchResource({required this.label, required this.url});

  final String label;
  final String url;
}
