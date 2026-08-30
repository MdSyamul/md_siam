import 'package:flutter/material.dart';

import '../../site_theme.dart';
import '../../widgets/site_widgets.dart';
import 'sections/research_document.dart';
import 'widgets/research_top_bar.dart';

class ResearchPage extends StatefulWidget {
  const ResearchPage({super.key});

  static const routeName = '/research';

  @override
  State<ResearchPage> createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 760;

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
                  const ResearchTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: compact
                          ? ResearchDocument(compact: true)
                          : ContentShell(
                              child: ResearchDocument(compact: false),
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
