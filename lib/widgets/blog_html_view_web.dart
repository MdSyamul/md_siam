// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
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
    required this.initialHeight,
  });

  final String sourceUrl;
  final String subtitle;
  final bool compact;
  final double initialHeight;

  @override
  State<BlogHtmlView> createState() => _BlogHtmlViewState();
}

class _BlogHtmlViewState extends State<BlogHtmlView> {
  late final String _viewType =
      'blog-html-${widget.sourceUrl.hashCode}-${identityHashCode(this)}';
  late double _height = widget.initialHeight;
  html.IFrameElement? _iframe;
  Timer? _heightPoller;
  StreamSubscription<html.Event>? _windowResizeSubscription;

  @override
  void initState() {
    super.initState();
    _windowResizeSubscription = html.window.onResize.listen((_) {
      _startHeightPolling();
    });
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = html.IFrameElement()
        ..title = 'Blog content'
        ..setAttribute('scrolling', 'no')
        ..style.border = '0'
        ..style.display = 'block'
        ..style.height = '100%'
        ..style.overflow = 'hidden'
        ..style.pointerEvents = 'none'
        ..style.width = '100%';
      iframe.onLoad.listen((_) => _handleIframeLoad());
      _iframe = iframe;
      iframe.src = widget.sourceUrl;
      Timer.run(_startHeightPolling);
      return iframe;
    });
  }

  @override
  void dispose() {
    _heightPoller?.cancel();
    _windowResizeSubscription?.cancel();
    super.dispose();
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

    _startHeightPolling();
  }

  void _startHeightPolling() {
    _heightPoller?.cancel();
    var ticks = 0;
    _updateHeightFromFrame();
    _heightPoller = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      ticks++;
      _updateHeightFromFrame();
      if (ticks >= 60) {
        timer.cancel();
      }
    });
  }

  void _updateHeightFromFrame() {
    final iframe = _iframe;
    if (iframe == null || !mounted) {
      return;
    }

    try {
      final document = (iframe as dynamic).contentDocument;
      final body = document?.body;
      final root = document?.documentElement;
      final height =
          [
            body?.scrollHeight,
            body?.offsetHeight,
            root?.scrollHeight,
            root?.offsetHeight,
          ].whereType<num>().fold<double>(0, (current, next) {
            return next > current ? next.toDouble() : current;
          });

      final measuredHeight = height.ceilToDouble();
      if (measuredHeight > 0 && (measuredHeight - _height).abs() >= 1) {
        setState(() => _height = measuredHeight);
      }
    } catch (_) {
      // Keep the initial height if document measurement is unavailable.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
        color: SiteColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SiteColors.line),
      ),
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
