import 'dart:convert';

import 'package:flutter/services.dart';

class BlogPost {
  const BlogPost({
    required this.slug,
    required this.title,
    required this.category,
    this.summary = '',
    required this.paragraphs,
    this.coverImageUrl,
    this.imageUrls = const [],
    this.contentUrl,
    this.publishedAt,
    this.updatedAt,
  });

  final String slug;
  final String title;
  final String category;
  final String summary;
  final List<String> paragraphs;
  final String? coverImageUrl;
  final List<String> imageUrls;
  final String? contentUrl;
  final String? publishedAt;
  final String? updatedAt;

  String get searchableText =>
      [title, category, summary, ...paragraphs].join(' ').toLowerCase();

  String? get displayDate => updatedAt ?? publishedAt;

  factory BlogPost.fromJson(Map<String, dynamic> json, String contentVersion) {
    final images = _stringList(
      json['images'],
    ).map((path) => _resolveContentUrl(path, contentVersion)).toList();
    final coverImage = _stringValue(json['coverImage']);
    final content = _stringValue(json['content']);

    return BlogPost(
      slug: _stringValue(json['slug']) ?? _slugFromTitle(json['title']),
      title: _stringValue(json['title']) ?? 'Untitled post',
      category: _stringValue(json['category']) ?? 'Writing',
      summary: _stringValue(json['summary']) ?? '',
      paragraphs: _stringList(json['paragraphs']),
      coverImageUrl: coverImage == null
          ? (images.isEmpty ? null : images.first)
          : _resolveContentUrl(coverImage, contentVersion),
      imageUrls: images,
      contentUrl: content == null
          ? null
          : _resolveContentUrl(content, contentVersion),
      publishedAt: _stringValue(json['publishedAt']),
      updatedAt: _stringValue(json['updatedAt']),
    );
  }
}

const _theSelfIsOldImages = [
  'blogs/the-self-is-old/slide-01.jpg',
  'blogs/the-self-is-old/slide-02.jpg',
  'blogs/the-self-is-old/slide-03.jpg',
  'blogs/the-self-is-old/slide-04.jpg',
  'blogs/the-self-is-old/slide-05.jpg',
  'blogs/the-self-is-old/slide-06.jpg',
];

const List<BlogPost> blogPosts = [
  BlogPost(
    slug: 'the-self-is-old',
    title: 'Quiet Ruin of the Self',
    category: 'Philosophy',
    summary: 'The self is old - older than the universe.',
    publishedAt: '2026-07-18',
    updatedAt: '2026-07-18',
    coverImageUrl: 'blogs/the-self-is-old/cover.jpg',
    imageUrls: _theSelfIsOldImages,
    contentUrl: 'blogs/the-self-is-old/content.html',
    paragraphs: [],
  ),
];

List<String> get blogCategories {
  final categories = <String>{};
  for (final post in blogPosts) {
    categories.add(post.category);
  }
  return categories.toList()..sort();
}

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
          posts.add(
            BlogPost.fromJson(
              Map<String, dynamic>.from(postJson),
              contentVersion,
            ),
          );
        }
      }

      return posts.isEmpty ? blogPosts : posts;
    } catch (_) {
      return blogPosts;
    }
  }

  Future<String?> loadPostContent(BlogPost post) async {
    if (post.contentUrl == null) {
      return null;
    }

    try {
      return NetworkAssetBundle(Uri.base).loadString(post.contentUrl!);
    } catch (_) {
      return null;
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

List<String> _stringList(Object? value) {
  if (value is! List) {
    return const [];
  }

  return [
    for (final item in value)
      if (_stringValue(item) != null) _stringValue(item)!,
  ];
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

String _slugFromTitle(Object? title) {
  final value = (_stringValue(title) ?? 'untitled-post').toLowerCase();
  final slug = value
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return slug.isEmpty ? 'untitled-post' : slug;
}
