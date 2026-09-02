# Project Memory — Md. Syamul Bashar Website

Last updated: 2026-09-02

This file is the persistent working memory for this repository. Read it before
making project changes. Update it whenever a preference, decision, dependency,
implementation detail, or troubleshooting result becomes materially different.
Revise outdated entries instead of adding conflicting notes. When a bug recurs,
consult **Bugs and troubleshooting** before trying a new approach.

## Project context

- This is a Flutter/Dart academic website for Md. Syamul Bashar, Assistant
  Professor of Mechanical Engineering at SUST.
- The intended tone is academic, confident, approachable, and technically
  serious.
- The visual direction is a modern research-lab aesthetic: deep navy, warm
  tan, soft ivory, and muted cyan; Merriweather headings and IBM Plex Sans body
  text.
- The current main routes are the home page, `/research`, and `/blog`.
- `website_plan.md` contains the longer content and design plan. Keep this file
  focused on active decisions and operational knowledge.
- Treat `assets/research.docx` as the authoritative source for research-page
  wording and project information unless the user provides a newer source.
- The working tree commonly contains user-owned, uncommitted refactors and
  assets. Preserve unrelated changes and do not assume a dirty file is safe to
  replace wholesale.

## User preferences and recurring instructions

- Do not run a release build or push commits unless the user explicitly asks
  for that action in the current request.
- Use conventional, concise hyperlink labels. For research resources, display
  `Paper` and `Code`, not raw URLs or `[paper]: URL`-style text.
- Keep `Paper` and `Code` side by side, immediately after the corresponding
  research-project title. Treat them as an inline, non-breaking group where
  practical.
- Give `Paper` and `Code` a conventional underline gap. Use a controlled bottom
  rule with about 3 px of separation instead of Flutter's tight default text
  decoration.
- Map words shown in red or a similar accent in `assets/research.docx` to the
  same rust accent (`#A94731`) used by Paper and Code links. In the current
  source these are `Completed`, `Ongoing`, `Accepted`, and `Thesis Book`; keep
  their surrounding punctuation in the normal citation color.
- External resource links should open in a new tab/window with safe
  `noopener,noreferrer` behavior.
- Keep the visible email, phone/WhatsApp number, and department address
  selectable, with an explicit copy button and brief confirmation message for
  each value.
- Visitors must be able to scroll with the mouse wheel or touch gesture while
  the pointer is over research content and illustrations.
- Preserve responsive behavior across desktop, tablet, and narrow mobile
  layouts.
- Keep the research document on a light paper-like underlay with a restrained
  border and shadow, similar in purpose to the full-blog reading surface. Its
  purpose is readability; it need not exactly match the blog UI.
- Prefer a durable structural solution over repeated patches to a fragile
  interaction bridge.
- Research illustrations should read clearly as their engineering subject, not
  as generic icons. In particular, show a mechanically credible manipulator
  end effector and a recognizable rounded-leading-edge, sharp-trailing-edge
  airfoil profile.

## Terminology and content conventions

- `Paper`: publication or Google Scholar destination.
- `Code`: related GitHub repository.
- `Research project title`: the item under `CURRENT RESEARCH PROJECTS`, not the
  broader research-area heading.
- Preserve official project-title capitalization unless explicitly asked to
  edit it.
- Current research-area headings are Additive Manufacturing and Physics AI,
  Physical AI for Manufacturing Floor, Indoor Environment Control, and
  Generative Design.
- The visible `/research` page title is `Research Directions`; keep the route and
  navigation terminology unchanged unless explicitly requested.
- Research focus lines from the current Word source are:
  - Additive Manufacturing and Physics AI: `(In-situ Monitoring & Adaptive
    Control; Process-Structure-Property Modeling; Finite Element Analysis.)`
  - Physical AI for Manufacturing Floor: `(Robotic Manipulator; Industrial
    Robots.)`
  - Indoor Environment Control: `(Thermal Comfort Control; Indoor Farming.)`
  - Generative Design: `(Airfoil Design)`
- Treat those focus lines as italic subtitles directly below their major
  research-area headings, not as part of the descriptive paragraphs.

## Important implementation decisions

### Home page

- Keep the hero portrait unobstructed. The former floating `Research Focus`
  card was removed from the portrait; research topics belong in the dedicated
  Research Areas section instead.
- Keep the Research Areas actions responsive: `Explore research directions`
  and `Google Scholar` sit together on wide layouts and wrap on narrow screens.
  The Scholar action uses the shared safe external-link handler.

### Research page

