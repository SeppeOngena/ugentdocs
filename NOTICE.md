Attribution
--

This work was derived from the `uantwerpendocs` v4.12 code, preserved at the Git tag `uantwerpendocs-v4.12-code`.
The original source was substantially modified and expanded for the UGent house style.
The major changes include, but are not limited to:
- Restructuring and merging of substantial portions of the code.
- Renaming and restructuring of classes.
- Reworking of dictionary handling. Including empty lines, newline placeholders, casing typesetting of the keys, improving compatibility with babel.
- Reworking of logo input and handling. No images are used, only tikz paths and text.
- Reworking of book-cover generation. A separate ugentbookcover class is added which prints the covers based on commands inputs instead of relying on PDF inputs.
- Integration of UGent-specific cover, chapter, and header/footer code.
- UGent-specific class functionality.
- Extensive changes to documentation and examples.
  
Code was included with permission from Joris Meys' LaTeX at UGent (see below, LaTeXInfo internal UGent repository).

The detailed development history can be found in CHANGELOG.md or in the GitHub repository.

Relation to other packages
--
This package intends to supersede as many of the existing fragmented templates -- i.e., the current package has the same (or more!) functionality than the listed package -- and build a common framework based on Walter Daem's excellent `uantwerpendocs v4.12` package (available on [CTAN](https://ctan.org/pkg/uantwerpendocs), so that package was already present by default in my installation!).

| Relation | Project      | Maintainer | Status          | Document types |
|:-------------|:-------------|:-----------| :---------------|:---------------|
| Starting point, basis of framework           | [uantwerpendocs](https://ctan.org/pkg/uantwerpendocs)               | Walter Daems   | Active                 | `report`, `coursetext`, `phdthesis`, `bamathesis`, `letter`, `exam`, `beamer` |
| Served as reference for functionality        | [ugent2016](https://github.com/niknetniko/ugent2016)                | Niko Strijbol  | Left UGent             | `article`, `book`, `report`, `course`, `notes` |
| Served as reference for functionality        | [ugent-doc](https://github.com/driesbenoit/ugent-doc)               | Dries Benoit   | Stale/Complete?        | `article`, `report` (only coverpage) |
| Served as reference for functionality        | [ugent-beamer](https://github.com/driesbenoit/ugent-beamer)         | Dries Benoit   | Complete               | `beamer` |
| Served as reference for functionality        | [ugent-letter](https://github.com/driesbenoit/ugent-letter)         | Dries Benoit   | Complete               | `letter` |
| Cover page, headers, and GAI disclaimer code | [Latex at UGent](https://github.ugent.be/LatexInfo) (internal only) | Joris Meys     | Incomplete, but active | `ba/ma thesis` (only BW faculty templates, separate classes for NL and EN)|

Why another template?
--
There are already five (or more?) existing templates, why add another one? This might remind you of the xkcd comic on [competing standards](https://xkcd.com/927/). There are no official templates provided, and current options are fragmented and developed by different people (some already left UGent). When I started my master's thesis, no official templates were present (or I couldn't find them easily), which has been a pet peeve ever since. Now I'm finishing my PhD, I stumble into the same issue. I found several issues with existing templates/classes:
- None of them use a single-source .dtx file. Some have common .sty files, which is good to avoid having to maintain duplicate code for e.g. logos or other common stuff, but some have separate classes entirely for e.g. different languages. While I think .dtx files have a drawback in that you're editing one long file and it's easy to get lost, it's also a major advantage that you have documentation and code essentially interwoven.
- Most of them seem incomplete. Often, only a titlepage is generated or title style set, but no generation of copyright pages, dissertation covers, data pages for dissertations, etc. The ugent-beamer and ugent-letter seem the most complete in this regard.
- They're not providing all possible templates. While this is not necessarily an issue, it does create chaos, e.g. on the [house style page](https://styleguide.ugent.be/templates/digital.html#latex). Users need to do a treasure hunt almost to find what they need.
- They're not distributed on CTAN. The `uantwerpendocs` package was already in my TexLive distribution, which meant I could just start using it without messing with class files or copying them in each document directory. This is planned for this package
- One counterargument towards my own package would be that it is very complex (we're currently sitting at 8500 lines of code) compared to other packages or classes. I plan to provide overrides where necessary (e.g. if you want to change copyright page contents), so users don't have to dig into that complexity

---
 
