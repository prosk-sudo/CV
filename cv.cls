\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2026/07/15 CV class based on the RenderCV sb2nov template]

% Class options:
%   german - German hyphenation (babel) and footer wording
\newif\ifcv@german
\DeclareOption{german}{\cv@germantrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[10pt, letterpaper]{article}

% Packages:
\RequirePackage[
    ignoreheadfoot, % set margins without considering header and footer
    top=2 cm, % seperation between body and page edge from the top
    bottom=2 cm, % seperation between body and page edge from the bottom
    left=2 cm, % seperation between body and page edge from the left
    right=2 cm, % seperation between body and page edge from the right
    footskip=1.0 cm, % seperation between body and footer
    % showframe % for debugging
]{geometry} % for adjusting page geometry
\RequirePackage{etoolbox} % for \patchcmd and \AtBeginEnvironment
\RequirePackage{titlesec} % for customizing section titles
\RequirePackage{tabularx} % for making tables with fixed width columns
\RequirePackage{array} % tabularx requires this
\RequirePackage[dvipsnames]{xcolor} % for coloring text
\definecolor{primaryColor}{RGB}{0, 79, 144} % define primary color
\RequirePackage{enumitem} % for customizing lists
\RequirePackage{fontawesome5} % for using icons
\RequirePackage{amsmath} % for math
\ifcv@german
    \RequirePackage[ngerman]{babel} % German hyphenation and typography
\fi
\RequirePackage[
    pdfcreator={LaTeX with RenderCV},
    colorlinks=true,
    urlcolor=primaryColor
]{hyperref} % for links, metadata and bookmarks; set pdftitle/pdfauthor via \hypersetup per document
\RequirePackage[pscoord]{eso-pic} % for floating text on the page
\RequirePackage{calc} % for calculating lengths
\RequirePackage{bookmark} % for bookmarks
\RequirePackage{lastpage} % for getting the total number of pages
\RequirePackage{changepage} % for one column entries (adjustwidth environment)
\RequirePackage{paracol} % for two and three column entries
\RequirePackage{ifthen} % for conditional statements
\RequirePackage{needspace} % for avoiding page brake right after the section title
\RequirePackage{iftex} % check if engine is pdflatex, xetex or luatex

% Ensure that generate pdf is machine readable/ATS parsable:
\ifPDFTeX
    \input{glyphtounicode}
    \pdfgentounicode=1
    % \RequirePackage[T1]{fontenc} % this breaks sb2nov
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{lmodern}
\fi

% Language-dependent footer wording:
\ifcv@german
    \def\cv@pageword{Seite}
    \def\cv@ofword{von}
\else
    \def\cv@pageword{Page}
    \def\cv@ofword{of}
\fi

% Document metadata, set in the .tex file before \begin{document}:
\def\cv@name{}
\newcommand{\cvname}[1]{\def\cv@name{#1}}
\def\cv@lastupdated{}
\newcommand{\cvlastupdated}[1]{\def\cv@lastupdated{#1}}

% Some settings:
\AtBeginEnvironment{adjustwidth}{\partopsep0pt} % remove space before adjustwidth environment
\pagestyle{empty} % no header or footer
\setcounter{secnumdepth}{0} % no section numbering
\setlength{\parindent}{0pt} % no indentation
\setlength{\topskip}{0pt} % no top skip
\setlength{\columnsep}{0cm} % set column seperation

\let\ps@customFooterStyle\ps@plain % Copy the plain style to customFooterStyle
\patchcmd{\ps@customFooterStyle}{\thepage}{
    \color{gray}\textit{\small \cv@name{} - \cv@pageword{} \thepage{} \cv@ofword{} \pageref*{LastPage}}
}{}{} % replace number by desired string
\pagestyle{customFooterStyle}

\titleformat{\section}{\needspace{4\baselineskip}\bfseries\large}{}{0pt}{}[\vspace{1pt}\titlerule]

\titlespacing{\section}{
    % left space:
    -1pt
}{
    % top space:
    0.3 cm
}{
    % bottom space:
    0.2 cm
} % section title spacing

\renewcommand\labelitemi{$\circ$} % custom bullet points
\newenvironment{highlights}{
    \begin{itemize}[
        topsep=0.10 cm,
        parsep=0.10 cm,
        partopsep=0pt,
        itemsep=0pt,
        leftmargin=0.4 cm + 10pt
    ]
}{
    \end{itemize}
} % new environment for highlights

\newenvironment{highlightsforbulletentries}{
    \begin{itemize}[
        topsep=0.10 cm,
        parsep=0.10 cm,
        partopsep=0pt,
        itemsep=0pt,
        leftmargin=10pt
    ]
}{
    \end{itemize}
} % new environment for highlights for bullet entries

\newenvironment{onecolentry}{
    \begin{adjustwidth}{
        0.2 cm + 0.00001 cm
    }{
        0.2 cm + 0.00001 cm
    }
}{
    \end{adjustwidth}
} % new environment for one column entries

\newenvironment{twocolentry}[2][]{
    \onecolentry
    \def\secondColumn{#2}
    \setcolumnwidth{\fill, 4.5 cm}
    \begin{paracol}{2}
}{
    \switchcolumn \raggedleft \secondColumn
    \end{paracol}
    \endonecolentry
} % new environment for two column entries

\newenvironment{header}{
    \setlength{\topsep}{0pt}\par\kern\topsep\centering\linespread{1.5}
}{
    \par\kern\topsep
} % new environment for the header

\newcommand{\placelastupdatedtext}{% \placetextbox{<horizontal pos>}{<vertical pos>}{<stuff>}
  \AddToShipoutPictureFG*{% Add <stuff> to current page foreground
    \put(
        \LenToUnit{\paperwidth-2 cm-0.2 cm+0.05cm},
        \LenToUnit{\paperheight-1.0 cm}
    ){\vtop{{\null}\makebox[0pt][c]{
        \small\color{gray}\textit{\cv@lastupdated}\hspace{\widthof{\cv@lastupdated}}
    }}}%
  }%
}%

% save the original href command in a new command:
\let\hrefWithoutArrow\href

% new command for external links:
\renewcommand{\href}[2]{\hrefWithoutArrow{#1}{\ifthenelse{\equal{#2}{}}{ }{#2 }\raisebox{.15ex}{\footnotesize \faExternalLink*}}}

% separator between header contact items:
\newcommand{\AND}{\unskip
    \cleaders\copy\ANDbox\hskip\wd\ANDbox
    \ignorespaces
}
\newsavebox\ANDbox
\sbox\ANDbox{}
