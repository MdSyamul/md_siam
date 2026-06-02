import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:md_siam/main.dart';

void main() {
  testWidgets('personal website renders core sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Md. Syamul Bashar'), findsWidgets);
    expect(find.text('Research Areas'), findsOneWidget);
    expect(find.text('View Scholar Profile'), findsOneWidget);
    expect(find.text('Intelligent Design and Manufacturing'), findsNothing);
    expect(find.text('Courses Taught'), findsOneWidget);
    expect(find.text('Writing'), findsOneWidget);
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(find.text('University Profile'), findsOneWidget);
    expect(find.text('Google Scholar'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsWidgets);
  });

  testWidgets('blog section opens the blog page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    await tester.ensureVisible(find.text('Visit Blog'));
    await tester.tap(find.text('Visit Blog'));
    await tester.pumpAndSettle();

    expect(find.text('Md. Syamul Bashar Blog'), findsOneWidget);
    expect(find.text('Search posts'), findsOneWidget);
    expect(find.text('Physical AI for Mechanical Engineering'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'thermal');
    await tester.pumpAndSettle();

    expect(
      find.text('Why Sensor-Lite Thermal Comfort Models Matter'),
      findsOneWidget,
    );
    expect(
      find.text('Teaching Control Concepts with Simulation'),
      findsNothing,
    );

    final readButton = find.text('Read').first;
    await tester.ensureVisible(readButton);
    await tester.tap(readButton);
    await tester.pumpAndSettle();

    expect(
      find.textContaining(
        'Thermal comfort prediction often depends on measurements that are difficult to collect continuously in ordinary buildings.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('homepage blog section uses original visit action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 900));

    await tester.ensureVisible(find.text('Visit Blog'));
    await tester.pumpAndSettle();

    expect(find.text('Visit Blog'), findsOneWidget);
    expect(
      find.text(
        'Brief reflections for students and collaborators on how research ideas connect with teaching practice and engineering judgment.',
      ),
      findsWidgets,
    );
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