- Render the research page as native Flutter widgets inside the
  `SingleChildScrollView` in
  `lib/pages/research/research_page.dart`. Do not move the interactive research
  content back into a full-page iframe; the iframe captured wheel/touch input.
- Research content and Paper/Code URLs live in
  `lib/pages/research/sections/research_document.dart`.
- The research page was last synchronized with `assets/research.docx` on
  2026-09-02.
- The current narrative framing emphasizes physical principles, uncertainty,
  limited data, safety-critical operation, and evolving physical systems. Area
  summaries cover data-efficient, physics-guided, uncertainty-aware additive
  manufacturing and digital twins; robust embodied intelligence; efficient
  indoor sensing/control; and an end-to-end airfoil design framework.
- The current Word source uses `Selected Research Projects:` for Additive
  Manufacturing and Physics AI, Physical AI for Manufacturing Floor, and
  Indoor Environment Control. It uses `Selected Research Projects (Airfoil
  Design):` for Generative Design.
- Project entries include the source's full author, session/year, venue, status,
  and thesis-book wording. Do not shorten these citations when syncing future
  Word updates.
- The native document root uses the key `research-content-underlay` and owns
  the light surface, border, and subtle shadow behind all research content.
- Research typography derives from the global Merriweather/IBM Plex Sans theme
  without modifying global tokens. Current research-specific sizes are:
  - Page title: 42 px desktop (`displayMedium`), 34 px compact
    (`displaySmall`).
  - Intro: 16 px at 1.7 line height with an 800 px maximum measure.
  - Area heading: 28 px desktop, 24 px compact, at 1.2 line height.
  - Italic subtitle: 14.5 px desktop, 14 px compact, at 1.5 line height.
  - Summary: 16 px desktop, 15.5 px compact, at 1.65 line height.
  - Project item: 15.5 px desktop, 15 px compact, at 1.6 line height.
  - Paper/Code: the global 13 px semibold `labelMedium` style.
- Within each project citation, render the actual research title in bold while
  keeping authors, sessions, years, and venue details at regular weight.
- Present research-focus subtitles as plain italic medium-weight muted text,
  without a colored callout or accent rule.
- Mirror red or similar Word-source emphasis with the Paper/Code rust accent
  (`#A94731`). Currently, only the words `Completed`, `Ongoing`, `Accepted`, and
  the phrase `Thesis Book` receive this treatment; surrounding status text and
  punctuation remain in the citation's normal color.
- Research illustrations use a conditional `ResearchImage` implementation:
  - `lib/pages/research/widgets/research_image_web.dart` renders a browser-native
    `<img>` via `HtmlElementView`.
  - The web image and its Flutter wrapper must ignore pointer input; the DOM
    image uses `pointer-events: none` so scrolling reaches Flutter.
  - `lib/pages/research/widgets/research_image_stub.dart` uses
    `SvgPicture.asset` for tests and non-web targets.
  - The conditional export is
    `lib/pages/research/widgets/research_image.dart`.
- Public SVG source files are in `web/research/`. The four active SVGs are also
  declared as Flutter assets in `pubspec.yaml` for the non-web fallback.
- `physical-ai.svg` uses an articulated robot with a wrist flange and
  two-finger gripper; `generative-design.svg` uses a cambered airfoil with
  design/control points and surrounding flow streamlines. Preserve this visual
  specificity in future revisions.
- `flutter_svg` is pinned with `^2.3.0`.

### External links

- Use `lib/utils/external_link.dart`, which conditionally exports the web
  implementation. The web implementation validates allowed URL schemes and
  calls `window.open` with `noopener,noreferrer`.

### Contact details

- `SiteContactRow` renders its value with `SelectableText` and provides a
  clipboard action using `Clipboard.setData`. Preserve the existing email and
  phone tap actions while keeping all three contact values independently
  selectable and copyable.

### Blog content

- The blog listing uses `AdaptiveWrapGrid` with a 280 px minimum card width, a
  420 px maximum card width, and up to three columns. Preserve these bounds so
  cards remain readable without wasting tablet space or becoming oversized on
  desktop.
- Blog articles still use `BlogHtmlView` and an iframe-based height/scroll
  bridge. Do not assume the research page uses the same rendering path.
- In `blog_html_view_web.dart`, install the frame bridge before optional DOM
  changes; a subtitle lookup or DOM cast must not abort bridge setup.

## Verification expectations

- Run `dart format` for changed Dart files.
- Run `flutter analyze` after implementation changes.
- Run the blog viewport regression test when changing blog listing or card
  layout; it covers 280 px mobile through 1440 px desktop at enlarged text.
