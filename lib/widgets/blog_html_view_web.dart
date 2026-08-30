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
    required this.initialHeight,
    this.scrollController,
    this.pointerEventsEnabled = true,
  });

  final String sourceUrl;
  final String subtitle;
  final bool compact;
  final double initialHeight;
  final ScrollController? scrollController;
  final bool pointerEventsEnabled;

  @override
  State<BlogHtmlView> createState() => _BlogHtmlViewState();
}

class _BlogHtmlViewState extends State<BlogHtmlView> {
  late final String _viewType =
      'blog-html-${widget.sourceUrl.hashCode}-${identityHashCode(this)}';
  late double _height = widget.initialHeight;
  html.IFrameElement? _iframe;
  StreamSubscription<html.MessageEvent>? _windowMessageSubscription;

  @override
  void initState() {
    super.initState();
    _windowMessageSubscription = html.window.onMessage.listen(
      _handleFrameMessage,
    );
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = html.IFrameElement()
        ..title = 'Blog content'
        ..setAttribute('scrolling', 'no')
        ..style.border = '0'
        ..style.display = 'block'
        ..style.height = '100%'
        ..style.overflow = 'hidden'
        ..style.pointerEvents = widget.pointerEventsEnabled ? 'auto' : 'none'
        ..style.width = '100%';
      iframe.onLoad.listen((_) => _handleIframeLoad());
      _iframe = iframe;
      iframe.src = widget.sourceUrl;
      return iframe;
    });
  }

  @override
  void dispose() {
    _windowMessageSubscription?.cancel();
    super.dispose();
  }

  void _handleIframeLoad() {
    final iframe = _iframe;
    if (iframe == null || !mounted) {
      return;
    }

    dynamic document;
    try {
      document = (iframe as dynamic).contentDocument;
    } catch (_) {
      // Keep the configured fallback height when document access is blocked.
      return;
    }

    if (document == null) {
      return;
    }

    // Install the scroll bridge before making any optional document changes.
    // A failed subtitle lookup or DOM cast must never leave the iframe
    // intercepting wheel/touch input without forwarding it to Flutter.
    try {
      _installFrameBridge(document);
    } catch (_) {
      // Cross-origin documents cannot be bridged through their DOM.
    }

    try {
      final subtitleElement = document?.querySelector('.subtitle');
      if (subtitleElement != null) {
        subtitleElement.text = widget.subtitle;
      }
    } catch (_) {
      // The subtitle is optional.
    }

    try {
      final body = document?.body as html.HtmlElement?;
      final root = document?.documentElement as html.HtmlElement?;
      for (final element in {body, root}.whereType<html.HtmlElement>()) {
        element.style
          ..setProperty('touch-action', 'none')
          ..overflow = 'hidden';
      }
    } catch (_) {
      // The injected bridge also applies these styles when it runs.
    }

    try {
      _updateHeightFromDocument(document);
    } catch (_) {
      // Keep the configured fallback height when document access is blocked.
    }
  }

  void _installFrameBridge(dynamic document) {
    final bridgeId = 'blog-frame-bridge-$_viewType';
    if (document?.getElementById(bridgeId) != null) {
      return;
    }

    final script = document.createElement('script');
    script.id = bridgeId;
    script.textContent =
        '''
(function () {
  if (window.__blogScrollBridgeInstalled) {
    return;
  }
  window.__blogScrollBridgeInstalled = true;

  var viewType = ${jsonEncode(_viewType)};
  var lastTouchY = null;

  function postMessageToParent(message) {
    var targetOrigin = '*';
    try {
      if (window.parent.location.origin && window.parent.location.origin !== 'null') {
        targetOrigin = window.parent.location.origin;
      }
    } catch (_) {}

    try {
      window.parent.postMessage(JSON.stringify(message), targetOrigin);
    } catch (_) {}
  }

  function postScroll(delta) {
    if (!delta || Math.abs(delta) < 0.5) {
      return;
    }
    postMessageToParent({
      type: 'blog-html-scroll',
      viewType: viewType,
      delta: delta
    });
  }

  function reportHeight() {
    var page = document.querySelector('.page');
    var content = page || document.body || document.documentElement;
    if (!content) {
      return;
    }

    var rect = content.getBoundingClientRect();
    var height = Math.ceil(Math.max(
      rect.height || 0,
      content.scrollHeight || 0,
      content.offsetHeight || 0
    ));
    if (height <= 0) {
      return;
    }

    postMessageToParent({
      type: 'blog-html-resize',
      viewType: viewType,
      height: height
    });
  }

  function normalizeWheelDelta(event) {
    var delta = event.deltaY || 0;
    if (event.deltaMode === 1) {
      delta *= 20;
    } else if (event.deltaMode === 2) {
      delta *= window.innerHeight || 1;
    }
    return delta;
  }

  function handleWheel(event) {
    postScroll(normalizeWheelDelta(event));
    event.preventDefault();
    event.stopPropagation();
  }

  function handleTouchStart(event) {
    lastTouchY = event.touches && event.touches.length
      ? event.touches[0].clientY
      : null;
  }

  function handleTouchMove(event) {
    if (!event.touches || !event.touches.length || lastTouchY === null) {
      return;
    }
    var currentY = event.touches[0].clientY;
    postScroll(lastTouchY - currentY);
    lastTouchY = currentY;
    event.preventDefault();
    event.stopPropagation();
  }

  function endTouch() {
    lastTouchY = null;
  }

  function listen(target, eventName, handler) {
    if (!target) {
      return;
    }
    try {
      target.addEventListener(eventName, handler, {
        capture: true,
        passive: false
      });
    } catch (_) {
      target.addEventListener(eventName, handler, true);
    }
  }

  document.documentElement.style.overflow = 'hidden';
  document.documentElement.style.touchAction = 'none';
  if (document.body) {
    document.body.style.overflow = 'hidden';
    document.body.style.touchAction = 'none';
  }

  listen(window, 'wheel', handleWheel);
  listen(document, 'wheel', handleWheel);
  listen(window, 'touchstart', handleTouchStart);
  listen(document, 'touchstart', handleTouchStart);
  listen(window, 'touchmove', handleTouchMove);
  listen(document, 'touchmove', handleTouchMove);
  listen(window, 'touchend', endTouch);
  listen(document, 'touchend', endTouch);
  listen(window, 'touchcancel', endTouch);
  listen(document, 'touchcancel', endTouch);

  if (window.ResizeObserver) {
    var resizeObserver = new ResizeObserver(reportHeight);
    resizeObserver.observe(document.querySelector('.page') || document.body);
  }
  listen(window, 'load', reportHeight);
  listen(window, 'resize', reportHeight);
  if (document.fonts && document.fonts.ready) {
    document.fonts.ready.then(reportHeight);
  }
  requestAnimationFrame(function () {
    reportHeight();
    requestAnimationFrame(reportHeight);
  });
})();
''';
    (document.body ?? document.head ?? document.documentElement)?.append(
      script,
    );
  }

  void _handleFrameMessage(html.MessageEvent event) {
    if (!mounted || !_isTrustedScrollMessage(event)) {
      return;
    }

    final data = event.data;
    if (data is! String) {
      return;
    }

    try {
      final decoded = jsonDecode(data);
      if (decoded is! Map || decoded['viewType'] != _viewType) {
        return;
      }

      if (decoded['type'] == 'blog-html-scroll') {
        final delta = decoded['delta'];
        if (delta is num) {
          _scrollParentBy(delta.toDouble());
        }
      } else if (decoded['type'] == 'blog-html-resize') {
        final height = decoded['height'];
        if (height is num) {
          _setHeight(height.toDouble());
        }
      }
    } catch (_) {
      // Ignore unrelated messages from other scripts.
    }
  }

  bool _isTrustedScrollMessage(html.MessageEvent event) {
    if (_isTrustedScrollOrigin(event.origin)) {
      return true;
    }

    final iframeWindow = _iframe?.contentWindow;
    if (iframeWindow == null) {
      return false;
    }

    try {
      return (event as dynamic).source == iframeWindow;
    } catch (_) {
      return false;
    }
  }

  bool _isTrustedScrollOrigin(String origin) {
    if (origin == html.window.location.origin) {
      return true;
    }

    final sourceUri = Uri.tryParse(widget.sourceUrl);
    if (sourceUri == null || !sourceUri.hasScheme || sourceUri.host.isEmpty) {
      return false;
    }

    final port = sourceUri.hasPort ? ':${sourceUri.port}' : '';
    return origin == '${sourceUri.scheme}://${sourceUri.host}$port';
  }

  void _scrollParentBy(double delta) {
    if (!mounted || delta.abs() < 0.5) {
      return;
    }

    final position = _scrollPosition;
    if (position == null) {
      return;
    }

    if (!position.hasContentDimensions) {
      return;
    }

    final next = (position.pixels + delta)
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();
    if ((next - position.pixels).abs() < 0.5) {
      return;
    }

    position.jumpTo(next);
  }

  ScrollPosition? get _scrollPosition {
    final controller = widget.scrollController;
    if (controller != null && controller.hasClients) {
      return controller.position;
    }

    return Scrollable.maybeOf(context)?.position;
  }

  void _updateHeightFromDocument(dynamic document) {
    try {
      final page = document?.querySelector('.page');
      final pageHeight = [page?.scrollHeight, page?.offsetHeight]
          .whereType<num>()
          .fold<double>(0, (current, next) {
            return next > current ? next.toDouble() : current;
          });
      _setHeight(pageHeight.ceilToDouble());
    } catch (_) {
      // The frame bridge will report the height after layout settles.
    }
  }

  void _setHeight(double height) {
    if (!mounted || !height.isFinite || height <= 0) {
      return;
    }

    final measuredHeight = height.ceilToDouble();
    if ((measuredHeight - _height).abs() >= 1) {
      setState(() => _height = measuredHeight);
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
      clipBehavior: Clip.antiAlias,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
