<h1 align="center">The ugentdocs $\LaTeX$ package</h1>
<h3 align="center">The UGent house style for $\LaTeX$ documents, developed and maintained by volunteers</h3>


<p align="center">
<a href="https://github.com/SeppeOngena/ugentdocs"><img alt="LPPL-1.3c License" src="https://img.shields.io/github/license/SeppeOngena/ugentdocs.svg"/></a>
<a href="https://github.com/SeppeOngena/ugentdocs/releases"><img alt="Current Release" src="https://img.shields.io/github/release/SeppeOngena/ugentdocs.svg?include_prereleases"/></a>
<a href="https://github.com/SeppeOngena/ugentdocs/releases"><img alt="Download Count" src="https://img.shields.io/github/downloads/SeppeOngena/ugentdocs/total"/></a>
<a href="https://github.com/SeppeOngena/ugentdocs/commits"><img alt="Commits since Latest Release" src="https://img.shields.io/github/commits-since/SeppeOngena/ugentdocs/latest?include_prereleases"/></a>

    

</p>

---

Overview
--

This package provides the following classes:

- `ugentbama`: Master/bachelor's dissertation
- `ugentphd`: PhD dissertation
- `ugentbookcover`: Full covers (back/spine/front) for PhD dissertations and courses
- `ugentarticle`: Research articles for uploading Author Accepted Manuscripts to Biblio or submitting to journals that do not provide a template
- `ugentreport`: Most general class. Used for project reports, group assignments, meeting notes, supplementary information,...
- `ugentcourse`: Course notes
- `ugentletter`: Letters
- `ugentexam`: Exams
- `beamerthemeugent`: Presentation slides

