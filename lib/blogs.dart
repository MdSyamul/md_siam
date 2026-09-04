class BlogPost {
  const BlogPost({
    required this.title,
    required this.category,
    this.subtitle = '',
    this.coverImageUrl,
    required this.contentUrl,
    this.publishedAt,
    this.updatedAt,
    this.webContentHeight = 780,
    this.compactWebContentHeight = 461,
  });

  final String title;
  final String category;
  final String subtitle;
  final String? coverImageUrl;
  final String contentUrl;
  final String? publishedAt;
  final String? updatedAt;
  final double webContentHeight;
  final double compactWebContentHeight;

  String? get displayDate => updatedAt ?? publishedAt;
}

const List<BlogPost> blogPosts = [
  // BlogPost(
  //   title: 'Productivity',
  //   category: 'Personal Growth',
  //   subtitle: 'Begin gently, then build.',
  //   publishedAt: '2026-07-29',
  //   updatedAt: '2026-07-29',
  //   coverImageUrl: 'blogs/productivity/cover.png',
  //   contentUrl: 'blogs/productivity/content.html',
  //   webContentHeight: 1060,
  //   compactWebContentHeight: 920,
  // ),
  BlogPost(
    title: 'Quiet Ruin of the Self',
    category: 'Philosophy',
    subtitle: 'The self is old—older than the universe.',
    publishedAt: '2026-07-18',
    updatedAt: '2026-07-18',
    coverImageUrl: 'blogs/the-self-is-old/cover.jpg',
    contentUrl: 'blogs/the-self-is-old/content.html',
    webContentHeight: 2455,
    compactWebContentHeight: 2364,
  ),
  BlogPost(
    title: 'Existing',
    category: 'Philosophy',
    subtitle: 'Lightness',
    publishedAt: '2026-07-23',
    updatedAt: '2026-07-23',
    coverImageUrl: 'blogs/existing/cover.png',
    contentUrl: 'blogs/existing/content.html',
  ),
];

class BlogRepository {
  const BlogRepository();

  Future<List<BlogPost>> loadPosts() async => blogPosts;
}
