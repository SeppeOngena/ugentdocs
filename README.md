<h1 align="center">The ugentdocs $\LaTeX$ package</h1>
<h3 align="center">An unofficial package providing the UGent house style for $\LaTeX$ documents</h3>


<p align="center">
<a href="https://github.com/SeppeOngena/ugentdocs"><img alt="LPPL-1.3c License" src="https://img.shields.io/github/license/SeppeOngena/ugentdocs.svg"/></a>
<a href="https://github.com/SeppeOngena/ugentdocs/releases"><img alt="Current Release" src="https://img.shields.io/github/release/SeppeOngena/ugentdocs.svg?include_prereleases"/></a>
<a href="https://github.com/SeppeOngena/ugentdocs/releases"><img alt="Download Count" src="https://img.shields.io/github/downloads/SeppeOngena/ugentdocs/total"/></a>
<a href="https://github.com/SeppeOngena/ugentdocs/commits"><img alt="Commits since Latest Release" src="https://img.shields.io/github/commits-since/SeppeOngena/ugentdocs/latest?include_prereleases"/></a>

    

</p>

---

Overview
--
>[!CAUTION]
> The package is not currently guaranteed to be in a usable state, as this repository is still a WIP. See the [ugentdocs 1.0 project](https://github.com/users/SeppeOngena/projects/1) for up-to-date progress towards v1.0. See the [releases page](https://github.com/SeppeOngena/ugentdocs/releases) to try pre-releases.

This package provides the following classes (implementation status shown):
- ✅ `ugentbama`: Master/bachelor's dissertation
- ✅ `ugentphd`: PhD dissertation
- ✅ `ugentbookcover` class to create full covers (back/spine/front) for PhD dissertations and courses
- ✅ `ugentreport`: Project reports, e.g. group assignments
- ✅ `ugentcourse`: Course notes
- ⬜ `ugentexam`: Exams
- ✅ `ugentletter`: Letters
- 🚧 `beamerthemeugent`: Presentation slides

The goal is also to transfer this repository to UGent one when complete, so it becomes quasi-official, other UGent'ers can contribute, and maintenance is ensured if I would leave UGent. 


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
    ├── MyThesis.tex or example-phd.tex                   <--
    ├── MyBibliography.bib
    ├── ugentbama.cls or ugentphd.cls or ....             <--
    ├── ugentcommon.clo                                   <--
    ├── ugentcolor.sty                                    <--
    ├── ugentdocs-english.dict                            <--
    └── ugentdocs-dutch.dict                              <--
```
- Once it is installed (and in the future if it's on CTAN you can skip the previous steps), use the class as in the examples by setting e.g. `\documentclass[<options>]{ugentphd}`

>[!WARNING]
> Due to the use of `fontspec` for the official logos, your documents need to be compiled using LuaLaTeX or XeTeX (you can easily set this in your editor), and the UGent Panno Text Medium and SemiBold fonts need to be installed

Features
-- 
For a complete list of features, you will be able to check the documentation (when it's finished). For now, you can glance at the preview images below and check the included example.tex files in the download .zip.

<details>
    
<summary> Click to expand </summary>
    
### 1. `ugentbama`
- Implements bachelor's and master's dissertation. See the examples for all functionality and specific use.
- Generates coverpage and copyright page with signature fields automatically based on your data input, e.g. `\author`, `\supervisor`, `\tutor`, `\title`, etc.
- The copyright page sets a confidentiality notice automatically when you set `\embargotemp{startdate}{enddate}` or `\embargofull`
- You can change the copyright page to the signed one using `\copyrightnotices{\includepdf{copyright_signed.pdf}}`
- Changes titles etc. to UGent-style
  
  <table border="0" style="width: 100%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-bama-1</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-bama-2</th>
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

### 2. `ugentphd` and `ugentbookcover` 
- Implements PhD dissertation. See the examples for all functionality and specific use.
- Generates a coverpage and automatically generates a `filename-cover.tex` file which includes the full cover (back/spine/front).
- The data pages are automatically set based on your data input.
- A `bare` option that removes the cover from your dissertation for printing
- A `cameraready` option that embeds your content and cover into a larger (for the content an A4) page for printing.
<table border="0" style="width: 100%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-phd-1</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-phd-2</th>
  </tr>
  <tr>
    <td style="border: none; text-align: left;">Using options we (faculty),surnamefirst, dutch, and font is overridden to Arial</td>
    <td style="border: none; text-align: left;">Using options bw (faculty), cameraready, with a titlepageimage and isbn added, and font is UGent Panno Text</td>
  </tr>
  <tr>
    <td style="border: none;"><img width="100%" alt="Dissertation 1 Full Cover" src="https://github.com/user-attachments/assets/2fd3cf99-5775-47c9-b09a-7e0350c65d9f" /></td>
    <td style="border: none;"><img width="100%" alt="Dissertation 2 Full Cover" src="https://github.com/user-attachments/assets/8628a638-ed65-4ee8-bdfc-1eba9ef5c705" /></td>
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
    <td style="border: none; text-align: left;">Using no faculty options, and font is overridden to Arial</td>
    <td style="border: none; text-align: left;">Using options bw (faculty),coverbg, dutch, and font is UGent Panno Text</td>
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

### 3. `ugentcourse`
- Can be used to typeset course notes.
- Generates a coverpage and automatically generates a `filename-cover.tex` file which includes the full cover (back/spine/front).
- On the cover page, the faculty icon is shown in large if no titlepageimage is added.
- Chapter titles etc. are typeset the same as the `ugentdissertation` class
- A copyright watermark can be added if needed.
<table border="0" style="width: 50%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-course</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;"></th>
  </tr>
  <tr>
    <td style="border: none; text-align: left;">Using bw faculty option and dutch, and font is UGent Panno Text</td>
  </tr>
  <tr>
    <td style="border: none;">
        <img width="100%" alt="Course Cover" src="https://github.com/user-attachments/assets/eb83574d-ee7b-433e-8b32-0cd7770d38c8" />
        <img width="100%" alt="Course Data page"  src="https://github.com/user-attachments/assets/b8f73469-f881-41c8-a169-1999c2fa4e31" />
    </td>
</table>


### 3. `ugentletter`
- Can be used to typeset letters.
<table border="0" style="width: 50%;">
  <tr>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;">example-letter</th>
    <th width="50%"; style="border: none; text-align: left; font-weight: bold;"></th>
  </tr>
  <tr>
    <td style="border: none; text-align: left;">Using bw faculty option, font is overridden to Arial</td>
  </tr>
  <tr>
    <td style="border: none;">
        <img width="100%" alt="Course Cover" src="https://github.com/user-attachments/assets/f8331b3f-e2f0-46de-ae81-43cc29528d21" />
        <img width="100%" alt="Course Data page"  src="https://github.com/user-attachments/assets/3ca00e30-f464-4240-8434-12c7bd301600" />
    </td>
</table>
</details>

Copyright
--
This work is derived from `uantwerpendocs` v4.12 by Walter Daems. See the [NOTICE.md](NOTICE.md) or the class files copyright notices for further information.

:copyright: 2013-2026 by Walter Daems  
:copyright: 2017 by Joris Meys  
:copyright: 2026 by Seppe Ongena

