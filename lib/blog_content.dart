class BlogPost {
  const BlogPost({
    required this.title,
    required this.category,
    required this.paragraphs,
  });

  final String title;
  final String category;
  final List<String> paragraphs;

  String get searchableText =>
      [title, category, ...paragraphs].join(' ').toLowerCase();
}

const List<BlogPost> blogPosts = [
  BlogPost(title: 'Self', category: 'A quite ruin of self', paragraphs: []),
];

List<String> get blogCategories {
  final categories = <String>{};
  for (final post in blogPosts) {
    categories.add(post.category);
  }
  return categories.toList()..sort();
}