Please submit issues, features, or bugs to the [issue page](https://github.com/SeppeOngena/ugentdocs/issues), and
any other questions or help needed in the [discussions page](https://github.com/SeppeOngena/ugentdocs/discussions).

The separate [`ugentdocs-contrib`](https://GitHub.com/SeppeOngena/ugentdocs-contrib) package provides some useful extensions or customizations not part of the UGent house style (e.g., BibLaTeX styling or Supplementary Information styling)

Installation
--
>[!WARNING]
> Due to the use of `fontspec` for the official logos, your documents need to be compiled using LuaLaTeX or XeLaTeX (you can easily set this in your editor), and the UGent Panno Text Medium and SemiBold fonts need to be installed. You can find these fonts [on the intranet](https://ugentbe.sharepoint.com/sites/intranet-communicatie/SitePages/en/corporate-design.aspx).

### Through your TeX distribution (recommended)

`ugentdocs` is available on [CTAN](https://ctan.org/pkg/ugentdocs) and is
included in TeX Live and MiKTeX.

- **TeX Live:** `tlmgr install ugentdocs` (or `tlmgr update ugentdocs`)
- **MiKTeX:** install or update it through the MiKTeX Console. MiKTeX can
  also install it automatically the first time a document uses it.

To check which version you have, put `\listfiles` at the top of your
document and look at the end of the `.log` file, or run, e.g.,
`kpsewhich ugentreport.cls` to see which file is being used.

New versions reach CTAN first and TeX Live/MiKTeX a few days later.
Some installations take longer, e.g., linux distro packages 
(`texlive-*` from pacman, apt, dnf, etc.)
are snapshots and can be months out of date. `tlmgr` cannot update them.

If your version is older than what is listed on CTAN, or you need a fix
from the GitHub repository that has not been released yet,
use the manual method below.

### Using it in a single document (manual installation)

- Download the package from the [releases page](https://github.com/SeppeOngena/ugentdocs/releases).
 It's the `ugentdocs-<version>.zip` in the "Assets" section at the bottom of a release.
- Copy the needed contents of the `ugentdocs` folder from the .zip into your document folder,
  and any example from the `examples` folder should you wish, e.g.:
```
└── MyThesis/
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

Files in the document folder take priority over the installed version,
so this works even when an older copy is installed system-wide. It also
keeps the project self-contained: a thesis compiled this way will still
compile identically years from now.

To go back to the distribution's version, delete these files again.

### Installing from source (testing unreleased changes)

With the [l3build](https://ctan.org/pkg/l3build) package installed 
(included in TeX Live and MiKTeX):

    git clone https://github.com/SeppeOngena/ugentdocs.git
    cd ugentdocs
    l3build install

This installs the current development version for your user account,
overriding the version from your TeX distribution. Undo it with
`l3build uninstall`, or later updates from your distribution will
have no effect.

Usage and features
-- 

Once the package is installed, you can start using the class files with `\documentclass[<options>]{<ugentclass>}`,
where the `ugentclass` is one of `ugentbama`, `ugentphd`,...
For a complete list of features including options and macros, you can check the documentation included in the release .zip (`ugentdocs.pdf`).
The example files included in release zips provide a quick overview of the functionality as well.

Below, you can find a quick visual look at what the package provides.

#### 1. `ugentbama`
<details>   
<summary> Images </summary>
  
  <table>
  <tr>
    <th width="50%">example-ugentbama-1</th>
    <th width="50%">example-ugentbama-2</th>
  </tr>
  <tr>
    <td><img width="100%" alt="example-ugentbama-1-01" src="https://github.com/user-attachments/assets/7519f4be-a291-4cf3-a33f-87189a6ab7aa" /></td>
    <td><img width="100%" alt="example-ugentbama-2-01" src="https://github.com/user-attachments/assets/64e5df60-d79c-4d17-b311-e162186a409f" /></td>
  </tr>
    <td><img width="100%" alt="example-ugentbama-1-03" src="https://github.com/user-attachments/assets/ab37f80e-6ba3-4ce3-a629-6f71d5f7c2b5" /></td>
    <td><img width="100%" alt="example-ugentbama-2-03" src="https://github.com/user-attachments/assets/844ebff9-c742-4007-8134-604063135bf8" /></td>
  </tr>
</table>
</details>

#### 2. `ugentphd` 
<details>   
<summary> Images </summary>
<table>
  <tr>
    <th width="50%">example-ugentphd-1</th>
    <th width="50%">example-ugentphd-2</th>
  </tr>
    <td style="border: none;">
      <img width="76%" alt="example-ugentphd-1-001" src="https://github.com/user-attachments/assets/58d4b0f0-98d7-407e-a5fa-9724ff439842" />
      <img width="76%" alt="example-ugentphd-1-003" src="https://github.com/user-attachments/assets/a1c892f3-f423-43e4-832c-5fa86a73c646" />
      <img width="76%" alt="example-ugentphd-1-004" src="https://github.com/user-attachments/assets/ba8e6c86-4881-4d64-b42d-3cb20c06263f" />
      <img width="76%" alt="example-ugentphd-1-005" src="https://github.com/user-attachments/assets/35d3d60d-6d66-4e9e-b754-b00069977eea" />
    </td>
    <td style="border: none;">
      <img width="100%" alt="example-ugentphd-2-001" src="https://github.com/user-attachments/assets/a6062088-3bb5-4fb4-82d6-a6b9ef00f594" />
      <img width="100%" alt="example-ugentphd-2-003" src="https://github.com/user-attachments/assets/33cf47f6-37f1-4089-90e0-3fd7ea4712ec" />
      <img width="100%" alt="example-ugentphd-2-004" src="https://github.com/user-attachments/assets/6cf14b62-3c2a-47f2-a57f-d19374ab7ad6" />
      <img width="100%" alt="example-ugentphd-2-005" src="https://github.com/user-attachments/assets/9c81e314-c777-4160-bb38-dd23c37fc02c" />
    </td>
  </tr>
</table>
</details>

#### 3. `ugentcourse`
<details>   
<summary> Images </summary>

**example-ugentcourse**

<img width="50%" alt="example-ugentcourse-01" src="https://github.com/user-attachments/assets/96ad6788-a7bb-48ac-af2f-50830c9a6ed0" />
<img width="50%" alt="example-ugentcourse-02" src="https://github.com/user-attachments/assets/5c113910-745b-4259-aca8-31f347e0761f" />

</details>

#### 4. `ugentbookcover`
<details>   
<summary> Images </summary>

**example-ugentphd1-cover**

<img width="100%" alt="example-ugentphd-1-cover-1" src="https://github.com/user-attachments/assets/2e4d2962-1420-4996-95e0-16c08ead41fd" />

**example-ugentphd2-cover**

<img width="100%" alt="example-ugentphd-2-cover-1" src="https://github.com/user-attachments/assets/841419db-59b3-40bd-a99d-f20722aff1d4" />


**example-ugentcourse-cover**

<img width="100%" alt="example-ugentcourse-cover-1" src="https://github.com/user-attachments/assets/9db89814-9a41-4fc9-bf4a-c7292ddbd41c" />


</details>

#### 5. `ugentarticle`

<details>   
<summary> Images </summary>

**example-ugentarticle**

<img width="50%" alt="example-ugentarticle-1" src="https://github.com/user-attachments/assets/a6989441-e050-4319-b0d2-44da15503e5b" />
<img width="50%" alt="example-ugentarticle-2" src="https://github.com/user-attachments/assets/c5029ddf-9c40-4aec-8b45-b8685bbb4ccc" />


</details>

#### 6. `ugentreport`
<details>   
<summary> Images </summary>
<table>
  <tr>
    <th width="50%">example-ugentreport-1</th>
    <th width="50%">example-ugentreport-2</th>
  </tr>
  <tr>
    <td>
        <img width="100%" alt="example-ugentreport-1-01" src="https://github.com/user-attachments/assets/c741d2c0-a16c-4c69-b73b-abdee4c44f29" />
        <img width="100%" alt="example-ugentreport-1-02" src="https://github.com/user-attachments/assets/90f7121a-9af2-4112-b033-4580a533e0ca" />
    </td>
    <td>
        <img width="100%" alt="example-ugentreport-2-01" src="https://github.com/user-attachments/assets/2e9953af-0663-4794-9ddf-8906ed93ba97" />
        <img width="100%" alt="example-ugentreport-2-02" src="https://github.com/user-attachments/assets/9bb8b41a-0afb-4615-b6e2-bc6190329ac4" />
    </td>
</table>
</details>


#### 7. `ugentletter`
<details>   
<summary> Images </summary>

**example-ugentletter**

<img width="50%" alt="example-ugentletter-1" src="https://github.com/user-attachments/assets/e652b8f8-acc4-4c0e-b3fe-4b4fd3396559" />
<img width="50%" alt="example-ugentletter-2" src="https://github.com/user-attachments/assets/4e897238-e4fb-4b59-9cab-51ba74019239" />

</details>

#### 8. `ugentexam`
<details>   
<summary> Images </summary>

**example-ugentexam-1**

<img width="50%" alt="example-ugentexam-1-1" src="https://github.com/user-attachments/assets/fbbf9fc9-43d7-4261-9ee8-2d689ad74c8c" />
<img width="50%" alt="example-ugentexam-1-2" src="https://github.com/user-attachments/assets/2b4cb738-463e-491e-bd24-f1939609bff5" />
<img width="50%" alt="example-ugentexam-1-3" src="https://github.com/user-attachments/assets/e1a2a796-f14e-43a8-a1db-a12b151bb45f" />
<img width="50%" alt="example-ugentexam-1-4" src="https://github.com/user-attachments/assets/8b23626f-741f-4d00-9488-172d68e8bc4d" />


</details>

#### 9. `beamerthemeugent`
<details>   
<summary> Images </summary>

**beamerthemeuserguide**

<img width="60%" alt="beamerthemeugentuserguide-12" src="https://github.com/user-attachments/assets/0c0e0151-1ff6-4c48-8aa9-207a410274b7" />
<img width="60%" alt="beamerthemeugentuserguide-14" src="https://github.com/user-attachments/assets/ada80c3d-1967-4d8f-99bb-d7b839869024" />
<img width="60%" alt="beamerthemeugentuserguide-16" src="https://github.com/user-attachments/assets/227c5d09-bc09-46d2-9bc1-10e36d9bc694" />
<img width="60%" alt="beamerthemeugentuserguide-22" src="https://github.com/user-attachments/assets/ea6902bd-515b-444c-a857-b09a02320af9" />
<img width="60%" alt="beamerthemeugentuserguide-31" src="https://github.com/user-attachments/assets/7f9ea369-45f2-49b3-9d01-cf499c05ea2b" />
<img width="60%" alt="beamerthemeugentuserguide-39" src="https://github.com/user-attachments/assets/db3918af-7555-4d0d-ab72-14b9c870cc36" />
<img width="60%" alt="beamerthemeugentuserguide-18" src="https://github.com/user-attachments/assets/a154ceab-3034-46de-a61f-c2c8d50b7fa0" />


</details>

Copyright
--
This work is derived from `uantwerpendocs` v4.12 by Walter Daems. See the [NOTICE.md](NOTICE.md) or the class files copyright notices for further information.

:copyright: 2013-2026 by Walter Daems  
:copyright: 2017-2026 by Joris Meys  
:copyright: 2026 by Seppe Ongena

