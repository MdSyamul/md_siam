import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:md_siam/blogs.dart';
import 'package:md_siam/main.dart';
import 'package:md_siam/pages/research/sections/research_document.dart';
import 'package:md_siam/site_theme.dart';

void main() {
  test('productivity post includes a cover image', () {
    expect(blogPosts.first.coverImageUrl, 'blogs/productivity/cover.png');
  });

  testWidgets('personal website renders core sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Md. Syamul Bashar'), findsWidgets);
    expect(find.text('Research Areas'), findsOneWidget);
    expect(find.text('View all research'), findsOneWidget);
    expect(find.text('Intelligent Design and Manufacturing'), findsNothing);
    expect(find.text('Courses Taught'), findsOneWidget);
    expect(find.text('Writing'), findsOneWidget);
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(find.text('University Profile'), findsOneWidget);
    expect(find.text('Google Scholar'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsWidgets);
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
    expect(find.text('Additive Manufacturing'), findsOneWidget);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -1800),
    );
    await tester.pumpAndSettle();

    expect(find.text('Generative Design'), findsOneWidget);
    expect(find.text('Paper'), findsWidgets);
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

      final title = tester.widget<Text>(find.text('Research Direction'));
      final subtitle = tester.widget<Text>(
        find.text('Robotic Manipulator; Industrial Robots.'),
      );

      expect(title.style?.fontSize, compact ? 34 : 42);
      expect(subtitle.style?.fontSize, compact ? 14 : 14.5);
      expect(subtitle.style?.fontStyle, FontStyle.italic);
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
    expect(find.text('Productivity'), findsWidgets);
    expect(find.text('Personal Growth'), findsWidgets);

    final readButton = find.text('Read').first;
    await tester.ensureVisible(readButton);
    await tester.tap(readButton);
    await tester.pumpAndSettle();

    expect(find.text('Productivity'), findsWidgets);
    expect(find.byTooltip('Back'), findsOneWidget);
  });

  testWidgets('homepage blog section presents featured writing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    await tester.ensureVisible(find.text('Browse all writing'));
    await tester.pumpAndSettle();

    expect(find.text('Visit Blog'), findsNothing);
    expect(find.text('Begin gently, then build.'), findsWidgets);
    expect(find.text('Personal Growth'), findsWidgets);
    expect(find.text('Browse all writing'), findsOneWidget);
    expect(find.text('Productivity'), findsWidgets);
    expect(find.text('Existing'), findsNothing);
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
