import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:md_siam/blogs.dart';
import 'package:md_siam/main.dart';
import 'package:md_siam/pages/blog/blog_page.dart';
import 'package:md_siam/pages/blog/widgets/blog_post_card.dart';
import 'package:md_siam/pages/home/sections/contact_section.dart';
import 'package:md_siam/pages/home/sections/research_section.dart';
import 'package:md_siam/pages/research/sections/research_document.dart';
import 'package:md_siam/site_content.dart';
import 'package:md_siam/site_theme.dart';

void main() {
  test('first blog post includes a cover image', () {
    expect(blogPosts.first.coverImageUrl, 'blogs/the-self-is-old/cover.jpg');
  });

  testWidgets('personal website renders core sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Md. Syamul Bashar'), findsWidgets);
    expect(find.text('Research Focus'), findsNothing);
    expect(find.text('Research Areas'), findsOneWidget);
    expect(find.text('Explore research directions'), findsOneWidget);
    expect(find.text('Intelligent Design and Manufacturing'), findsNothing);
    expect(find.text('Courses Taught'), findsOneWidget);
    expect(find.text('Writing'), findsOneWidget);
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(find.text('University Profile'), findsOneWidget);
    expect(find.text('Google Scholar'), findsNWidgets(2));
    expect(
      find.byKey(const Key('research-google-scholar-button')),
      findsOneWidget,
    );
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsWidgets);
  });

  testWidgets('research section Google Scholar button uses its callback', (
    WidgetTester tester,
  ) async {
    var scholarOpenCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ResearchSection(
              compact: true,
              onOpenResearchPage: _noop,
              onGoogleScholar: () => scholarOpenCount++,
            ),
          ),
        ),
      ),
    );

    final scholarButton = find.byKey(
      const Key('research-google-scholar-button'),
    );
    await tester.ensureVisible(scholarButton);
    await tester.tap(scholarButton);

    expect(scholarOpenCount, 1);
  });

  testWidgets('contact details are selectable and copyable', (
    WidgetTester tester,
  ) async {
    final copiedValues = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          final arguments = call.arguments as Map<Object?, Object?>;
          copiedValues.add(arguments['text']! as String);
        }
        return null;
      },
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ContactSection(onEmail: _noop, onPhone: _noop),
          ),
        ),
      ),
    );

    expect(find.byType(SelectableText), findsNWidgets(3));

    for (final label in ['Email', 'WhatsApp', 'Address']) {
      final copyButton = find.byKey(ValueKey<String>('copy-$label'));
      await tester.ensureVisible(copyButton);
      await tester.tap(copyButton);
      await tester.pump();
    }

    expect(copiedValues, [emailAddress, phoneNumber, departmentAddress]);
  });

  testWidgets('research section opens the research page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    await tester.ensureVisible(find.text('Explore research directions'));
    await tester.tap(find.text('Explore research directions'));
    await tester.pumpAndSettle();

    expect(find.text('Md. Syamul Bashar'), findsOneWidget);
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.byKey(const Key('research-content-underlay')), findsOneWidget);
    expect(find.text('Additive Manufacturing and Physics AI'), findsOneWidget);
    expect(find.text('Selected Research Projects:'), findsNWidgets(3));
    expect(
      find.textContaining('Sabbir S. H. B., & Bashar, M. S.*'),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'Interpretable and Physics-Guided Reduced-Order Modeling',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'robust embodied intelligence for perception, navigation, and '
        'manipulation under uncertainty',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining('Effects of Fog and Surface Reflectivity'),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.text('Generative Design'),
      600,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle();

    expect(find.text('Generative Design'), findsOneWidget);
    expect(
      find.text('Selected Research Projects (Airfoil Design):'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Predicting Globe Temperature: Model Development'),
      findsOneWidget,
    );
    expect(
      find.textContaining('A Comprehensive Dataset for NACA 4-digit Airfoils'),
      findsOneWidget,
    );
    expect(find.text('(Airfoil Design)'), findsOneWidget);
    expect(
      find.textContaining(
        'end-to-end framework for airfoil design, linking aerodynamic data',
      ),
      findsOneWidget,
    );
    expect(find.text('Paper'), findsNWidgets(2));
    expect(find.text('Code'), findsNWidgets(2));
  });

  testWidgets('research typography remains readable across viewports', (
    WidgetTester tester,
  ) async {
    final view = tester.view;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });

    const viewports = [ui.Size(390, 844), ui.Size(1024, 768)];

    for (final viewport in viewports) {
      view.physicalSize = viewport;
      view.devicePixelRatio = 1;
      final compact = viewport.width < 760;

      await tester.pumpWidget(
        MaterialApp(
          theme: buildSiteTheme(),
          home: MediaQuery(
            data: MediaQueryData(
              size: viewport,
              textScaler: const TextScaler.linear(1.3),
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                child: ResearchDocument(compact: compact),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final title = tester.widget<Text>(find.text('Research Directions'));
      final subtitle = tester.widget<Text>(
        find.text('(Robotic Manipulator; Industrial Robots.)'),
      );

      expect(title.style?.fontSize, compact ? 34 : 42);
      expect(subtitle.style?.fontSize, compact ? 14 : 14.5);
      expect(subtitle.style?.color, SiteColors.textMuted);
      expect(subtitle.style?.fontWeight, FontWeight.w500);
      expect(subtitle.style?.fontStyle, FontStyle.italic);

      final firstProject = tester.widget<Text>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.textSpan?.toPlainText().contains(
                    'A Stacked Ensemble Learning Framework',
                  ) ??
                  false),
        ),
      );
      final projectSpans = (firstProject.textSpan! as TextSpan).children!;
      final boldProjectTitle = projectSpans.whereType<TextSpan>().firstWhere(
        (span) => span.text?.startsWith('A Stacked Ensemble Learning') ?? false,
      );

      expect(boldProjectTitle.style?.fontWeight, FontWeight.w700);
      expect(
        projectSpans.whereType<TextSpan>().where(
          (span) =>
              span.text == 'Completed' &&
              span.style?.color == const Color(0xFFA94731),
        ),
        hasLength(1),
      );
      expect(
        projectSpans.whereType<TextSpan>().where(
          (span) =>
              span.text == 'ongoing' &&
              span.style?.color == const Color(0xFFA94731),
        ),
        isEmpty,
      );
      final accentTexts = tester
          .widgetList<Text>(find.byType(Text))
          .expand<InlineSpan>((text) {
            final span = text.textSpan;
            return span is TextSpan ? span.children ?? const [] : const [];
          })
          .whereType<TextSpan>()
          .where((span) => span.style?.color == const Color(0xFFA94731))
          .map((span) => span.text)
          .toSet();
      expect(
        accentTexts,
        containsAll(<String>[
          'Completed',
          'Ongoing',
          'Accepted',
          'Thesis Book',
        ]),
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('blog section opens the blog page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    await tester.ensureVisible(find.text('Browse all writing'));
    await tester.tap(find.text('Browse all writing'));
    await tester.pumpAndSettle();

    expect(find.text('Md. Syamul Bashar'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text('Quiet Ruin of the Self'), findsWidgets);
    expect(find.text('Philosophy'), findsWidgets);

    final readButton = find.text('Read').first;
    await tester.ensureVisible(readButton);
    await tester.tap(readButton);
    await tester.pumpAndSettle();

    expect(find.text('Quiet Ruin of the Self'), findsWidgets);
    expect(find.byTooltip('Back'), findsOneWidget);
  });

  testWidgets('blog listing adapts across mobile, tablet, and desktop widths', (
    WidgetTester tester,
  ) async {
    final view = tester.view;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });

    const viewports = [
      ui.Size(280, 653),
      ui.Size(320, 700),
      ui.Size(390, 844),
      ui.Size(768, 1024),
      ui.Size(1024, 768),
      ui.Size(1440, 900),
    ];

    for (final viewport in viewports) {
      view.physicalSize = viewport;
      view.devicePixelRatio = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: buildSiteTheme(),
          home: MediaQuery(
            data: MediaQueryData(
              size: viewport,
              textScaler: const TextScaler.linear(1.3),
            ),
            child: const BlogPage(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));

      final cards = find.byType(BlogPostCard);
      expect(cards, findsNWidgets(blogPosts.length));
      for (final card in cards.evaluate()) {
        final size = tester.getSize(find.byWidget(card.widget));
        expect(size.width, lessThanOrEqualTo(420.1));
        expect(size.width, lessThanOrEqualTo(viewport.width));
      }
      expect(
        tester.takeException(),
        isNull,
        reason:
            'Blog listing should not overflow at '
            '${viewport.width}x${viewport.height}.',
      );

      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -600),
      );
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason:
            'Scrolled blog listing should remain stable at '
            '${viewport.width}x${viewport.height}.',
      );
    }
  });

  testWidgets('homepage blog section presents featured writing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    await tester.ensureVisible(find.text('Browse all writing'));
    await tester.pumpAndSettle();

    expect(find.text('Visit Blog'), findsNothing);
    expect(
      find.text('The self is old - older than the universe.'),
      findsWidgets,
    );
    expect(find.text('Philosophy'), findsWidgets);
    expect(find.text('Browse all writing'), findsOneWidget);
    expect(find.text('Quiet Ruin of the Self'), findsWidgets);
    expect(find.text('Existing'), findsWidgets);
    expect(find.text('Physical AI for Mechanical Engineering'), findsNothing);
  });

  testWidgets('personal website adapts across common viewport sizes', (
    WidgetTester tester,
  ) async {
    final view = tester.view;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });

    const viewports = [
      ui.Size(320, 700),
      ui.Size(390, 844),
      ui.Size(768, 1024),
      ui.Size(1024, 768),
      ui.Size(1440, 900),
    ];

    for (final viewport in viewports) {
      view.physicalSize = viewport;
      view.devicePixelRatio = 1;

      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(milliseconds: 900));

      expect(
        tester.takeException(),
        isNull,
        reason:
            'Initial layout should not overflow at '
            '${viewport.width}x${viewport.height}.',
      );

      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -900),
      );
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason:
            'Scrolled layout should not overflow at '
            '${viewport.width}x${viewport.height}.',
      );
    }
  });
}

void _noop() {}
