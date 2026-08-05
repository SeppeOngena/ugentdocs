# The `ugentdocs` $\LaTeX$ package
An **unofficial** package providing the UGent house style for $\LaTeX$ documents.

---
This is a WIP README which will be updated closer to a `ugentdocs v1.0` release, see https://github.com/SeppeOngena/ugentdocs/issues/21

Overview
--
>[!CAUTION]
> The package is not currently guaranteed to be in a usable state, as this repository is still a WIP. See the [ugentdocs 1.0 project](https://github.com/users/SeppeOngena/projects/1) for up-to-date progress towards v1.0. See the [releases page](https://github.com/SeppeOngena/ugentdocs/releases) to try pre-releases.

This package provides the following classes (implementation status shown):
- ✅ `ugentthesis`: Master/bachelor's thesis
- ✅ `ugentdissertation`: PhD thesis/dissertation
- ✅ `ugentbookcover` class to create full covers (back/spine/front) for dissertations and courses
- ✅ `ugentreport`: Project reports, e.g. group assignments
- 🚧 `ugentcourse`: Course notes
- ⬜ `ugentexam`: Exams
- ⬜ `ugentletter`: Letters
- ⬜ `beamerthemeugent`: Presentation slides

Installation
--
I plan to add the package to CTAN, so it would be present in most distributions by itself (in the `TEXMFDIST` directory).
To use it currently:
- Download the package from the [releases page](https://github.com/SeppeOngena/ugentdocs/releases). It's the `ugentdocs-<version>.zip` in the "Assets" section at the bottom of a release.
- Copy the contents of the `ugentdocs` folder from the .zip into your document folder, and any example from the `examples` folder should you wish, e.g.:
```
└── MyThesis/
    ├── Images/                                           <--
    ├── Figures/
    │   ├── FIG00-GraphicalAbstract.pdf
    │   └── FIG01-IntroductionScheme.pdf
    ├── Chapters/
    │   ├── 1-Introduction.tex
    │   ├── 2-MaterialsMethods.tex
    │   └── ......
    ├── MyThesis.tex or example-dissertation1.tex         <--
    ├── MyBibliography.bib
    ├── ugentthesis.cls or ugentdissertation.cls or ....  <--
    ├── ugentcommon.clo                                   <--
    ├── ugentdocs-english.dict                            <--
    └── ugentdocs-dutch.dict                              <--
```
- Once it is installed (and in the future if it's on CTAN you can skip the previous steps), use the class as in the examples by setting e.g. `\documentclass[<options>]{ugentdissertation}`

>[!WARNING]
> Due to the use of `fontspec` for the official logos, your documents need to be compiled using LuaLaTeX or XeTeX (you can easily set this in your editor), and the UGent Panno Text Medium and SemiBold fonts need to be installed

Features
-- 
For a complete list of features, you will be able to check the documentation (when it's finished). For now, you can glance at the preview images below and check the included example.tex files in the download .zip.

<details>
    
<summary> Click to expand </summary>
    
### 1. `ugentthesis`
- Implements bachelor's and master's theses. See the examples for all functionality and specific use.
- Generates coverpage and copyright page with signature fields automatically based on your data input, e.g. `\author`, `\supervisor`, `\tutor`, `\title`, etc.
- The copyright page sets a confidentiality notice automatically when you set `\embargotemp{startdate}{enddate}` or `\embargofull`
- You can change the copyright page to the signed one using `\copyrightnotices{\includepdf{copyright_signed.pdf}}`
- Changes titles etc. to UGent-style
  
  <table border="0" style="width: 100%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-thesis-1</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-thesis-2</th>
  </tr>
  <tr>
    <td style="border: none; text-align: left;">Using options bw (faculty), coverbg, neutralcolors, and font is UGent Panno Text (default)</td>
    <td style="border: none; text-align: left;">Using options bw (faculty), dutch, and font is overridden to Arial</td>
  </tr>
  <tr>
    <td style="border: none;"><img width="100%" alt="Master's title page" src="https://github.com/user-attachments/assets/31580a54-1e4c-4316-bff4-8746d44cd523" /></td>
    <td style="border: none;"><img width="100%" alt="Bachelor's title page" src="https://github.com/user-attachments/assets/1f2ef0d8-d2aa-4967-afad-6a315a414058"/></td>
  </tr>
    <td style="border: none;"><img width="100%" alt="Master's copyright page" src="https://github.com/user-attachments/assets/8be2b2a7-ee48-47b1-b6c1-44fa5d147280" /></td>
    <td style="border: none;"><img width="100%" alt="Bachelor's copyright page" src="https://github.com/user-attachments/assets/0216ccc2-b5ac-4ae0-a6f5-51fc7e4cb84e" /></td>
  </tr>
</table>

### 2. `ugentdissertation` and `ugentbookcover` 
- Implements PhD dissertation. See the examples for all functionality and specific use.
- Generates a coverpage and automatically generates a `filename-cover.tex` file which includes the full cover (back/spine/front).
- The data pages are automatically set based on your data input.
- A `bare` option that removes the cover from your dissertation for printing
- A `cameraready` option that embeds your content and cover into a larger (for the content an A4) page for printing.
<table border="0" style="width: 100%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-dissertation-1</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-dissertation-2</th>
  </tr>
  <tr>
    <td style="border: none; text-align: left;">Using options we (faculty),surnamefirst, dutch, and font is overridden to Arial</td>
    <td style="border: none; text-align: left;">Using options bw (faculty), cameraready, with a titlepageimage and isbn added, and font is UGent Panno Text</td>
  </tr>
  <tr>
    <td style="border: none;"><img width="100%" alt="Dissertation 1 Full Cover" src="https://github.com/user-attachments/assets/852326e2-e9c7-4b94-b0e1-fb2b65405b97" /></td>
    <td style="border: none;"><img width="100%" alt="Dissertation 2 Full Cover" src="https://github.com/user-attachments/assets/0af5a545-eeb1-4266-acc6-7baf7353e66d"/></td>
  </tr>
    <td style="border: none;">
      (cover page and blank page not shown)
      <img width="76%" alt="image" src="https://github.com/user-attachments/assets/4e95d26f-14c4-4072-a9c7-87a65558cff5" />
      <img width="76%" alt="image" src="https://github.com/user-attachments/assets/6c3edb71-5ebe-4981-bd04-b0546c937bce" />
      <img width="76%" alt="image" src="https://github.com/user-attachments/assets/20d83693-1f28-41e4-b680-c03df4b61bd1" />
    </td>
    <td style="border: none;">
      (cover page and blank page not shown)
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/e60f32ed-3558-41c3-a17f-66720b77860c" />
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/7135d6d8-3385-4d0f-b0b4-5688774d9e8b" />
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/4fc128ef-6bd7-4dee-96ee-e4991c923553" />
    </td>
  </tr>
</table>

### 3. `ugentreport`
- Can be used to typeset project, assignments, or meeting reports.
- Depending on the data passed, the titlepage can be adjusted as needed (e.g. no `\author` but `\address` is used).
- Chapter titles etc. are typeset the same as the `ugentthesis` class (see images below)
- Other than that, the report class doesn't do much more.
<table border="0" style="width: 100%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-report-1</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-report-2</th>
  </tr>
  <tr>
    <td style="border: none; text-align: left;">Using options bw (faculty),coverbg, dutch, and font is UGent Panno Text</td>
    <td style="border: none; text-align: left;">Using no faculty options, and font is overridden to Arial</td>
  </tr>
  <tr>
    <td style="border: none;">
        <img width="100%" alt="Report 1 Cover" src="https://github.com/user-attachments/assets/2454c8ad-98a9-451b-855d-0425f3d80107" />
        <img width="100%" alt="Report 1 Data page" src="https://github.com/user-attachments/assets/9b47d5f6-d222-4b1f-b8a1-b34aa6b7b083" />
        <img width="100%" alt="Report 1 TOC" src="https://github.com/user-attachments/assets/f3d28308-23a2-445c-afc7-067600922ad8" />
    </td>
    <td style="border: none;">
        <img width="100%" alt="Report 2 Cover" src="https://github.com/user-attachments/assets/1810c852-f670-4205-b09d-3acbbc53a983" />
        <img width="100%" alt="Report 2 Copyright" src="https://github.com/user-attachments/assets/191abe1d-064f-4e59-b27b-00c195ff1d70" />
        <img width="100%" alt="Report 2 TOC" src="https://github.com/user-attachments/assets/e8625b3e-36e3-4dac-9649-a443b5fcc369" />
    </td>
</table>
</details>

Why another template?
--
There are already five (or more?) existing templates, why add another one? This might remind you of the xkcd comic on [competing standards](https://xkcd.com/927/). There are no official templates provided, and current options are fragmented and developed by different people (some already left UGent). When I started my master's thesis, no official templates were present (or I couldn't find them easily), which has been a pet peeve ever since. Now I'm finishing my PhD, I stumble into the same issue. I found several issues with existing templates/classes:
- None of them use a single-source .dtx file. Some have common .sty files, which is good to avoid having to maintain duplicate code for e.g. logos or other common stuff, but some have separate classes entirely for e.g. different languages. While I think .dtx files have a drawback in that you're editing one long file and it's easy to get lost, it's also a major advantage that you have documentation and code essentially interwoven.
- Most of them seem incomplete. Often, only a titlepage is generated or title style set, but no generation of copyright pages, dissertation covers, data pages for dissertations, etc. The ugent-beamer and ugent-letter seem the most complete in this regard.
- They're not providing all possible templates. While this is not necessarily an issue, it does create chaos, e.g. on the [house style page](https://styleguide.ugent.be/templates/digital.html#latex). Users need to do a treasure hunt almost to find what they need.
- They're not distributed on CTAN. The `uantwerpendocs` package was already in my TexLive distribution, which meant I could just start using it without messing with class files or copying them in each document directory. This is planned for this package
- One counterargument towards my own package would be that it is very complex (we're currently sitting at 8500 lines of code) compared to other packages or classes. I plan to provide overrides where necessary (e.g. if you want to change copyright page contents), so users don't have to dig into that complexity
 
The goal is also to transfer this repository to UGent one when complete, so it becomes quasi-official, other UGent'ers can contribute, and maintenance is ensured if I would leave UGent. 

Integration status
--
This work will try to integrate and expand on as many of the existing fragmented templates into a common framework based on Walter Daem's excellent `uantwerpendocs v4.12` package (available on [CTAN](https://ctan.org/pkg/uantwerpendocs), so that package was already present by default in my installation!). If the integration status says complete, it means the current package has the same (or more!) functionality than the listed package.

Templates to integrate (that I know of):
| Integrated? | Project      | Maintainer | Status          | Document types |
|:-----------:|:-------------|:-----------| :---------------|:---------------|
| ✅ | [ugent2016](https://github.com/niknetniko/ugent2016)                | Niko Strijbol  | Left UGent             | `article`, `book`, `report`, `course`, `notes` |
| ✅ | [ugent-doc](https://github.com/driesbenoit/ugent-doc)               | Dries Benoit   | Stale/Complete?        | `article`, `report` (only coverpage) |
| ⬜ | [ugent-beamer](https://github.com/driesbenoit/ugent-beamer)         | Dries Benoit   | Complete               | `beamer` |
| ⬜ | [ugent-letter](https://github.com/driesbenoit/ugent-letter)         | Dries Benoit   | Complete               | `letter` |
| ✅ | [Latex at UGent](https://github.ugent.be/LatexInfo) (internal only) | Joris Meys     | Incomplete, but active | `ba/ma thesis` (only BW faculty templates, separate classes for NL and EN)|

---

