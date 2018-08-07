\ProvidesClass{ppt_template_cn}[2016/10/10 v1.0 Chinese article class]

\LoadClass{beamer}
\RequirePackage{ctex}
\RequirePackage{graphicx}
%\RequirePackage{enumitem} % DO NOT use it for beamer
%\RequirePackage{cite} % DO NOT use it for beamer
\RequirePackage{listings}
\RequirePackage{color}
\RequirePackage{url}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{placeins} % to use \FloatBarrie
\RequirePackage{subfigure}
\RequirePackage{longtable}
%\RequirePackage{makecell} % make tables more professional
\RequirePackage{msc} % Message Sequence Charts
\RequirePackage{makeidx} % fix quotes in lstlisting env
\RequirePackage{txfonts} % fix quotes in lstlisting env 
\RequirePackage[T1]{fontenc}
%\RequirePackage{fontspec} % font select for xelatex
\RequirePackage{booktabs} % Allows the use of \toprule, \midrule and \bottomrule in tables
% fancyvrb, listings provide similar functions. shortvrb defines a command \MakeShortVerb that makes a single character active, expanding to give the effect of a \verb command. Thus, after \MakeShortVerb{\|}, the text |stuff| has the same effect as \verb|stuff|. Package array, then you can avoid conflict with tabular environment. Besides |, " is also a good choice.
\RequirePackage{shortvrb} 
\MakeShortVerb{"}
\RequirePackage{setspace} 

% allow ot use "caption" variants outside figure or table env. Useful for non-floating images/tabs.
\makeatletter
  \newcommand\figcaption{\def\@captype{figure}\caption}
  \newcommand\tabcaption{\def\@captype{table}\caption}
\makeatother

% listlisting
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
    basewidth=0.57em, %0.55em
    fontadjust=true,
    backgroundcolor=\color[rgb]{0.95,0.95,0.95},
    extendedchars=false,
}

% msc
\renewcommand\msckeyword{} 
\renewcommand\hmsckeyword{}
\renewcommand\mscdockeyword{}

\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}

\let\oldframetitle\frametitle % Store \frametitle in \oldframetitle
\renewcommand{\frametitle}[1]{\oldframetitle{#1}\setstretch{1.2}}
