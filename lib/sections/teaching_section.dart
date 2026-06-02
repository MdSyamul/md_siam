import 'package:flutter/material.dart';

import '../site_content.dart';
import '../widgets/site_widgets.dart';

class TeachingSection extends StatelessWidget {
  const TeachingSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrapGrid(
      minItemWidth: compact ? 240 : 320,
      maxColumns: compact ? 1 : 2,
      spacing: 18,
      children: [
        SiteInfoPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Core Courses',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              // Text(
              //   'Courses explicitly confirmed in your CV.',
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final course in teachingCourses)
                    SiteSkillChip(label: course, emphasized: true),
                ],
              ),
            ],
          ),
        ),
        SiteInfoPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Extended Teaching Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              // Text(
              //   'Additional teaching areas from your university profile that can be highlighted as needed.',
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final course in additionalTeachingCourses)
                    SiteSkillChip(label: course),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
