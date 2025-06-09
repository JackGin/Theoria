%===============================================================================
% Theoria.cls (v0.2k) — modern physics‑paper class
%===============================================================================
% This class provides:
%   • Libertinus text + NewTX math + Mathalfa for extended alphabets
%   • Single‑column layout with wide margins for readability
%   • Sans‑serif, bold section headings with colored underlines
%   • Decorative drop‑caps via lettrine
%   • Boxed abstract with soft background and compact font
%   • Upright, footnotesize captions with colored rule above
%   • Automatic, deduplicated numbering for authors & affiliations
%   • Per-author email/corresponding-author support printed as symbol footnotes
%===============================================================================
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{Theoria}[2025/06/08 v0.2j Modern physics‑paper class]

%===============================================================================
% 1) Base class options passthrough and loading
%===============================================================================
\DeclareOption*{%
  % Forward unknown options (e.g., journal flags) to article
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass[12pt,onecolumn]{article}
% suppress date output unless explicitly set
\date{}

%===============================================================================
% 2) Font encoding and setup
%===============================================================================
\RequirePackage[T1]{fontenc}% proper hyphenation and accents
\RequirePackage{libertinus}% Libertinus text font
\RequirePackage[libertinus,upint]{newtxmath}% NewTX math aligned to Libertinus
\RequirePackage[cal=stixtwofancy,frak=stixtwo]{mathalfa}% Extended math alphabets

%===============================================================================
% 3) Core packages: graphics, microtype, math, and citations
%===============================================================================
\RequirePackage{graphicx}% image inclusion
\RequirePackage{microtype}% margin & font protrusion
\RequirePackage{mathtools}% amsmath extensions
\RequirePackage{bm}% bold math symbols
\RequirePackage{xcolor}% color management
\RequirePackage[numbers,sort&compress]{natbib}% numeric, sorted/compressed cites

%===============================================================================
% 4) Hyperref and colors
%===============================================================================
\definecolor{linkcolor}{cmyk}{0.6,0.3,0,0.9}% deep blue
\RequirePackage[%
  colorlinks=true,% colored text links
  linkcolor=linkcolor!60,% internal
  citecolor=linkcolor!60,% citations
  urlcolor=linkcolor!60% URLs
]{hyperref}
% Background for abstract box
\definecolor{boxcolor}{cmyk}{1,0.5,0,0.1}

%===============================================================================
% 5) Page geometry
%===============================================================================
\RequirePackage{geometry}
\geometry{a4paper,centering,margin=3.5cm}

%===============================================================================
% 6) Section heading styling with colored underline
%===============================================================================
\RequirePackage{titlesec}
\newcommand{\sectionrule}{%
  \vskip-0.5em
  \noindent
  {\color{linkcolor!60}\rule[0.3ex]{\columnwidth}{0.8pt}}%
  \vskip0.8em
}
\titleformat{\section}[block]
  {\Large\bfseries\sffamily}{\thesection}{1em}{}[\sectionrule]
\titleformat{\subsection}[block]
  {\large\bfseries\sffamily}{\thesubsection}{1em}{}
\titleformat{\subsubsection}[block]
  {\bfseries\sffamily}{\thesubsubsection}{1em}{}

%===============================================================================
% 7) Decorative drop-caps via lettrine
%===============================================================================
\RequirePackage{lettrine}
\newcommand{\firstletter}[1]{%
  \lettrine[lines=2,lhang=0.1,nindent=0em]{{%
    \sffamily\bfseries\color{linkcolor!60}#1
  }}{}
}

