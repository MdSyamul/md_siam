# Runtime Blog Content

The website reads blog metadata from `web/blogs/blogs.json` at runtime. Each
blog post renders a standalone `.html` or `.htm` file from `web/blogs/...`.

## Edit without rebuilding after deployment

1. Replace the existing HTML file in the matching deployed `/blogs/` folder.
2. Replace the cover image if the card preview changes.
3. Edit the deployed `/blogs/blogs.json` file when title, summary, date, cover,
   category, or HTML file path changes.
4. Bump the top-level `version` value so browsers fetch updated metadata and
   blog HTML.

In this repository, keep the source copy under `web/blogs/`. After a full
Flutter build, the publishable copy is under `build/web/blogs/`.

## Standard folder shape

```text
web/blogs/
  blogs.json
  example-post/
    cover.jpg
    content.html
```

Put the readable blog body in `content.html`. If the HTML references images,
place them in the same post folder and use relative paths such as
`<img src="image-01.jpg" alt="...">`.

Each post in `blogs.json` should use this shape:

```json
{
  "title": "Example Post",
  "category": "Research",
  "summary": "One clear sentence for blog cards.",
  "publishedAt": "2026-07-19",
  "updatedAt": "2026-07-19",
  "coverImage": "blogs/example-post/cover.jpg",
  "content": "blogs/example-post/content.html"
}
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

I can convert that into the standard folder, update `blogs.json`, and rebuild
the site.
