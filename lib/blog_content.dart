import 'package:flutter/material.dart';

class BlogPost {
  const BlogPost({
    required this.slug,
    required this.title,
    required this.publishedDate,
    required this.category,
    required this.summary,
    required this.readTime,
    required this.icon,
    required this.tags,
    required this.paragraphs,
  });

  final String slug;
  final String title;
  final String publishedDate;
  final String category;
  final String summary;
  final String readTime;
  final IconData icon;
  final List<String> tags;
  final List<String> paragraphs;

  String get searchableText => [
    title,
    publishedDate,
    category,
    summary,
    readTime,
    ...tags,
    ...paragraphs,
  ].join(' ').toLowerCase();
}

const List<BlogPost> blogPosts = [
  // BlogPost(
  //   slug: 'physical-ai-for-mechanical-engineering',
  //   title: 'Physical AI for Mechanical Engineering',
  //   publishedDate: 'May 2026',
  //   category: 'ABC',
  //   summary:
  //       'A short note on connecting learning systems with physical mechanical behavior, experiments, and engineering constraints.',
  //   readTime: '4 min read',
  //   icon: Icons.smart_toy_rounded,
  //   tags: ['Physical AI', 'Robotics', 'Mechanical systems'],
  //   paragraphs: [
  //     'Physical AI becomes most useful when it is treated as an engineering practice rather than only a model-building exercise. The important question is how a system senses the world, reasons under uncertainty, and acts through real hardware.',
  //     'For mechanical engineering, this means learning methods should respect dynamics, materials, sensors, actuators, and safety limits. A capable model is valuable, but a capable model embedded in a reliable physical loop is much more valuable.',
  //     'The next step for many research problems is to design experiments where data, simulation, and control policies improve each other. This creates a practical bridge between AI research and deployable mechanical systems.',
  //   ],
  // ),
  // BlogPost(
  //   slug: 'sensor-lite-thermal-comfort',
  //   title: 'Why Sensor-Lite Thermal Comfort Models Matter',
  //   publishedDate: 'April 2026',
  //   category: 'Applied AI',
  //   summary:
  //       'A reflection on reducing sensing requirements while keeping thermal comfort prediction useful in real indoor spaces.',
  //   readTime: '3 min read',
  //   icon: Icons.thermostat_rounded,
  //   tags: ['Thermal comfort', 'Machine learning', 'Control'],
  //   paragraphs: [
  //     'Thermal comfort prediction often depends on measurements that are difficult to collect continuously in ordinary buildings. A sensor-lite approach asks which contextual proxy features can preserve enough signal for a practical prediction model.',
  //     'The benefit is not only lower cost. Fewer sensors can make systems easier to install, maintain, and scale, especially in educational or resource-constrained environments.',
  //     'Good comfort control should balance model accuracy with usability. A slightly simpler model that can be deployed widely may create more real-world value than a complex model that stays in the lab.',
  //   ],
  // ),
  // BlogPost(
  //   slug: 'teaching-control-with-simulation',
  //   title: 'Teaching Control Concepts with Simulation',
  //   publishedDate: 'March 2026',
  //   category: 'Teaching',
  //   summary:
  //       'How small simulations can help students connect mathematical control theory with visible system behavior.',
  //   readTime: '3 min read',
  //   icon: Icons.school_rounded,
  //   tags: ['Teaching', 'Control theory', 'Simulation'],
  //   paragraphs: [
  //     'Students often understand control theory more deeply when equations are connected to visible behavior. Simulation gives them a place to see overshoot, settling time, instability, and disturbance rejection as dynamic events.',
  //     'A useful classroom simulation does not need to be complicated. It should make one idea clear, allow quick parameter changes, and invite students to predict what will happen before they run it.',
  //     'This style of teaching helps turn abstract mathematical tools into engineering judgment. Students learn not only how to calculate a response, but how to interpret one.',
  //   ],
  // ),
];

List<String> get blogCategories {
  final categories = <String>{};
  for (final post in blogPosts) {
    categories.add(post.category);
  }
  return categories.toList()..sort();
}
