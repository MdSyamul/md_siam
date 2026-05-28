import 'package:flutter/material.dart';

import '../site_content.dart';
import '../widgets/site_widgets.dart';

class PublicationsSection extends StatelessWidget {
  const PublicationsSection({
    super.key,
    required this.compact,
    required this.onOpenLink,
  });

  final bool compact;
  final ValueChanged<String> onOpenLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SiteSubsectionIntro(
          title: 'Journal Publications',
          caption: 'Peer-reviewed journal work currently visible from your CV.',
        ),
        const SizedBox(height: 18),
        AdaptiveWrapGrid(
          minItemWidth: compact ? 240 : 360,
          maxColumns: compact ? 1 : 2,
          spacing: 18,
          children: [
            for (final item in journalPublications)
              SitePublicationCard(item: item, onOpenLink: onOpenLink),
          ],
        ),
        const SizedBox(height: 30),
        const SiteSubsectionIntro(
          title: 'Conference and Recent Work',
          caption:
              'Conference publications together with accepted, submitted, and manuscript-ready work.',
        ),
        const SizedBox(height: 18),
        AdaptiveWrapGrid(
          minItemWidth: compact ? 240 : 360,
          maxColumns: compact ? 1 : 2,
          spacing: 18,
          children: [
            for (final item in conferencePublications)
              SitePublicationCard(item: item, onOpenLink: onOpenLink),
          ],
        ),
      ],
    );
  }
}
