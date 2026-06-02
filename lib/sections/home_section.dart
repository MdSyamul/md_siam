import 'package:flutter/material.dart';

import '../site_content.dart';
import '../site_theme.dart';
import '../widgets/site_widgets.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.compact,
    required this.onUniversityProfile,
    required this.onGoogleScholar,
    required this.onLinkedIn,
    required this.onGitHub,
  });

  final bool compact;
  final VoidCallback onUniversityProfile;
  final VoidCallback onGoogleScholar;
  final VoidCallback onLinkedIn;
  final VoidCallback onGitHub;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final veryNarrow = width < 420;
    final headingStyle = Theme.of(context).textTheme.displayLarge?.copyWith(
      fontSize: veryNarrow
          ? 34
          : compact
          ? 40
          : 58,
      color: Colors.white,
    );

    return ContentShell(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: veryNarrow ? 18 : 26),
            padding: EdgeInsets.all(
              veryNarrow
                  ? 18
                  : compact
                  ? 24
                  : 40,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(veryNarrow ? 24 : 36),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF102B3A),
                  Color(0xFF20465A),
                  Color(0xFF2E6B73),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: SiteColors.navy.withValues(alpha: 0.18),
                  blurRadius: 40,
                  offset: const Offset(0, 24),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -20,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x1FFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -70,
                  left: -30,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x14F5D6AA),
                    ),
                  ),
                ),
                compact
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroCopy(
                            headingStyle: headingStyle,
                            onUniversityProfile: onUniversityProfile,
                            onGoogleScholar: onGoogleScholar,
                            onLinkedIn: onLinkedIn,
                            onGitHub: onGitHub,
                            compact: compact,
                          ),
                          const SizedBox(height: 28),
                          const _HeroPortrait(compact: true),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _HeroCopy(
                              headingStyle: headingStyle,
                              onUniversityProfile: onUniversityProfile,
                              onGoogleScholar: onGoogleScholar,
                              onLinkedIn: onLinkedIn,
                              onGitHub: onGitHub,
                              compact: compact,
                            ),
                          ),
                          const SizedBox(width: 28),
                          const Expanded(
                            flex: 5,
                            child: _HeroPortrait(compact: false),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          const SiteSectionEndMarker(),
        ],
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.headingStyle,
    required this.onUniversityProfile,
    required this.onGoogleScholar,
    required this.onLinkedIn,
    required this.onGitHub,
    required this.compact,
  });

  final TextStyle? headingStyle;
  final VoidCallback onUniversityProfile;
  final VoidCallback onGoogleScholar;
  final VoidCallback onLinkedIn;
  final VoidCallback onGitHub;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0x1AFFFFFF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x33FFFFFF)),
          ),
          child: const Text(
            'Assistant Professor at Shahjalal University of Science and Technology',
            style: TextStyle(
              color: Color(0xFFF7E6C7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(siteName, style: headingStyle),
        // const SizedBox(height: 12),
        // Text(
        //   siteHeroStatement,
        //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        //     color: Colors.white,
        //     fontSize: compact ? 22 : 28,
        //   ),
        // ),
        const SizedBox(height: 16),
        Text(
          siteHeroSummary,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFFDCEAF0),
            fontSize: compact ? 15 : 16,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onUniversityProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0C78D),
                foregroundColor: SiteColors.navy,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.account_balance_rounded),
              label: const Text('University Profile'),
            ),
            OutlinedButton.icon(
              onPressed: onGoogleScholar,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0x55FFFFFF)),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.school_rounded),
              label: const Text('Google Scholar'),
            ),
            OutlinedButton.icon(
              onPressed: onLinkedIn,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0x55FFFFFF)),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.business_center_rounded),
              label: const Text('LinkedIn'),
            ),
            OutlinedButton.icon(
              onPressed: onGitHub,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0x55FFFFFF)),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.code_rounded),
              label: const Text('GitHub'),
            ),
          ],
        ),
        const SizedBox(height: 28),
        // AdaptiveWrapGrid(
        //   minItemWidth: compact ? 140 : 150,
        //   maxColumns: compact ? 2 : 4,
        //   spacing: 12,
        //   children: [
        //     for (final item in heroMetrics)
        //       SiteMetricCard(value: item.value, label: item.label),
        //   ],
        // ),
      ],
    );
  }
}

class _HeroPortrait extends StatelessWidget {
  const _HeroPortrait({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final veryNarrow = MediaQuery.sizeOf(context).width < 380;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            color: const Color(0x14FFFFFF),
            border: Border.all(color: const Color(0x35FFFFFF)),
          ),
          child: Semantics(
            label: 'Portrait of Md. Syamul Bashar',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: AspectRatio(
                aspectRatio: 0.92,
                child: Image.asset(
                  profileImagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: compact ? 14 : -16,
          bottom: compact ? 16 : 18,
          child: Container(
            width: compact
                ? veryNarrow
                      ? 150
                      : 170
                : 190,
            padding: EdgeInsets.all(veryNarrow ? 14 : 16),
            decoration: BoxDecoration(
              color: SiteColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: SiteColors.line),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Research Focus',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: SiteColors.cyan,
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: 10),
                SiteMiniBullet(label: 'Physical AI'),
                SiteMiniBullet(label: 'Intelligent design & manufacturing'),
                SiteMiniBullet(label: 'Control theory and system dynamics'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
