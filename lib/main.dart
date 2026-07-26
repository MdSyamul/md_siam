import 'package:flutter/material.dart';

import 'blogs.dart';
import 'pages/blog_page.dart';
import 'sections/blog_section.dart';
import 'sections/contact_section.dart';
import 'sections/home_section.dart';
import 'sections/research_section.dart';
import 'sections/teaching_section.dart';
import 'site_content.dart';
import 'site_theme.dart';
import 'utils/external_link.dart' as external_link;
import 'widgets/site_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: siteName,
      debugShowCheckedModeBanner: false,
      theme: buildSiteTheme(),
      home: const SiteHomePage(),
      routes: {BlogPage.routeName: (context) => const BlogPage()},
    );
  }
}

enum SiteSection { home, research, teaching, blog, contact }

class SiteHomePage extends StatefulWidget {
  const SiteHomePage({super.key});

  @override
  State<SiteHomePage> createState() => _SiteHomePageState();
}

class _SiteHomePageState extends State<SiteHomePage> {
  final ScrollController _scrollController = ScrollController();

  late final Map<SiteSection, GlobalKey> _sectionKeys = {
    for (final section in SiteSection.values) section: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openUrl(String url) {
    external_link.openExternal(url);
  }

  void _scrollToSection(SiteSection section) {
    if (section == SiteSection.home) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
      return;
    }

    final sectionContext = _sectionKeys[section]?.currentContext;
    if (sectionContext == null) {
      return;
    }

    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  void _openBlog() {
    Navigator.of(context).pushNamed(BlogPage.routeName);
  }

  void _openBlogPost(BlogPost post) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => BlogPostPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 900;
    final compactNavigation = width < 1180;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [SiteColors.background, Color(0xFFFDF9F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const BackgroundDecorations(),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _TopBar(
                    compact: compactNavigation,
                    onSectionSelected: _scrollToSection,
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: !compact,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 60),
                              child: HomeSection(
                                key: _sectionKeys[SiteSection.home],
                                compact: compact,
                                onUniversityProfile: () =>
                                    _openUrl(universityProfileUrl),
                                onGoogleScholar: () =>
                                    _openUrl(googleScholarUrl),
                                onLinkedIn: () => _openUrl(linkedInUrl),
                                onGitHub: () => _openUrl(githubRepositoriesUrl),
                              ),
                            ),
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 300),
                              child: SiteSectionBlock(
                                key: _sectionKeys[SiteSection.research],
                                eyebrow: 'Research',
                                title: 'Research Areas',
                                subtitle:
                                    'Current interests guiding my academic and applied engineering work.',
                                child: ResearchSection(
                                  compact: compact,
                                  onOpenResearchProfile: () =>
                                      _openUrl(googleScholarUrl),
                                ),
                              ),
                            ),
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 460),
                              child: SiteSectionBlock(
                                key: _sectionKeys[SiteSection.teaching],
                                eyebrow: 'Teaching',
                                title: 'Courses Taught',
                                subtitle:
                                    'Core undergraduate courses taught in the Mechanical Engineering Department.',
                                child: const TeachingSection(),
                              ),
                            ),
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 540),
                              child: SiteSectionBlock(
                                key: _sectionKeys[SiteSection.blog],
                                eyebrow: 'Blog',
                                title: 'Writing',
                                subtitle: blogSectionSubtitle,
                                child: BlogSection(
                                  compact: compact,
                                  onOpenBlog: _openBlog,
                                  onOpenPost: _openBlogPost,
                                ),
                              ),
                            ),

                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 860),
                              child: ContactSection(
                                key: _sectionKeys[SiteSection.contact],
                                onEmail: () => _openUrl('mailto:$emailAddress'),
                                onPhone: () => _openUrl('tel:$phoneNumber'),
                              ),
                            ),
                            const SiteFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.compact, required this.onSectionSelected});

  final bool compact;
  final ValueChanged<SiteSection> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 18 : 28,
        vertical: compact ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        border: const Border(bottom: BorderSide(color: SiteColors.line)),
        boxShadow: [
          BoxShadow(
            color: SiteColors.navy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  siteName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: compact ? 20 : 22),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Assistant Professor, Mechanical Engineering, SUST',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: compact ? 12 : 13,
                    color: SiteColors.textMuted,
                  ),
                  maxLines: compact ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (compact)
            IconButton(
              tooltip: 'Open navigation',
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: SiteColors.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  builder: (sheetContext) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final item in _visibleNavItems)
                              ListTile(
                                title: Text(item.label),
                                onTap: () {
                                  Navigator.of(sheetContext).pop();
                                  onSectionSelected(item.section);
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.menu_rounded),
            )
          else ...[
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 6,
                runSpacing: 4,
                children: [
                  for (final item in _visibleNavItems)
                    TextButton(
                      onPressed: () => onSectionSelected(item.section),
                      child: Text(item.label),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.section);

  final String label;
  final SiteSection section;
}

const List<_NavItem> _visibleNavItems = [
  _NavItem('Home', SiteSection.home),
  _NavItem('Research', SiteSection.research),
  _NavItem('Teaching', SiteSection.teaching),
  _NavItem('Blog', SiteSection.blog),
  _NavItem('Contact', SiteSection.contact),
];

const String blogSectionSubtitle = '''
These writings are meant primarily for myself. I am simply gathering the thoughts of others that have helped me along the way. I have shared them here in the hope that they may bring guidance and comfort to anyone who needs them. If any of these thoughts resonate with you, perhaps it is because they were already yours. As Herbert Paul once wrote, "And, after all, what is originality? It is merely undetected plagiarism."
''';
