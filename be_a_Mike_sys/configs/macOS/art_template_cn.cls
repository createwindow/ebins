\ProvidesClass{art_template_cn}[2016/10/10 v1.0 Chinese article class]

\LoadClass[a4paper, zihao=5, hyperref]{ctexart}

\RequirePackage{graphicx}
\RequirePackage[textwidth=14.66cm, textheight=24.8cm, top=2.5cm, headsep=0.8cm, footskip=1.5cm]{geometry}
\RequirePackage{enumitem} % DO NOT use it for beamer
\RequirePackage{cite} % DO NOT use it for beamer
\RequirePackage{listings}
\RequirePackage{color}
\RequirePackage{url}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{placeins} % to use \FloatBarrie
\RequirePackage{subfigure}
\RequirePackage{longtable}
\RequirePackage{amsmath}
%\RequirePackage{makecell} % make tables more professional
\RequirePackage{msc} % Message Sequence Charts
\RequirePackage{makeidx} % fix quotes in lstlisting env
\RequirePackage{txfonts} % fix quotes in lstlisting env 
\RequirePackage[T1]{fontenc}
%\RequirePackage{fontspec} % font select for xelatex
% fancyvrb, listings provide similar functions. shortvrb defines a command \MakeShortVerb that makes a single character active, expanding to give the effect of a \verb command. Thus, after \MakeShortVerb{\|}, the text |stuff| has the same effect as \verb|stuff|. Package array, then you can avoid conflict with tabular environment. Besides |, " is also a good choice.
\RequirePackage{shortvrb} 
\MakeShortVerb{"}

\CTEXsetup[format+={\zihao{-3}\raggedright}]{section}
\CTEXsetup[format+={\zihao{4}}]{subsection}

% enumitem environment
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=2.5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=2.5pt}
\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=2.5pt}
\setenumerate{leftmargin=2\ccwd, labelsep=1\ccwd}
\setitemize{leftmargin=2\ccwd, labelsep=1\ccwd}

% allow ot use "caption" variants outside figure or table env. Useful for non-floating images/tabs.
\makeatletter
  \newcommand\figcaption{\def\@captype{figure}\caption}
  \newcommand\tabcaption{\def\@captype{table}\caption}
\makeatother


% listlisting environment
\lstset{%general command to set paramters
	basicstyle=\small,
	%numbers=right,
	%numberstyle=\footnotesize
	stepnumber=1,
	numbersep=8pt,
    escapechar=`, %for national charaters
    tabsize=4,
    %keywordstyle=\color{black}\bfseries,
    keywordstyle=\color{blue!70},
    commentstyle=\color[rgb]{0.233,0.645,0.233},
    frame=single, % single/shadowbox
    rulesepcolor=\color[rgb]{0.20,0.20,0.20},
    %commentstyle=\color{green},
    stringstyle=\ttfamily,
    xleftmargin=1em,
    xrightmargin=1em,
    aboveskip=1em,
    showstringspaces=false,
    showtabs=false,
    showspaces=false,
    breaklines=true,
    breakatwhitespace=true,
    captionpos=b,
    basewidth=0.55em,
    fontadjust=true,
    backgroundcolor=\color[rgb]{0.95,0.95,0.95},
    extendedchars=false,
}

%define Javascript language
\definecolor{lightgray}{rgb}{.9,.9,.9}
\definecolor{darkgray}{rgb}{.4,.4,.4}
\definecolor{purple}{rgb}{0.65, 0.12, 0.82}

\lstdefinelanguage{JavaScript}{
    keywords={typeof, new, true, false, catch, function, return, null, catch, switch, var, if, in, while, do, else, case, break},
    keywordstyle=\color{blue!70}\bfseries,
    ndkeywords={class, export, boolean, throw, implements, import, this},
    ndkeywordstyle=\color{darkgray}\bfseries,
    identifierstyle=\color{black},
    sensitive=false,
    comment=[l]{//},
    morecomment=[s]{/*}{*/},
    commentstyle=\color{purple}\ttfamily,
    stringstyle=\color{red}\ttfamily,
    morestring=[b]',
    morestring=[b]"
}

\lstset{
    language=JavaScript,
    extendedchars=true,
    basicstyle=\footnotesize\ttfamily,
    showstringspaces=false,
    showspaces=false,
    %numbers=left,
    %numberstyle=\footnotesize,
    %numbersep=9pt,
    tabsize=2,
    breaklines=true,
    showtabs=false,
    captionpos=b
}

\RequirePackage{fancyhdr}
\fancyhf{}
\lhead{\textnormal{\kaishu\rightmark}}
\rhead{\thepage}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}

% msc
\renewcommand\msckeyword{} 
\renewcommand\hmsckeyword{}
\renewcommand\mscdockeyword{}

\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}