import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResearchImage extends StatelessWidget {
  const ResearchImage({
    super.key,
    required this.path,
    required this.semanticsLabel,
  });

  final String path;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'web/$path',
      fit: BoxFit.cover,
      semanticsLabel: semanticsLabel,
    );
  }
}
