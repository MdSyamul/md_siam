import 'package:flutter/material.dart';

import 'pages/blog/blog_page.dart';
import 'pages/home/home_page.dart';
import 'pages/research/research_page.dart';
import 'site_content.dart';
import 'site_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: siteName,
      debugShowCheckedModeBanner: false,
      theme: buildSiteTheme(),
      home: const SiteHomePage(),
      routes: {
        BlogPage.routeName: (context) => const BlogPage(),
        ResearchPage.routeName: (context) => const ResearchPage(),
      },
    );
  }
}
