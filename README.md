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
- `ugentarticle`: Research articles for uploading to Biblio
- `ugentreport`: Project reports, e.g., group assignments
- `ugentcourse`: Course notes
- `ugentletter`: Letters
- `ugentexam`: Exams
- `beamerthemeugent`: Presentation slides

Please submit issues, features, or bugs to the [issue page](https://github.com/SeppeOngena/ugentdocs/issues), and
any other questions or help needed in the [discussions page](https://github.com/SeppeOngena/ugentdocs/discussions).

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
- **Overleaf:** included in Overleaf's TeX Live image (can be outdated).

To check which version you have, put `\listfiles` at the top of your
document and look at the end of the `.log` file, or run, e.g.,
`kpsewhich ugentreport.cls` to see which file is being used.

### Getting the most recent version

New versions reach CTAN first and TeX Live/MiKTeX a few days later.
Some installations take longer:

- **Linux distro packages** (`texlive-*` from pacman, apt, dnf,
  etc.) are snapshots and can be months out of date. `tlmgr` usually
  cannot update them.
- **Overleaf** updates its TeX Live once a year.

If your version is older than what is listed on CTAN, or you need a fix
from the repository that has not been released yet, use the manual method below.

### Using it in a single document (manual installation)

- Download the package from the [releases page](https://github.com/SeppeOngena/ugentdocs/releases).
 It's the `ugentdocs-<version>.zip` in the "Assets" section at the bottom of a release.
- Copy the needed contents of the `ugentdocs` folder from the .zip into your document folder
or Overleaf project root, and any example from the `examples` folder should you wish, e.g.:
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
    <td><img width="100%" src="https://github.com/user-attachments/assets/46c17ca1-39fd-42ab-9b0f-78a75ecc3811" /></td>
    <td><img width="100%" src="https://github.com/user-attachments/assets/6ea0c6c7-6d59-4efa-bba3-7ddcb8ad1745"/></td>
  </tr>
    <td><img width="100%" src="https://github.com/user-attachments/assets/50e63c10-3e51-4522-8d3a-c0728b6b794a" /></td>
    <td><img width="100%" src="https://github.com/user-attachments/assets/ef69eaa1-2983-425e-bf83-24f6a0823425" /></td>
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
      <img width="76%" src="https://github.com/user-attachments/assets/ceba3cef-ba1c-4540-89ba-2c74e8165f3a" />
      <img width="76%" src="https://github.com/user-attachments/assets/8f29b202-8ec0-4df9-ae13-221b32f51827" />
      <img width="76%" src="https://github.com/user-attachments/assets/7f8f9946-2b0e-40a8-a482-fb9e7422485f" />
      <img width="76%" src="https://github.com/user-attachments/assets/50e52484-4a41-4c73-9440-475c4c08d3d9" />
    </td>
    <td style="border: none;">
      <img width="100%" src="https://github.com/user-attachments/assets/7ef849d8-5d80-40b3-a964-abf91f90ec53" />
      <img width="100%" src="https://github.com/user-attachments/assets/23b078a4-7579-4e62-9cf7-756f4d5ca36f" />
      <img width="100%" src="https://github.com/user-attachments/assets/859e6468-6385-402e-ade1-0078f5dddf97" />
      <img width="100%" src="https://github.com/user-attachments/assets/92eccc72-64df-4c9a-b460-8b15675634e0" />
    </td>
  </tr>
</table>
</details>

#### 3. `ugentcourse`
<details>   
<summary> Images </summary>

**example-ugentcourse**

<img width="50%" src="https://github.com/user-attachments/assets/69b40804-eeb8-4f2c-a505-9188baf5f530" />
<img width="50%" src="https://github.com/user-attachments/assets/9e29ae01-5a78-4946-a2e4-76c6d93be28a" />

</details>

#### 4. `ugentbookcover`
<details>   
<summary> Images </summary>

**example-ugentphd1-cover**

<img width="100%" src="https://github.com/user-attachments/assets/eccd802a-9714-4181-a9aa-03298a4b0a6c" />

**example-ugentphd2-cover**

<img width="100%" src="https://github.com/user-attachments/assets/841419db-59b3-40bd-a99d-f20722aff1d4" />


**example-ugentcourse-cover**

<img width="100%" src="https://github.com/user-attachments/assets/8065ff0a-92e3-4ca6-b1ca-8c1f7cf0596f" />


</details>

#### 5. `ugentarticle`

<details>   
<summary> Images </summary>

**example-ugentarticle**

<img width="50%" src="https://github.com/user-attachments/assets/5b23821e-eac7-41a4-b200-84e484aa3bea" />
<img width="50%" src="https://github.com/user-attachments/assets/b30248e2-a2ae-46ce-8df9-2ec06c0367b3" />


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
        <img width="100%" src="https://github.com/user-attachments/assets/35d4a44f-8db3-4794-971c-48149214f78b" />
        <img width="100%" src="https://github.com/user-attachments/assets/5ddb8a33-ac5b-449a-93f0-80b13bd5a080" />
    </td>
    <td>
        <img width="100%" src="https://github.com/user-attachments/assets/9da0859e-6e9e-44f5-83c8-dc062f0af8d3" />
        <img width="100%" src="https://github.com/user-attachments/assets/088a5690-fe4b-4f02-a7bb-93b1cd7dee74" />
    </td>
</table>
</details>


#### 7. `ugentletter`
<details>   
<summary> Images </summary>

**example-ugentletter**

<img width="50%" src="https://github.com/user-attachments/assets/e652b8f8-acc4-4c0e-b3fe-4b4fd3396559" />
<img width="50%" src="https://github.com/user-attachments/assets/4e897238-e4fb-4b59-9cab-51ba74019239" />

</details>

#### 8. `ugentexam`
<details>   
<summary> Images </summary>

**example-ugentexam-1**

<img width="50%" src="https://github.com/user-attachments/assets/1402a71c-e618-4c74-90cb-518727c3a379" />
<img width="50%" src="https://github.com/user-attachments/assets/1c4e5522-be7e-4132-8cff-f3a7fa2a9b31" />
<img width="50%" src="https://github.com/user-attachments/assets/1c227ee7-2d27-408a-88e6-b143df1b8fa2" />
<img width="50%" src="https://github.com/user-attachments/assets/e3a47acd-5dbd-4cf8-af67-4056f2e17ed2" />


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

