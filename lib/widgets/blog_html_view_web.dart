// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
import 'dart:convert';
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
    this.onScroll,
  });

  final String sourceUrl;
  final String subtitle;
  final bool compact;
  final ValueChanged<double>? onScroll;

  @override
  State<BlogHtmlView> createState() => _BlogHtmlViewState();
}

class _BlogHtmlViewState extends State<BlogHtmlView> {
  late final String _viewType =
      'blog-html-${widget.sourceUrl.hashCode}-${identityHashCode(this)}';
  late final String _resizeToken =
      'blog-html-resize-${widget.sourceUrl.hashCode}-${identityHashCode(this)}';
  late double _height = widget.compact ? 2200 : 2600;
  html.IFrameElement? _iframe;
  Timer? _heightPoller;

  @override
  void initState() {
    super.initState();
    html.window.addEventListener('message', _handleMessage);
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = html.IFrameElement()
        ..title = 'Blog content'
        ..setAttribute('scrolling', 'no')
        ..style.border = '0'
        ..style.display = 'block'
        ..style.height = '100%'
        ..style.overflow = 'hidden'
        ..style.width = '100%';
      if (html.window.matchMedia('(pointer: coarse)').matches) {
        // Let Flutter's parent scroll view receive touch gestures directly.
        // This preserves native iPad momentum instead of relaying each move
        // through postMessage and jumping the scroll position.
        iframe.style.pointerEvents = 'none';
      }
      iframe.onLoad.listen((_) => _handleIframeLoad());
      _iframe = iframe;
      iframe.src = widget.sourceUrl;
      return iframe;
    });
  }

  @override
  void dispose() {
    _heightPoller?.cancel();
    html.window.removeEventListener('message', _handleMessage);
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

      final body = document?.body;
      if (body != null) {
        final bridge = html.ScriptElement()
          ..type = 'text/javascript'
          ..text = _resizeScript;
        body.append(bridge);
      }
    } catch (_) {
      // The iframe load still succeeded. Height polling below is sufficient
      // if a browser prevents direct document access.
    }

    _startHeightPolling();
  }

  String get _resizeScript {
    final subtitle = jsonEncode(widget.subtitle);
    return '''
(function () {
  var token = '$_resizeToken';
  var subtitle = $subtitle;
  function measure() {
    var body = document.body || {};
    var root = document.documentElement || {};
    var height = Math.max(
      body.scrollHeight || 0,
      body.offsetHeight || 0,
      root.scrollHeight || 0,
      root.offsetHeight || 0
    );
    parent.postMessage({ type: 'blog-content-height', token: token, height: height }, '*');
  }
  function updateSubtitle() {
    var subtitleElement = document.querySelector('.subtitle');
    if (subtitleElement) {
      subtitleElement.textContent = subtitle;
    }
  }
  function forwardWheel(event) {
    var multiplier = event.deltaMode === 1 ? 16 : event.deltaMode === 2 ? window.innerHeight : 1;
    parent.postMessage({
      type: 'blog-content-scroll',
      token: token,
      deltaY: event.deltaY * multiplier
    }, '*');
    event.preventDefault();
  }
  var lastTouchY = null;
  function rememberTouch(event) {
    if (event.touches.length === 1) {
      lastTouchY = event.touches[0].clientY;
    } else {
      lastTouchY = null;
    }
  }
  function forwardTouch(event) {
    if (event.touches.length !== 1 || lastTouchY === null) {
      return;
    }
    var currentTouchY = event.touches[0].clientY;
    var deltaY = lastTouchY - currentTouchY;
    lastTouchY = currentTouchY;
    if (deltaY !== 0) {
      parent.postMessage({
        type: 'blog-content-scroll',
        token: token,
        deltaY: deltaY
      }, '*');
      event.preventDefault();
    }
  }
  function clearTouch() {
    lastTouchY = null;
  }
  function ready() {
    updateSubtitle();
    measure();
  }
  updateSubtitle();
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', ready, { once: true });
  } else {
    ready();
  }
  window.addEventListener('load', function () {
    updateSubtitle();
    measure();
  });
  window.addEventListener('resize', measure);
  window.addEventListener('wheel', forwardWheel, { passive: false });
  window.addEventListener('touchstart', rememberTouch, { passive: true });
  window.addEventListener('touchmove', forwardTouch, { passive: false });
  window.addEventListener('touchend', clearTouch, { passive: true });
  window.addEventListener('touchcancel', clearTouch, { passive: true });
  if ('ResizeObserver' in window) {
    new ResizeObserver(measure).observe(document.documentElement);
  }
  setTimeout(measure, 0);
  setTimeout(measure, 250);
  setTimeout(measure, 1000);
})();
''';
  }

  void _startHeightPolling() {
    _heightPoller?.cancel();
    var ticks = 0;
    _updateHeightFromFrame();
    _heightPoller = Timer.periodic(const Duration(milliseconds: 350), (timer) {
      ticks++;
      _updateHeightFromFrame();
      if (ticks >= 12) {
        timer.cancel();
      }
    });
  }

  void _updateHeightFromFrame() {
    final iframe = _iframe;
    if (iframe == null) {
      return;
    }

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

    if (height > 0) {
      _setHeight(height + 2);
    }
  }

  void _handleMessage(html.Event event) {
    final message = event as html.MessageEvent;
    final data = message.data;
    if (data is! Map) {
      return;
    }
    if (data['token'] != _resizeToken) {
      return;
    }

    if (data['type'] == 'blog-content-height') {
      final height = data['height'];
      if (height is num) {
        _setHeight(height.toDouble());
      }
      return;
    }

    if (data['type'] == 'blog-content-scroll') {
      final deltaY = data['deltaY'];
      if (deltaY is num) {
        widget.onScroll?.call(deltaY.toDouble());
      }
    }
  }

  void _setHeight(double height) {
    if (!mounted) {
      return;
    }

    final nextHeight = height.clamp(360.0, 50000.0);
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
