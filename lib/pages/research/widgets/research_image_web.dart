// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

class ResearchImage extends StatefulWidget {
  const ResearchImage({
    super.key,
    required this.path,
    required this.semanticsLabel,
  });

  final String path;
  final String semanticsLabel;

  @override
  State<ResearchImage> createState() => _ResearchImageState();
}

class _ResearchImageState extends State<ResearchImage> {
  late final String _viewType =
      'research-image-${widget.path.hashCode}-${identityHashCode(this)}';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return html.ImageElement()
        ..src = Uri.base.resolve(widget.path).toString()
        ..alt = widget.semanticsLabel
        ..draggable = false
        ..style.display = 'block'
        ..style.height = '100%'
        ..style.objectFit = 'cover'
        ..style.pointerEvents = 'none'
        ..style.width = '100%';
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: HtmlElementView(viewType: _viewType));
  }
}
