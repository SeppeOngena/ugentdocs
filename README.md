# The `ugentdocs` $\LaTeX$ package
An **unofficial** package providing the UGent house style for $\LaTeX$ documents.

>[!CAUTION]
> The package is not currently guaranteed to be in a usable state, as this repository is still a WIP. See the [ugentdocs 1.0 project](https://github.com/users/SeppeOngena/projects/1) for up-to-date progress towards v1.0. See the [releases page](https://github.com/SeppeOngena/ugentdocs/releases) to try pre-releases.


I created this package since there are no official template provided, and current options are fragmented and developed by different users (some already left UGent). When I started my master's thesis, no official templates were present (or I couldn't find them easily), which has been a pet peeve ever since. Now I'm finishing my PhD, I stumble into the same issue.
This package will provide the following classes (implementation status shown):
- ⬜ `ugentthesis`: Master/bachelor's thesis
- 🚧 `ugentdissertation`: PhD thesis/dissertation with `ugentbookcover` class (incl. auto-generated ISBN barcode)
- ⬜ `ugentreport`: Project reports, e.g. group assignments
- ⬜ `ugentcourse`: Course notes
- ⬜ `ugentexam`: Exams
- ⬜ `ugentletter`: Letters
- ⬜ `beamerthemeugent`: Presentation slides

--- 
This work will try to integrate and expand on as many of those fragmented templates into a common framework (e.g. logos, dictionaries, etc.) based on Walter Daem's excellent `uantwerpendocs v4.12` package (available on [CTAN](https://ctan.org/pkg/uantwerpendocs), so that package was already present by default in my installation!).


Templates to integrate (that I know of):
| Integrated? | Project      | Maintainer | Status          | Document types |
|:-----------:|:-------------|:-----------| :---------------|:---------------|
| ⬜ | [ugent2016](https://github.com/niknetniko/ugent2016)                | Niko Strijbol  | Left UGent             | `article`, `book`, `report` |
| ⬜ | [ugent-doc](https://github.com/driesbenoit/ugent-doc)               | Dries Benoit   | Stale/Complete?        | `article`, `report` (only coverpage) |
| ⬜ | [ugent-beamer](https://github.com/driesbenoit/ugent-beamer)         | Dries Benoit   | Complete               | `beamer` |
| ⬜ | [ugent-letter](https://github.com/driesbenoit/ugent-letter)         | Dries Benoit   | Complete               | `letter` |
| ⬜ | [Latex at UGent](https://github.ugent.be/LatexInfo) (internal only) | Joris Meys     | Incomplete, but active | `ba/ma thesis` (only BW faculty templates, separate classes for NL and EN)|

---
The goal is to transfer this repository to UGent one when complete, so it becomes quasi-official, other UGent'ers can contribute, and maintenance is ensured if I would leave UGent. 

---

This is a barebones README which will be updated closer to a `ugentdocs v1.0` release, see https://github.com/SeppeOngena/ugentdocs/issues/21
