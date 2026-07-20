import 'dart:convert';

import 'package:flutter/services.dart';

class BlogPost {
  const BlogPost({
    required this.title,
    required this.category,
    this.summary = '',
    this.coverImageUrl,
    required this.contentUrl,
    this.publishedAt,
    this.updatedAt,
  });

  final String title;
  final String category;
  final String summary;
  final String? coverImageUrl;
  final String contentUrl;
  final String? publishedAt;
  final String? updatedAt;

  String? get displayDate => updatedAt ?? publishedAt;

  static BlogPost? fromJson(Map<String, dynamic> json, String contentVersion) {
    final coverImage = _stringValue(json['coverImage']);
    final content = _stringValue(json['content']);
    if (content == null) {
      return null;
    }

    return BlogPost(
      title: _stringValue(json['title']) ?? 'Untitled post',
      category: _stringValue(json['category']) ?? 'Writing',
      summary: _stringValue(json['summary']) ?? '',
      coverImageUrl: coverImage == null
          ? null
          : _resolveContentUrl(coverImage, contentVersion),
      contentUrl: _resolveContentUrl(content, contentVersion),
      publishedAt: _stringValue(json['publishedAt']),
      updatedAt: _stringValue(json['updatedAt']),
    );
  }
}

const List<BlogPost> blogPosts = [
  BlogPost(
    title: 'Quiet Ruin of the Self',
    category: 'Philosophy',
    summary: 'The self is old - older than the universe.',
    publishedAt: '2026-07-18',
    updatedAt: '2026-07-18',
    coverImageUrl: 'blogs/the-self-is-old/cover.jpg',
    contentUrl: 'blogs/the-self-is-old/content.html',
  ),
];

class BlogRepository {
  const BlogRepository();

  static const _manifestPath = 'blogs/blogs.json';

  Future<List<BlogPost>> loadPosts() async {
    try {
      final cacheKey = DateTime.now().millisecondsSinceEpoch.toString();
      final rawJson = await NetworkAssetBundle(
        Uri.base,
      ).loadString('$_manifestPath?v=$cacheKey');
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return blogPosts;
      }

      final contentVersion = _stringValue(decoded['version']) ?? cacheKey;
      final postsJson = decoded['posts'];
      if (postsJson is! List) {
        return blogPosts;
      }

      final posts = <BlogPost>[];
      for (final postJson in postsJson) {
        if (postJson is Map) {
          final post = BlogPost.fromJson(
            Map<String, dynamic>.from(postJson),
            contentVersion,
          );
          if (post != null) {
            posts.add(post);
          }
        }
      }

      return posts.isEmpty ? blogPosts : posts;
    } catch (_) {
      return blogPosts;
    }
  }
}

String? _stringValue(Object? value) {
  if (value is! String) {
    return null;
  }
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}

String _resolveContentUrl(String path, String version) {
  final parsed = Uri.parse(path);
  final resolved = parsed.hasScheme ? parsed : Uri.base.resolve(path);
  if (version.isEmpty) {
    return resolved.toString();
  }

  return resolved
      .replace(queryParameters: {...resolved.queryParameters, 'v': version})
      .toString();
}
