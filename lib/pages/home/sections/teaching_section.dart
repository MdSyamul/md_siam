import 'package:flutter/material.dart';

import '../../../widgets/site_widgets.dart';

class TeachingSection extends StatelessWidget {
  const TeachingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      for (final course in _teachingCourses) (title: course, emphasized: true),
      for (final course in _additionalTeachingCourses)
        (title: course, emphasized: false),
    ];

    return SiteSectionBlock(
      eyebrow: 'Teaching',
      title: 'Courses Taught',
      subtitle: 'Core undergraduate courses taught.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final course in courses)
                  SiteSkillChip(
                    label: course.title,
                    emphasized: course.emphasized,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _teachingCourses = [
  'Control Engineering',
  'Numerical Analysis',
  'Fluid Mechanics',
  'Basic Thermodynamics',
];

const List<String> _additionalTeachingCourses = [
  'Programming Methodology',
  'Applied Statistics for Engineers',
];
