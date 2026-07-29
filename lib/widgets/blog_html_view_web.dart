// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

import '../site_theme.dart';

class BlogHtmlView extends StatefulWidget {
  const BlogHtmlView({
    super.key,
    required this.sourceUrl,
    required this.subtitle,
    required this.compact,
  });

  final String sourceUrl;
  final String subtitle;
  final bool compact;

  @override
  State<BlogHtmlView> createState() => _BlogHtmlViewState();
}

class _BlogHtmlViewState extends State<BlogHtmlView> {
  late final String _viewType =
      'blog-html-${widget.sourceUrl.hashCode}-${identityHashCode(this)}';
  html.IFrameElement? _iframe;

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = html.IFrameElement()
        ..title = 'Blog content'
        ..setAttribute('scrolling', 'yes')
        ..style.border = '0'
        ..style.display = 'block'
        ..style.height = '100%'
        ..style.overflow = 'auto'
        ..style.width = '100%';
      iframe.style.setProperty('-webkit-overflow-scrolling', 'touch');
      iframe.style.setProperty('touch-action', 'pan-y');
      iframe.onLoad.listen((_) => _handleIframeLoad());
      _iframe = iframe;
      iframe.src = widget.sourceUrl;
      return iframe;
    });
  }

  void _handleIframeLoad() {
    final iframe = _iframe;
    if (iframe == null || !mounted) {
      return;
    }

    try {
      final document = (iframe as dynamic).contentDocument;
      final location = document?.location?.href as String?;
      if (location == null || location == 'about:blank') {
        return;
      }

      final subtitleElement = document?.querySelector('.subtitle');
      if (subtitleElement != null) {
        subtitleElement.text = widget.subtitle;
      }
    } catch (_) {
      // The article still remains usable if a browser prevents document access.
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewportHeight = MediaQuery.sizeOf(context).height;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: double.infinity,
      height: (viewportHeight - (widget.compact ? 112 : 150)).clamp(
        420.0,
        900.0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: SiteColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SiteColors.line),
      ),
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
