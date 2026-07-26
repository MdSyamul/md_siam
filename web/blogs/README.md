# Blog Content

The website reads blog metadata from `lib/blogs.dart`. Each
blog post renders a standalone `.html` or `.htm` file from `web/blogs/...`.

## Add or edit a post

1. Replace the existing HTML file in the matching deployed `/blogs/` folder.
2. Replace the cover image if the card preview changes.
3. Edit `lib/blogs.dart` when title, subtitle, date, cover,
   category, or HTML file path changes.
4. Rebuild and deploy the Flutter web app.

Keep HTML and image assets under `web/blogs/`. After a full Flutter build, the
publishable copies are under `build/web/blogs/`.

## Standard folder shape

```text
web/blogs/
  example-post/
    cover.jpg
    content.html
```

Put the readable blog body in `content.html`. If the HTML references images,
place them in the same post folder and use relative paths such as
`<img src="image-01.jpg" alt="...">`.

Each post in `lib/blogs.dart` should use this shape:

```dart
BlogPost(
  title: 'Example Post',
  category: 'Research',
  subtitle: 'One clear sentence shown in the article and on blog cards.',
  publishedAt: '2026-07-19',
  updatedAt: '2026-07-19',
  coverImageUrl: 'blogs/example-post/cover.jpg',
  contentUrl: 'blogs/example-post/content.html',
),
```

## Intake format

When sending a new blog, this is enough:

```text
Blog title:
Category:
Summary:
Published date:
HTML file name:
Main text or HTML content:
Images used inside HTML:
Cover image preference:
```

Or send a folder:

```text
My Blog Name/
  cover.png
  content.html
```

I can convert that into the standard folder, update `lib/blogs.dart`, and rebuild
the site.
