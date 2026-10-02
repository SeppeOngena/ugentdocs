# Changelog

## Derived from uantwerpendocs v4.12

This work was derived from the `uantwerpendocs` v4.12 code,
preserved at the Git tag `uantwerpendocs-v4.12-code`.

The original source was substantially modified and expanded
for the UGent house style. The major changes include:

- Renaming, restructuring, and merging of the classes and large portions of
  the code, and removal of legacy and unused code:
  - `uantwerpenphdthesis` → `ugentphd`
  - `uantwerpenbamathesis` → `ugentbama`
  - `uantwerpenreport` → `ugentreport`
  - `uantwerpencoursetext` → `ugentcourse`
  - `uantwerpenletter` → `ugentletter`
  - `uantwerpenexam` → `ugentexam`
  - `beamerthemeuantwerpen` → `beamerthemeugent`
  - new: `ugentbookcover` and `ugentarticle`
- Migration of class options (key–value, e.g. `faculty=bw`, `campus=kortrijk`,
  `colormodel=cmyk`) and most internals to LaTeX3 (expl3), dropping the
  xstring, xparse, and ifthen packages.
- Reworked dictionary handling: `\translatekey` with casing and expansion
  options, support for empty lines and a `__NEWLINE__` placeholder in `.dict`
  files, and improved babel compatibility (in-document switching via
  `\selectlanguage`).
- Reworked logo handling. No images are used, only TikZ paths (converted from
  the official EPS files) and text, for the UGent logo, all faculty logos,
  GUGC, and campus Kortrijk, plus standalone UGent and faculty icons. The
  faculty may be omitted entirely.
- UGent font handling: UGent Panno Text is required for the logos (and hence
  LuaLaTeX or XeLaTeX), with Arial as option. Noto Sans Math is used with
  TeX Gyre DejaVu Math as fallback. Fake small caps were implemented
  for fontspec fonts.
- Unified handling of people and document data through generalised sequences
  (authors, lecturers, supervisors, tutors, jury members, degrees, contact),
  including indexed affiliations, corresponding authors, e-mail and
  ORCID, a unified `\embargo` macro, localised dates via `localizedates`,
  word counts via texcount, and warnings for missing mandatory macros.
- Reworked book-cover generation. A separate `ugentbookcover` class prints
  covers from command inputs instead of relying on PDF inputs, including an
  automatic ISBN barcode; `\generatebookcover` now creates a more
  structured cover file directly from the main document.
- Integration of UGent-specific covers and title pages following the official
  grid, adding colophons, copyright, confidentiality and embargo notices with
  signature fields, headers and footers, chapter thumbs, and five chapter
  title styles.
- New `ugentarticle` class; a reworked beamer theme (16:9 grid geometry,
  a single configurable graphic frame, title and section graphics, title
  logos, closing frame); and a reworked exam class (subquestions, point
  overview, answer spaces with grid or line fills spilling to the next page).
- Build and release tools: local build script, GitHub Actions workflow,
  encrypted fonts for CI builds, and an auto-generated changelog.
- Extensive changes to documentation and examples, including an index,
  copy-pasteable code blocks, customisation notes, deduplicated examples,
  and a short LaTeX tutorial.

The detailed development history below is generated from Git.

## Development history
