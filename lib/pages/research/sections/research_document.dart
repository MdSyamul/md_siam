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
      title: 'Additive Manufacturing and Physics AI',
      subtitle:
          '(In-situ Monitoring & Adaptive Control; Process-Structure-Property '
          'Modeling; Finite Element Analysis.)',
      summary:
          'Our research develops data-efficient, physics-guided, and '
          'uncertainty-aware models for metal additive manufacturing using '
          'simulation, transfer learning, reduced-order modeling, and '
          'explainable machine learning. We use these models to predict '
          'melt-pool behavior, defects, surface quality, and mechanical '
          'properties, and to enable defect-constrained optimization, '
          'cross-domain transfer, digital twins, and safe adaptive control.',
      imagePath: 'research/additive-manufacturing.svg',
      imageLabel: 'An ongoing additive manufacturing process.',
      projectsHeading: 'Selected Research Projects:',
      projects: [
        _ResearchProject(
          title:
              'Bashar, M. S.* & Rahman, M. Safe Adaptive Reinforcement '
              'Learning for Defect-Constrained High-Productivity Directed '
              'Energy Deposition (Ongoing).',
          projectTitle:
              'Safe Adaptive Reinforcement Learning for Defect-Constrained '
              'High-Productivity Directed Energy Deposition',
        ),
        _ResearchProject(
          title:
              'Hadi M. J. A., & Bashar, M. S.* A Computational '
              'Process-Structure-Property Dataset of Wire Arc Additive '
              'Manufacturing (Ongoing thesis).',
          projectTitle:
              'A Computational Process-Structure-Property Dataset of Wire Arc '
              'Additive Manufacturing',
        ),
        _ResearchProject(
          title:
              'Mahbub, M., & Bashar, M. S.* A Cross-Machine Transfer Learning '
              'Framework for Mechanical Property Prediction in Laser Powder '
              'Bed Fusion (Completed as part of an ongoing thesis).',
          projectTitle:
              'A Cross-Machine Transfer Learning Framework for Mechanical '
              'Property Prediction in Laser Powder Bed Fusion',
        ),
        _ResearchProject(
          title:
              'Abir M. A. A, & Bashar, M. S.* Defect-Constrained Process '
              'Parameter Optimization for Target Mechanical Properties in '
              'Additive Manufacturing '
              '(Completed as part of an ongoing thesis).',
          projectTitle:
              'Defect-Constrained Process Parameter Optimization for Target '
              'Mechanical Properties in Additive Manufacturing',
        ),
        _ResearchProject(
          title:
              'Haque, M. R., Khalil, M. I., & Bashar, M. S.* Explainable '
              'Machine Learning for Melt-Pool Geometry Prediction and '
              'Defect-Risk Assessment in SS316L Directed Energy Deposition '
              '(Completed as part of an ongoing thesis).',
          projectTitle:
              'Explainable Machine Learning for Melt-Pool Geometry Prediction '
              'and Defect-Risk Assessment in SS316L Directed Energy Deposition',
        ),
        _ResearchProject(
          title:
              'Sabbir S. H. B., & Bashar, M. S.* A Stacked Ensemble Learning '
              'Framework for Surface Roughness Prediction in Additively '
              'Manufactured Parts (Completed as part of an ongoing thesis).',
          projectTitle:
              'A Stacked Ensemble Learning Framework for Surface Roughness '
              'Prediction in Additively Manufactured Parts',
        ),
      ],
    ),
    _ResearchArea(
      title: 'Physical AI for Manufacturing Floor',
      subtitle: '(Robotic Manipulator; Industrial Robots.)',
      summary:
          'Our research in Physical AI focuses on developing robust embodied '
          'intelligence for perception, navigation, and manipulation under '
          'uncertainty, with particular attention to environmental sensing, '
          'proprioceptive awareness, system health, and fault-adaptive control.',
      imagePath: 'research/physical-ai.svg',
      imageLabel: 'A robotic manipulator picking an object.',
      projectsHeading: 'Selected Research Projects:',
      projects: [
        _ResearchProject(
          title:
              'Raz, A.B. & Bashar, M. S.* (2027). Adaptive '
              'Vision–Language–Action Policy for Robotic Manipulation Under '
              'Joint Malfunction, International Conference on Engineering '
              'Research, Innovation and Education 2027 (ICERIE 2027), Sylhet, '
              'Bangladesh (Extended Abstract Accepted).',
          projectTitle:
              'Adaptive Vision–Language–Action Policy for Robotic Manipulation '
              'Under Joint Malfunction',
        ),
        _ResearchProject(
          title:
              'Parveen, M. L. & Bashar, M. S.* (Academic session 2019-2020). '
              'Effects of Fog and Surface Reflectivity on LiDAR-Based SLAM and '
              'Autonomous Mobile Robot Navigation '
              '(Thesis Book).',
          projectTitle:
              'Effects of Fog and Surface Reflectivity on LiDAR-Based SLAM and '
              'Autonomous Mobile Robot Navigation',
        ),
      ],
    ),
    _ResearchArea(
      title: 'Indoor Environment Control',
      subtitle: '(Thermal Comfort Control; Indoor Farming.)',
      summary:
          'Our research focuses on developing efficient sensing and adaptive '
          'control strategies for indoor environment control.',
      imagePath: 'research/thermal-comfort.svg',
      imageLabel: 'A cozy indoor environment.',
      projectsHeading: 'Selected Research Projects:',
      projects: [
        _ResearchProject(
          title:
              'Shamim, F. M., Haque, M. A., Bashar, M. S.* (2027). Deep '
              'Reinforcement Learning for Personalized Thermal Comfort Control '
              'Policy, International Conference on Engineering Research, '
              'Innovation and Education 2027 (ICERIE 2027), Sylhet, Bangladesh '
              '(Extended Abstract Accepted).',
          projectTitle:
              'Deep Reinforcement Learning for Personalized Thermal Comfort '
              'Control Policy',
        ),
        _ResearchProject(
          title:
              'Haque, M. A., Shamim, F. M., & Bashar, M. S.* (2025). '
              'Sensor-Lite Model for Thermal Comfort Prediction Using '
              'Contextual Proxy Features, 15th International Conference on '
              'Mechanical Engineering (ICME 2025), Dhaka, Bangladesh,',
          projectTitle:
              'Sensor-Lite Model for Thermal Comfort Prediction Using '
              'Contextual Proxy Features',
          resources: [
            _ResearchResource(
              label: 'Paper',
              url:
                  'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6204578',
            ),
            _ResearchResource(
              label: 'Code',
              url:
                  'https://github.com/MdSyamul/Sensor-Lite-Model-for-Thermal-Comfort-Prediction-Using-Contextual-Proxy-Features',
            ),
          ],
        ),
        _ResearchProject(
          title:
              'Haque, M. A., Asaduzzaman, M., & Bashar, M. S.* (2025). '
              'Predicting Globe Temperature: Model Development and Analysis, '
              '15th International Conference on Mechanical Engineering (ICME '
              '2025), Dhaka, Bangladesh,',
          projectTitle:
              'Predicting Globe Temperature: Model Development and Analysis',
          resources: [
            _ResearchResource(
              label: 'Paper',
              url:
                  'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6200418',
            ),
            _ResearchResource(
              label: 'Code',
              url: 'https://github.com/MdSyamul/Globe-Temperature-Prediction',
            ),
          ],
        ),
      ],
    ),
    _ResearchArea(
      title: 'Generative Design',
      subtitle: '(Airfoil Design)',
      summary:
          'Our current research develops an end-to-end framework for airfoil '
          'design, linking aerodynamic data generation, physics-guided '
          'performance prediction, and conditional generative inverse design '
          'for target flow conditions and design constraints.',
      imagePath: 'research/generative-design.svg',
      imageLabel: 'An airfoil moving through a fluid flow.',
      projectsHeading: 'Selected Research Projects (Airfoil Design):',
      projects: [
        _ResearchProject(
          title:
              'Samin, A. A., & Bashar, M. S.* (2026). Conditional Generative '
              'Inverse Design of Airfoils in the Incompressible Flow Regime, '
              'International Conference on Emerging Frontiers in Advanced '
              'Sciences and Technologies 2026 (EFAST 2026), Pabna, Bangladesh.',
          projectTitle:
              'Conditional Generative Inverse Design of Airfoils in the '
              'Incompressible Flow Regime',
        ),
        _ResearchProject(
          title:
              'Samin, A. A., Zihan, S. W., & Bashar, M. S.* (2026). '
              'Physics-Guided Surrogate Modeling for Airfoils’ Aerodynamic '
              'Performance in Incompressible Flow Regime, International '
              'Conference on Engineering and Frontier Technologies 2026 '
              '(ICEFronT 2026), Tangail, Bangladesh (Accepted).',
          projectTitle:
              'Physics-Guided Surrogate Modeling for Airfoils’ Aerodynamic '
              'Performance in Incompressible Flow Regime',
        ),
        _ResearchProject(
          title:
              'Zihan, S. W., & Bashar, M. S.* (Academic session 2019-20). A '
              'Comprehensive Dataset for NACA 4-digit Airfoils’ Aerodynamics in '
              'Incompressible Flow Regime (Thesis Book).',
          projectTitle:
              'A Comprehensive Dataset for NACA 4-digit Airfoils’ Aerodynamics '
              'in Incompressible Flow Regime',
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
              'Research Directions',
              style: compact
                  ? Theme.of(context).textTheme.displaySmall
                  : Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                'Engineering intelligence—whether embodied or not—must '
                'incorporate physical principles, account for uncertainty, and '
                'operate within the constraints of real engineering systems. '
                'Our research advances intelligent systems across additive '
                'manufacturing, generative design, control, and robotics by '
                'addressing key real-world challenges: limited data, '
                'safety-critical operation, and physical systems that degrade '
                'and evolve over time.',
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
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          area.subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: SiteColors.textMuted,
            fontSize: compact ? 14 : 14.5,
            fontWeight: FontWeight.w500,
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
          area.projectsHeading,
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

  static final _accentPattern = RegExp(
    r'\b(?:Completed|Ongoing|Accepted)\b|\bThesis Book\b',
  );

  final _ResearchProject project;
  final bool compact;

  List<InlineSpan> _titleSpans() {
    final styledRanges = <_StyledTextRange>[];
    final projectTitleStart = project.title.indexOf(project.projectTitle);

    if (projectTitleStart >= 0) {
      styledRanges.add(
        _StyledTextRange(
          start: projectTitleStart,
          end: projectTitleStart + project.projectTitle.length,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      );
    }

    for (final match in _accentPattern.allMatches(project.title)) {
      styledRanges.add(
        _StyledTextRange(
          start: match.start,
          end: match.end,
          style: const TextStyle(color: _resourceColor),
        ),
      );
    }

    styledRanges.sort((first, second) => first.start.compareTo(second.start));
    final spans = <InlineSpan>[];
    var start = 0;

    for (final range in styledRanges) {
      if (range.start > start) {
        spans.add(TextSpan(text: project.title.substring(start, range.start)));
      }
      spans.add(
        TextSpan(
          text: project.title.substring(range.start, range.end),
          style: range.style,
        ),
      );
      start = range.end;
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
    required this.projectsHeading,
    required this.projects,
  });

  final String title;
  final String subtitle;
  final String summary;
  final String imagePath;
  final String imageLabel;
  final String projectsHeading;
  final List<_ResearchProject> projects;
}

class _ResearchProject {
  const _ResearchProject({
    required this.title,
    required this.projectTitle,
    this.resources = const [],
  });

  final String title;
  final String projectTitle;
  final List<_ResearchResource> resources;
}

class _StyledTextRange {
  const _StyledTextRange({
    required this.start,
    required this.end,
    required this.style,
  });

  final int start;
  final int end;
  final TextStyle style;
}

class _ResearchResource {
  const _ResearchResource({required this.label, required this.url});

  final String label;
  final String url;
}
