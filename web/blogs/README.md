# Runtime Blog Content

The website reads blog posts from `web/blogs/blogs.json` at runtime. Each blog
post renders a standalone `content.html` file.

## Edit without rebuilding after deployment

1. Upload the post images into the matching deployed `/blogs/` folder.
2. Edit the deployed `/blogs/blogs.json` file.
3. Edit the deployed post `content.html` file when the written content changes.
4. Bump the top-level `version` value so browsers fetch the updated files.

In this repository, keep the source copy under `web/blogs/`. After a full
Flutter build, the publishable copy is under `build/web/blogs/`.

## Standard folder shape

```text
web/blogs/
  blogs.json
  example-post/
    cover.jpg
    content.html
    image-01.jpg
    image-02.jpg
```

Put the readable blog body in `content.html`. If the post is image-based,
reference the images directly from that HTML file, for example
`<img src="image-01.jpg" alt="...">`.

Each post in `blogs.json` should use this shape:

```json
{
  "slug": "example-post",
  "title": "Example Post",
  "category": "Research",
  "summary": "One clear sentence for blog cards.",
  "publishedAt": "2026-07-19",
  "updatedAt": "2026-07-19",
  "coverImage": "blogs/example-post/cover.jpg",
  "content": "blogs/example-post/content.html",
  "images": [
    "blogs/example-post/image-01.jpg"
  ],
  "paragraphs": []
}
```

## Intake format

When sending a new blog, this is enough:

```text
Blog title:
Category:
Summary:
Published date:
Main text or HTML content:
Images/slides:
Preferred order:
```

Or send a folder:

```text
My Blog Name/
  cover.png
  1.png
  2.png
  content.html
```

I can convert that into the standard folder, optimize images, update
`blogs.json`, and rebuild the site.
