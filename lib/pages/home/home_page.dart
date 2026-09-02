import 'package:flutter/material.dart';

import '../../blogs.dart';
import '../../site_content.dart';
import '../../site_theme.dart';
import '../../utils/external_link.dart' as external_link;
import '../../widgets/site_widgets.dart';
import '../blog/blog_page.dart';
import '../blog_post/blog_post_page.dart';
import '../research/research_page.dart';
import 'sections/blog_section.dart';
import 'sections/contact_section.dart';
import 'sections/home_section.dart';
import 'sections/research_section.dart';
import 'sections/teaching_section.dart';
import 'widgets/home_top_bar.dart';

class SiteHomePage extends StatefulWidget {
  const SiteHomePage({super.key});

  @override
  State<SiteHomePage> createState() => _SiteHomePageState();
}

class _SiteHomePageState extends State<SiteHomePage> {
  final ScrollController _scrollController = ScrollController();

  late final Map<HomePageSection, GlobalKey> _sectionKeys = {
    for (final section in HomePageSection.values) section: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openUrl(String url) {
    external_link.openExternal(url);
  }

  void _scrollToSection(HomePageSection section) {
    if (section == HomePageSection.home) {
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

  void _openResearch() {
    Navigator.of(context).pushNamed(ResearchPage.routeName);
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
                  HomeTopBar(
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
                                key: _sectionKeys[HomePageSection.home],
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
                              child: ResearchSection(
                                key: _sectionKeys[HomePageSection.research],
                                compact: compact,
                                onOpenResearchPage: _openResearch,
                                onGoogleScholar: () =>
                                    _openUrl(googleScholarUrl),
                              ),
                            ),
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 460),
                              child: TeachingSection(
                                key: _sectionKeys[HomePageSection.teaching],
                              ),
                            ),
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 540),
                              child: BlogSection(
                                key: _sectionKeys[HomePageSection.blog],
                                compact: compact,
                                onOpenBlog: _openBlog,
                                onOpenPost: _openBlogPost,
                              ),
                            ),
                            SiteAnimatedReveal(
                              delay: const Duration(milliseconds: 860),
                              child: ContactSection(
                                key: _sectionKeys[HomePageSection.contact],
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
