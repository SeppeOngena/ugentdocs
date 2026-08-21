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
This package will try to work off as many of the existing fragmented templates and build a common framework based on Walter Daem's excellent `uantwerpendocs v4.12` package (available on [CTAN](https://ctan.org/pkg/uantwerpendocs), so that package was already present by default in my installation!). If the "used" status below is true, it means the current package has the same (or more!) functionality than the listed package. 

| Used? | How? | Project      | Maintainer | Status          | Document types |
|:-----------:|:-------------|:-------------|:-----------| :---------------|:---------------|
| ✅ | Starting point, basis of framework    | [uantwerpendocs](https://ctan.org/pkg/uantwerpendocs)               | Walter Daems   | Active                 | `report`, `coursetext`, `phdthesis`, `bamathesis`, `letter`, `exam`, `beamer` |
| ✅ | Served as reference for functionality | [ugent2016](https://github.com/niknetniko/ugent2016)                | Niko Strijbol  | Left UGent             | `article`, `book`, `report`, `course`, `notes` |
| ✅ | Served as reference for functionality | [ugent-doc](https://github.com/driesbenoit/ugent-doc)               | Dries Benoit   | Stale/Complete?        | `article`, `report` (only coverpage) |
| ⬜ | Served as reference for functionality | [ugent-beamer](https://github.com/driesbenoit/ugent-beamer)         | Dries Benoit   | Complete               | `beamer` |
| ✅ | Served as reference for functionality | [ugent-letter](https://github.com/driesbenoit/ugent-letter)         | Dries Benoit   | Complete               | `letter` |
| ✅ | Cover page and headers code           | [Latex at UGent](https://github.ugent.be/LatexInfo) (internal only) | Joris Meys     | Incomplete, but active | `ba/ma thesis` (only BW faculty templates, separate classes for NL and EN)|

---
