import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.onEmail,
    required this.onPhone,
  });

  final VoidCallback onEmail;
  final VoidCallback onPhone;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final narrow = width < 760;

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SiteContactRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: emailAddress,
          onTap: onEmail,
        ),
        const SizedBox(height: 18),
        SiteContactRow(
          icon: Icons.call_outlined,
          label: 'Phone',
          value: phoneNumber,
          onTap: onPhone,
        ),
        const SizedBox(height: 18),
        const SiteContactRow(
          icon: Icons.location_on_outlined,
          label: 'Address',
          value: departmentAddress,
        ),
      ],
    );

    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: SiteColors.cyan,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Get in Touch',
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontSize: narrow ? 30 : null),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'Contact routes for students, collaborators, and academic partners.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );

    final detailPanel = DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.64),
        borderRadius: BorderRadius.circular(narrow ? 18 : 24),
        border: Border.all(color: SiteColors.line),
      ),
      child: Padding(padding: EdgeInsets.all(narrow ? 18 : 22), child: details),
    );

    final bandColor = SiteColors.navy.withValues(alpha: 0.06);

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [SiteColors.navy.withValues(alpha: 0), bandColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox(height: narrow ? 32 : 42, width: double.infinity),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            0,
            narrow ? 24 : 32,
            0,
            narrow ? 36 : 48,
          ),
          decoration: BoxDecoration(color: bandColor),
          child: ContentShell(
            child: Column(
              children: [
                narrow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heading,
                          const SizedBox(height: 28),
                          detailPanel,
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 5, child: heading),
                          const SizedBox(width: 56),
                          Expanded(flex: 4, child: detailPanel),
                        ],
                      ),
                const SiteSectionEndMarker(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
