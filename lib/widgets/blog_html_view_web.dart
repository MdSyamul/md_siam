// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

import '../site_theme.dart';

class BlogHtmlView extends StatefulWidget {
  const BlogHtmlView({
    super.key,
    required this.sourceUrl,
    required this.compact,
  });

  final String sourceUrl;
  final bool compact;

  @override
  State<BlogHtmlView> createState() => _BlogHtmlViewState();
}

class _BlogHtmlViewState extends State<BlogHtmlView> {
  late final String _viewType =
      'blog-html-${widget.sourceUrl.hashCode}-${identityHashCode(this)}';
  late double _height = widget.compact ? 560 : 680;

  @override
  void initState() {
    super.initState();
    html.window.addEventListener('message', _handleMessage);
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return html.IFrameElement()
        ..src = widget.sourceUrl
        ..title = 'Blog content'
        ..style.border = '0'
        ..style.display = 'block'
        ..style.height = '100%'
        ..style.width = '100%';
    });
  }

  @override
  void dispose() {
    html.window.removeEventListener('message', _handleMessage);
    super.dispose();
  }

  void _handleMessage(html.Event event) {
    final message = event as html.MessageEvent;
    final data = message.data;
    if (data is! Map || data['type'] != 'blog-content-height') {
      return;
    }

    final height = data['height'];
    if (height is! num) {
      return;
    }

    final nextHeight = height.toDouble().clamp(360.0, 16000.0);
    if ((nextHeight - _height).abs() < 1) {
      return;
    }

    setState(() => _height = nextHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SiteColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