%===============================================================================
% 8) Author, affiliation & email handling
%===============================================================================
\RequirePackage{etoolbox}% for \ifx, \protected@xdef, etc.
\makeatletter
  %–– counters ––
  \newcounter{authorctr}%
  \newcounter{affilctr}%
  \newcounter{emailctr}%

  %–– capture each \author{Name} ––
  \renewcommand{\author}[1]{%
    \stepcounter{authorctr}% increment author count
    \expandafter\gdef\csname Theoria@author@\theauthorctr\endcsname{#1}%
  }%

  %–– deduplicate + store affiliation text ––
  \newcommand{\affiliation}[1]{%
    \begingroup
      \expandafter\ifx\csname foundaffil@\detokenize{#1}\endcsname\relax
        \stepcounter{affilctr}% new affiliation index
        \expandafter\protected@xdef\csname foundaffil@\detokenize{#1}\endcsname{\theaffilctr}%
        \expandafter\gdef\csname Theoria@affiltext@\theaffilctr\endcsname{#1}%
      \fi
    \endgroup
    % record this author→affiliation link
    \expandafter\gdef\csname Theoria@authoraffil@\theauthorctr\endcsname{%
      \csname foundaffil@\detokenize{#1}\endcsname
    }%
  }%

  %–– per‐author email (marks corresponding authors) ––
  \newcommand{\email}[1]{%
    \stepcounter{emailctr}% assign next symbol index
    \expandafter\gdef\csname Theoria@authoremail@\theauthorctr\endcsname{#1}%
  }%

  %------------------------------------------------------------------------------%
  % Print author list: 
  %  • if multiple affiliations → name¹ + … ; if single → no affiliation num.
  %  • always append email symbol if \email was used
  %------------------------------------------------------------------------------%
  \newcommand{\printauthors}{%
    {%
      \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
      \setcounter{footnote}{1}%
      \@tempcnta=1
      \loop
        \ifnum\@tempcnta>\value{authorctr}\else
          % name
          \csname Theoria@author@\the\@tempcnta\endcsname
          % affiliation number if >1 different affils
          \ifnum\value{affilctr}>1
            \@ifundefined{Theoria@authoraffil@\the\@tempcnta}{}{%
              \textsuperscript{%
                \csname Theoria@authoraffil@\the\@tempcnta\endcsname
              }%
            }%
          \fi
          % email symbol if defined
          \@ifundefined{Theoria@authoremail@\the\@tempcnta}{}{%
            \textsuperscript{\fnsymbol{footnote}}%
            \stepcounter{footnote}%
          }%
          % comma separation
          \ifnum\@tempcnta<\value{authorctr}, \fi\ 
          \advance\@tempcnta by1
      \repeat
    }%
  }%

  %------------------------------------------------------------------------------%
  % Print affiliation list:
  %  • numbered if >1; otherwise the lone text
  %------------------------------------------------------------------------------%
  \newcommand{\printaffils}{%
    \ifnum\value{affilctr}>1
      \@tempcnta=1
      \loop
        \ifnum\@tempcnta>\value{affilctr}\else
          \textsuperscript{\the\@tempcnta}\space%
          \csname Theoria@affiltext@\the\@tempcnta\endcsname\par
          \advance\@tempcnta by1
      \repeat
    \else
      \csname Theoria@affiltext@1\endcsname\par
    \fi
  }%

  %------------------------------------------------------------------------------%
  % Custom \maketitle: title, authors, affiliations, email footnotes, date
  %------------------------------------------------------------------------------%
  \renewcommand{\maketitle}{%
    \begin{flushleft}
      {\LARGE\bfseries\@title\par}\vskip1.5em
      {\large\printauthors\par}\vskip0.5em
      {\normalsize\itshape\printaffils}\vskip1em
      % symbol‐footnotes for corresponding‐author emails
      {\renewcommand{\thefootnote}{\fnsymbol{footnote}}%
       \setcounter{footnote}{1}%
       \@tempcnta=1
       \loop
         \ifnum\@tempcnta>\value{authorctr}\else
           \@ifundefined{Theoria@authoremail@\the\@tempcnta}{}{%
             \footnotetext[\value{footnote}]{%
               Corresponding author:~%
               \href{mailto:\csname Theoria@authoremail@\the\@tempcnta\endcsname}{%
                 \csname Theoria@authoremail@\the\@tempcnta\endcsname
               }%
             }%
             \stepcounter{footnote}%
           }%
           \advance\@tempcnta by1
       \repeat
      }%
      % restore arabic footnotes
      \setcounter{footnote}{0}\renewcommand{\thefootnote}{\arabic{footnote}}%
      {\@date\par}
    \end{flushleft}%
  }%
\makeatother

%===============================================================================
% 9) Boxed abstract environment
%===============================================================================
\RequirePackage{tcolorbox}
\newtcolorbox{abstractbox}{%
  arc=0pt,boxrule=0pt,colback=boxcolor!20,boxsep=1em,
  left=0pt,right=0pt,top=0pt,bottom=0pt,width=\columnwidth
}
\renewenvironment{abstract}{%
  \noindent
  \begin{minipage}{0.9\columnwidth}
    \upshape\sffamily
    \begin{abstractbox}\fontsize{9}{14}\selectfont
}{%
    \end{abstractbox}%
  \end{minipage}\vskip2em
}

%===============================================================================
%10) Caption styling — rule above, footnotesize upright text
%===============================================================================
\RequirePackage[
  labelfont={bf,footnotesize},% bold, small
  textfont={footnotesize},% small caption text
  labelsep=colon,% “Figure 1:” style
  skip=1ex,% vertical space
  singlelinecheck=false,% allow full justification
  justification=justified% fully justified
]{caption}

\DeclareCaptionFormat{ruleabove}{%
  {\color{linkcolor!60}\rule[0.3ex]{\columnwidth}{0.6pt}}\par\vskip0.4ex#1#2#3
}
\captionsetup{format=ruleabove,margin=0pt}

%===============================================================================
%11) Bibliography style & size
%===============================================================================
\AtBeginDocument{\bibliographystyle{apsrev4-2}}
\AtBeginEnvironment{thebibliography}{\footnotesize}
