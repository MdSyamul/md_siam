import 'package:flutter/material.dart';

import '../site_content.dart';
import '../widgets/site_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.compact,
    required this.onEmail,
    required this.onPhone,
    required this.onGitHub,
    required this.onCv,
  });

  final bool compact;
  final VoidCallback onEmail;
  final VoidCallback onPhone;
  final VoidCallback onGitHub;
  final VoidCallback onCv;

  @override
  Widget build(BuildContext context) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Open to student guidance, academic collaboration, and research conversations.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 14),
        Text(
          'This first web version focuses on clarity: direct contact routes, a downloadable CV, and a structured overview of research and teaching.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onEmail,
              icon: const Icon(Icons.email_outlined),
              label: const Text('Email'),
            ),
            OutlinedButton.icon(
              onPressed: onGitHub,
              icon: const Icon(Icons.code_rounded),
              label: const Text('GitHub'),
            ),
            OutlinedButton.icon(
              onPressed: onCv,
              icon: const Icon(Icons.download_rounded),
              label: const Text('Download CV'),
            ),
          ],
        ),
      ],
    );

    final details = SiteInfoPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 18),
          SiteContactRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: emailAddress,
            onTap: onEmail,
          ),
          const SizedBox(height: 14),
          SiteContactRow(
            icon: Icons.call_outlined,
            label: 'Phone',
            value: phoneNumber,
            onTap: onPhone,
          ),
          const SizedBox(height: 14),
          const SiteContactRow(
            icon: Icons.location_on_outlined,
            label: 'Address',
            value: departmentAddress,
          ),
          const SizedBox(height: 14),
          // SiteContactRow(
          //   icon: Icons.public_rounded,
          //   label: 'GitHub',
          //   value: githubUrl,
          //   onTap: onGitHub,
          // ),
        ],
      ),
    );

    if (compact) {
      return Column(
        children: [
          SiteInfoPanel(child: intro),
          const SizedBox(height: 20),
          details,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: SiteInfoPanel(child: intro)),
        const SizedBox(width: 20),
        Expanded(flex: 4, child: details),
      ],
    );
  }
}