- Run the targeted research test when changing research layout or scrolling:
  `flutter test --plain-name "research section opens the research page"`.
- Run `flutter build web` for web-platform or asset changes.
- The targeted research test scrolls from Additive Manufacturing toward
  Generative Design and verifies Paper links remain present.
- Widget tests intentionally return HTTP 400 for `HttpClient` requests. Avoid
  network-loaded images in widget tests unless a client is mocked.

## Bugs and troubleshooting

### Research page would not scroll when the pointer was over its content

- **Observed behavior:** The page could scroll outside the research document,
  but wheel/touch input over the research content did nothing.
- **Root cause:** The research document was a full-height HTML iframe. The
  iframe intercepted pointer input and depended on an injected `postMessage`
  bridge to move Flutter's parent `ScrollController`. That bridge was not
  reliable in the running page.
- **Successful fix:** Rebuilt the research document as native Flutter widgets
  under the page's existing `SingleChildScrollView`. Paper/Code links remained
  native clickable widgets.
- **Relevant files:**
  `lib/pages/research/research_page.dart`,
  `lib/pages/research/sections/research_document.dart`, and
  `test/widget_test.dart`.
- **Attempt that did not solve it:** Reordering iframe initialization so the
  injected bridge installed before subtitle and height processing. Analysis and
  builds passed, but the user confirmed scrolling was still blocked.
- **Lesson:** Do not use an interactive full-page iframe for the research page.
  Passing compilation does not verify browser wheel-event handoff; retain the
  native Flutter layout and its targeted drag test.

### Research illustrations disappeared after removing the iframe

- **Observed behavior:** Research scrolling worked, but none of the SVG
  illustrations rendered in the running web page.
- **Root cause status:** The exact browser failure was not conclusively proven.
  The SVGs were valid and present under `build/web/assets/web/research/`, so the
  likely issue was the running web session's Flutter asset-resolution/cache
  path rather than missing or malformed source SVGs.
- **Successful fix:** On web, render each public `research/*.svg` file as a
  browser-native `<img>` through the conditional `ResearchImage` widget. Set
  both the DOM image and Flutter wrapper to ignore pointer events so images do
  not recreate the scrolling bug. Keep `SvgPicture.asset` as the non-web/test
  fallback.
- **Relevant files/configuration:**
  `lib/pages/research/widgets/research_image.dart`,
  `research_image_web.dart`, `research_image_stub.dart`, `pubspec.yaml`, and
  `flutter_svg ^2.3.0`.
- **Attempt that did not work:** Switching to `SvgPicture.network` for the
  public files caused widget tests to receive HTTP 400 responses and report
  `Bad state: Invalid SVG data`; its perpetual loading indicator also caused
  `pumpAndSettle` to time out. Do not use network SVG loading in this tested
  widget without injecting a mock HTTP client.
- **Lesson:** For this Flutter web page, browser-native images are the reliable
  web rendering path. Always keep `pointer-events: none` on these image platform
  views and verify that all four files exist in `build/web/research/`.

### Paper and Code links were verbose and separated from project titles

- **Observed behavior:** Resource links exposed full URLs and Code appeared in
  a separate paragraph.
- **Root cause:** The original research HTML used raw URL text and separate
  resource blocks.
- **Successful fix:** Use concise `Paper`/`Code` labels in an inline resource
  group directly after the project title. The native Flutter research layout
  now owns this presentation.
- **Additional correction:** Fixed `ctation_for_view` to
  `citation_for_view` in the second Google Scholar URL.
- **Lesson:** New research resources should follow the same inline convention.

### GitHub Pages deployment failed during tests

- **Observed behavior:** The Pages workflow run stopped at `flutter test`, so
  the web build, artifact upload, and deploy jobs were skipped.
- **Root cause:** Widget tests still expected the disabled Productivity post,
  its Personal Growth metadata, and the old `View all research` label. The
  current site intentionally shows `Quiet Ruin of the Self`, `Philosophy`, and
  `Explore research directions` instead.
- **Successful fix:** Updated the content assertions in `test/widget_test.dart`
  to describe the active blog data and current research call-to-action. Keep
  these tests synchronized when intentionally changing visible site content.
- **Lesson:** Run the complete `flutter test` suite before pushing because the
  Pages workflow treats any widget-test failure as a deployment blocker.

## Current successful checks

- `flutter analyze` passes.
- The complete `flutter test` suite passes.
- `flutter build web` passes.
- The targeted research navigation/scrolling test passes.
- The built site contains all four active SVG files in `build/web/research/`.
