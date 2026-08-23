% MISiS article template — оформление по Article_1.docx
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{misisarticle}[2026/08/22 v1.0 MISiS article template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt, a4paper]{article}

\author{}
\date{}

\RequirePackage[
  top=1.9cm,
  bottom=2.54cm,
  left=1.6cm,
  right=1.6cm,
  headheight=14pt,
  headsep=0.5cm,
  footskip=1cm
]{geometry}

\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setdefaultlanguage{russian}
\setotherlanguage{english}

\RequirePackage{etoolbox}
\RequirePackage{microtype}
\RequirePackage{graphicx}
\RequirePackage{amsmath, amssymb}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{indentfirst}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage[hyphens]{url}
\RequirePackage{hyperref}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  pdfborder={0 0 0}
}

% --- Шрифт Times New Roman (как в docx) ---
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}[
    Ligatures=TeX,
    BoldFont={Times New Roman Bold},
    ItalicFont={Times New Roman Italic},
    BoldItalicFont={Times New Roman Bold Italic},
  ]%
  \newfontfamily\cyrillicfont{Times New Roman}[
    Ligatures=TeX,
    BoldFont={Times New Roman Bold},
    ItalicFont={Times New Roman Italic},
    BoldItalicFont={Times New Roman Bold Italic},
  ]%
  \newfontfamily\cyrillicfontsf{Times New Roman}[
    BoldFont={Times New Roman Bold},
    ItalicFont={Times New Roman Italic},
    BoldItalicFont={Times New Roman Bold Italic},
  ]%
  \newfontfamily\cyrillicfonttt{Courier New}%
}{%
  \setmainfont{TeX Gyre Termes}[Ligatures=TeX]%
  \newfontfamily\cyrillicfont{TeX Gyre Termes}[Ligatures=TeX]%
  \newfontfamily\cyrillicfontsf{TeX Gyre Termes}%
  \newfontfamily\cyrillicfonttt{TeX Gyre Cursor}%
}

% --- Основной текст: 12 pt, абзацный отступ 0.51 cm ---
\setlength{\parindent}{0.51cm}
\setlength{\parskip}{0pt plus 1pt minus 1pt}
\setstretch{1.0}

% --- Списки ---
\setlist[itemize]{
  label=\textbullet,
  leftmargin=1.02cm,
  labelsep=0.35cm,
  topsep=0pt,
  partopsep=0pt,
  itemsep=0pt,
  parsep=0pt
}

% --- Классификационные коды (ГРНТИ, ASJC, OECD) ---
\newcommand{\@grnticodes}{}
\newcommand{\@asjccodes}{}
\newcommand{\@oecdcodes}{}
\newcommand{\grnti}[1]{\gdef\@grnticodes{#1}}
\newcommand{\asjc}[1]{\gdef\@asjccodes{#1}}
\newcommand{\oecd}[1]{\gdef\@oecdcodes{#1}}

\newcommand{\@classificationblock}{%
  {\fontsize{12}{14}\selectfont
    \raggedright
    \ifx\@grnticodes\empty\else
      ГРНТИ коды\par\@grnticodes\par
    \fi
    \ifx\@asjccodes\empty\else
      ASJC коды\par\@asjccodes\par
    \fi
    \ifx\@oecdcodes\empty\else
      OECD коды\par\@oecdcodes\par
    \fi
    \vspace{0.4\baselineskip}%
  }%
}

% --- Авторы ---
\newcommand{\@authorblocks}{}
\newcommand{\misisauthor}[4]{%
  \g@addto@macro\@authorblocks{%
    {\fontsize{11}{13}\selectfont
      #1\par
      #2\par
      #3\par
      \href{mailto:#4}{#4}\par
      \vspace{0.35\baselineskip}%
    }%
  }%
}

% --- Аннотация и ключевые слова ---
% article.cls уже определяет окружение abstract — переопределяем
\let\abstract\relax
\let\endabstract\relax
\newcommand{\@abstracttext}{}
\newcommand{\@keywordstext}{}
\newcommand{\setabstract}[1]{\gdef\@abstracttext{#1}}
\newcommand{\setkeywords}[1]{\gdef\@keywordstext{#1}}
\newcommand{\abstract}[1]{\setabstract{#1}}
\newcommand{\keywords}[1]{\setkeywords{#1}}

% --- Заголовок ---
\renewcommand{\maketitle}{%
  \thispagestyle{empty}%
  \@classificationblock
  \begin{center}
    {\fontsize{24}{28}\selectfont \@title\par}
    \vspace{0.6\baselineskip}
    \@authorblocks
  \end{center}
  \vspace{0.2\baselineskip}
  \ifx\@abstracttext\empty\else
    {\parindent=0.51cm
     \textbf{Аннотация}—\@abstracttext\par
     \vspace{0.35\baselineskip}}%
  \fi
  \ifx\@keywordstext\empty\else
    {\parindent=0.48cm
     \textit{Ключевые слова — \@keywordstext}\par
     \vspace{0.35\baselineskip}}%
  \fi
}

% --- Разделы (heading 1: small caps; heading 2: italic) ---
\setcounter{secnumdepth}{0}
\titleformat{\section}
  {\normalfont\scshape\raggedright}
  {}
  {0pt}
  {}
\titlespacing*{\section}{0pt}{8pt}{4pt}

\titleformat{\subsection}
  {\normalfont\itshape\raggedright}
  {}
  {0pt}
  {}
\titlespacing*{\subsection}{0pt}{6pt}{3pt}

\titleformat{\subsubsection}
  {\normalfont\itshape\justifying}
  {}
  {0pt}
  {}
\titlespacing*{\subsubsection}{0pt}{4pt}{2pt}

% --- Подписи рисунков и таблиц ---
\addto\captionsrussian{%
  \renewcommand{\figurename}{Рис.}%
  \renewcommand{\tablename}{Таблица}%
}

\renewcommand{\thetable}{\Roman{table}}

\captionsetup[figure]{
  font={footnotesize},
  labelfont={footnotesize},
  labelsep=period,
  skip=4pt,
  justification=centering
}

\captionsetup[table]{
  font={footnotesize},
  labelformat=simple,
  labelfont={footnotesize},
  textfont={footnotesize},
  labelsep=period,
  skip=6pt,
  position=above,
  justification=centering
}
\DeclareCaptionLabelFormat{misistable}{\scshape #1~#2}
\captionsetup[table]{labelformat=misistable}

% Текст в таблице — 8 pt
\AtBeginEnvironment{table}{\small}

% --- Формулы ---
\setlength{\abovedisplayskip}{8pt plus 2pt minus 2pt}
\setlength{\belowdisplayskip}{8pt plus 2pt minus 2pt}

% --- Список литературы ---
\renewcommand{\refname}{Литература}

\AtBeginEnvironment{thebibliography}{%
  \small
  \setlength{\itemsep}{2pt plus 1pt minus 1pt}%
  \setlength{\parsep}{0pt}%
}

\endinput
