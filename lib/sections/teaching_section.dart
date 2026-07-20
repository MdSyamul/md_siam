import 'package:flutter/material.dart';

import '../site_content.dart';
import '../widgets/site_widgets.dart';

class TeachingSection extends StatelessWidget {
  const TeachingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      for (final course in teachingCourses) (title: course, emphasized: true),
      for (final course in additionalTeachingCourses)
        (title: course, emphasized: false),
    ];

    return Column(
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
    );
  }
}
