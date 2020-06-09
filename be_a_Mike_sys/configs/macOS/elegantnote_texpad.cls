\ProvidesClass{elegantnote_texpad}[2020/04/12 ElegantNote v2.30 class]
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{CJKutf8}
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}

\SetupKeyvalOptions{family=ELEGANT,prefix=ELEGANT@,setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{ELEGANT}{#1}}

\DeclareStringOption[blue]{color}
\DeclareVoidOption{green}{\ekv{color=green}}
\DeclareVoidOption{cyan}{\ekv{color=cyan}}
\DeclareVoidOption{blue}{\ekv{color=blue}}
\DeclareVoidOption{sakura}{\ekv{color=sakura}}
\DeclareVoidOption{black}{\ekv{color=black}}

\DeclareStringOption[pad]{device}
\DeclareVoidOption{pc}{\ekv{device=pc}}
\DeclareVoidOption{pad}{\ekv{device=pad}}
\DeclareVoidOption{kindle}{\ekv{device=kindle}}
\DeclareVoidOption{normal}{\ekv{device=normal}}
\DeclareVoidOption{screen}{\ekv{device=screen}}

\DeclareStringOption[cn]{lang}
\DeclareVoidOption{cn}{\ekv{lang=cn}}
\DeclareVoidOption{en}{\ekv{lang=en}}

\DeclareStringOption{mode}
\DeclareVoidOption{geye}{\ekv{mode=geye}}
\DeclareVoidOption{hazy}{\ekv{mode=hazy}}

\DeclareStringOption[ctexfont]{chinesefont}
\DeclareVoidOption{ctexfont}{\ekv{chinesefont=ctexfont}}
\DeclareVoidOption{founder}{\ekv{chinesefont=founder}}
\DeclareVoidOption{nofont}{\ekv{chinesefont=nofont}}

\DeclareStringOption[numbers]{cite}
\DeclareVoidOption{numbers}{\ekv{cite=numbers}}
\DeclareVoidOption{authoryear}{\ekv{cite=authoryear}}
\DeclareVoidOption{super}{\ekv{cite=super}}

\DeclareStringOption[apalike]{bibstyle}

\DeclareStringOption[11pt]{fontsize}
\DeclareVoidOption{10pt}{\ekv{fontsize=10pt}}
\DeclareVoidOption{11pt}{\ekv{fontsize=11pt}}
\DeclareVoidOption{12pt}{\ekv{fontsize=12pt}}

\DeclareStringOption[cm]{math}
\DeclareVoidOption{newtx}{\ekv{math=newtx}}
\DeclareVoidOption{mtpro2}{\ekv{math=mtpro2}}
\DeclareVoidOption{cm}{\ekv{math=cm}}

\DeclareDefaultOption{
  \PassOptionsToClass{\CurrentOption}{article}
 }
\ProcessKeyvalOptions*\relax

\LoadClass{article}

\PassOptionsToPackage{no-math}{fontspec}
\RequirePackage{amsmath,amsthm}

\RequirePackage{iftex}
\RequirePackage{newtxtext}
\ifdefstring{\ELEGANT@math}{newtx}{
  \RequirePackage{newtxmath}
  \let\Bbbk\relax
  \RequirePackage{esint}
  %%% use yhmath pkg, uncomment following code
  % \let\oldwidering\widering
  % \let\widering\undefined
  % \RequirePackage{yhmath}
  % \let\widering\oldwidering

  %%% use esvect pkg, uncomment following code
  % \RequirePackage{esvect}

  \DeclareSymbolFont{CMlargesymbols}{OMX}{cmex}{m}{n}
  \let\sumop\relax\let\prodop\relax
  \DeclareMathSymbol{\sumop}{\mathop}{CMlargesymbols}{"50}
  \DeclareMathSymbol{\prodop}{\mathop}{CMlargesymbols}{"51}
}{\relax}


\RequirePackage{indentfirst}
\RequirePackage{anyfontsize}

\RequirePackage{graphicx}
\RequirePackage{booktabs}
\let\openbox\relax

\RequirePackage{xcolor}
\definecolor{winered}{rgb}{0.5,0,0}
\definecolor{epubblue}{RGB}{1,126,218}

\RequirePackage{hyperref}
\RequirePackage{xpatch}
\hypersetup{%
  pdfborder={0 0 0},
  colorlinks,
  citecolor=ecolor,
  filecolor=ecolor,
  linkcolor=ecolor,
  urlcolor=ecolor
}

\RequirePackage{hologo}

% 行距设置
\linespread{1.3}
\setlength{\parskip}{3mm}
\setlength{\parindent}{2em}
% 定义护眼模式 geye=true
\RequirePackage{xcolor}
\RequirePackage{silence}

% good for eye color 
\ifdefstring{\ELEGANT@mode}{geye}{
  %\definecolor{geyecolor}{RGB}{199,237,204}%
  \definecolor{geyecolor}{RGB}{240,235,218}%
  \pagecolor{geyecolor}
}{\relax}
\ifdefstring{\ELEGANT@mode}{hazy}{
  \definecolor{geyecolor}{RGB}{251,250,248}%
  \pagecolor{geyecolor}
}{\relax}


% graphics path
\graphicspath{
  {./figure/}
  {./figures/}
  {./image/}
  {./images/}
  {./graphics/}
  {./graphic/}
  {./pictures/}
  {./picture/}
}

\let\openbox\relax
\newtheoremstyle{plain}{\topsep}{\topsep}{\citshape}{}{%
  \color{ecolor}\bfseries}{}{%
  0.5em}{%
  \thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}}

\newtheoremstyle{definition}{\topsep}{\topsep}{\citshape}{}{%
  \color{ecolor}\bfseries}{}{%
  0.5em}{}

\newtheoremstyle{remark}{\topsep}{\topsep}{\cnormal}{}{
  \color{ecolor}\bfseries}{}{
  0.5em}{}

% caption settings 
\RequirePackage{caption} 
\captionsetup{
  labelfont={bf,color=ecolor}}
\captionsetup[table]{skip=3pt}
\captionsetup[figure]{skip=3pt}

% list/itemize/enumerate setting
\RequirePackage[shortlabels,inline]{enumitem}
\setlist{nolistsep}

\RequirePackage[flushmargin,stable]{footmisc}
\setlength{\footnotesep}{12pt}

\RequirePackage{titlesec}
\titleformat*{\section}{\normalfont\Large\bfseries\color{ecolor}}
\titleformat*{\subsection}{\normalfont\large\bfseries\color{ecolor}}
\titleformat*{\subsubsection}{\normalfont\normalsize\bfseries\color{ecolor}}

\ifdefstring{\ELEGANT@color}{green}{
  \definecolor{ecolor}{RGB}{0,120,2}%
}{\relax}
\ifdefstring{\ELEGANT@color}{cyan}{
  \definecolor{ecolor}{RGB}{31,186,190}%
}{\relax}
\ifdefstring{\ELEGANT@color}{blue}{
  \definecolor{ecolor}{RGB}{1,126,218}%
}{\relax}
\ifdefstring{\ELEGANT@color}{sakura}{
  \definecolor{ecolor}{RGB}{255,183,197}%
}{\relax}
\ifdefstring{\ELEGANT@color}{black}{
  \definecolor{ecolor}{RGB}{0,0,0}%
}{\relax}

\definecolor{egreen}{RGB}{0,120,2}
\definecolor{ecyan}{RGB}{0,175,152}
\definecolor{eblue}{RGB}{20,50,104}
\definecolor{sakura}{RGB}{255,183,197}

%% device settings
%% default=pad

\RequirePackage{geometry}
\WarningsOff
\RequirePackage[\ELEGANT@fontsize]{extsizes}
\WarningsOn

\ifdefstring{\ELEGANT@device}{pad}{%
  \geometry{
    paperwidth=6in,
    paperheight=8in,
    includefoot,
    margin=8mm}}{%
  \relax}

\ifdefstring{\ELEGANT@device}{pc}{
  \geometry{%
    margin=8mm,
    paperwidth=6.2in,
    paperheight=6in,
    includefoot}}{%
  \relax}

\ifdefstring{\ELEGANT@device}{kindle}{%
  \geometry{
    margin=8mm,
    paperwidth=3.68in, 
    paperheight=4.92in}}{%
  \relax}

\ifdefstring{\ELEGANT@device}{normal}{%
  \geometry{
    margin=1in,
    a4paper}}{%
  \relax}

\ifdefstring{\ELEGANT@device}{screen}{%  
  \geometry{
    screen,
    paperwidth=25.4cm,
    paperheight=19.05cm,
    margin=1.6cm,
    headheight=2.17cm,
    footskip=0.6cm}}{%
  \relax}

% headings
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{fancy-note}{
  \fancyhf{} % clear header/footer settings
  \fancyfoot[C]{\footnotesize\textcolor{gray}{\thepage}}
}

\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[R]{\footnotesize\textcolor{gray}{\thepage}}}

\pagestyle{fancy-note}

%\setlength{\bibsep}{0.0pt}
%\def\bibfont{\footnotesize}

\def\IfEmpty#1{%
  \edef\1{\the#1}
  \ifx\1\empty}

\newtoks\version
\newtoks\institute

\def \ifempty#1{
  \def\temp{#1} 
  \ifx\temp\empty}

\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
         \hb@xt@1.8em{%
           \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      %\newpage%
      \global\@topnum\z@  % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{empty}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@ELEGANT@version\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\ELEGANT@version\relax}

\def\@maketitle{%
  \color{ecolor}
  \null
  \vskip 2em%
  \begin{center}%
    \let \footnote \thanks{%
      \LARGE\bfseries \@title \par}%
    \vskip 1.5em {%
      \large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author\\
        \the\institute
      \end{tabular}\par}%

  \IfEmpty\version
  \else
%    {\normalfont\citshape\versiontext\the\version \\}
    {\normalfont\versiontext\the\version \\}
  \fi
	\ifx\@date\empty
	\else
    {\normalfont\@date}%
%    {\normalfont\citshape\updatetext\@date}%
  \fi
  \end{center}%
  \par}


\RequirePackage{tikz}
\usetikzlibrary{shadows}
\newcommand*{\eitemi}{
  \tikz\draw[baseline, ball color=ecolor, draw=none] circle (2pt);}
\newcommand*{\eitemii}{
  \tikz\draw[baseline, fill=ecolor,draw=none,circular drop shadow] circle (2pt);}
\newcommand*{\eitemiii}{%
  \tikz\draw[baseline,fill=ecolor,draw=none] circle (2pt);}

\setlist[enumerate,1]{label=\color{ecolor}\arabic*.}
\setlist[enumerate,2]{label=\color{ecolor}(\alph*).}
\setlist[enumerate,3]{label=\color{ecolor}\Roman*.}
\setlist[enumerate,4]{label=\color{ecolor}\Alph*.}
\setlist[itemize,1]{label={\eitemi}}
\setlist[itemize,2]{label={\eitemii}}
\setlist[itemize,3]{label={\eitemiii}}
% source1: https://tex.stackexchange.com/questions/41408/a-five-level-deep-list
% source2: https://tex.stackexchange.com/questions/318199/change-color-of-itemize-bullet 


\RequirePackage{listings,lstautogobble}
\renewcommand{\ttdefault}{cmtt}

\lstdefinestyle{estyle}{
  basicstyle=%
    \ttfamily
    \lst@ifdisplaystyle\footnotesize\fi}

% \lstset{
%   basicstyle=\scriptsize\ttfamily,
%   style=estyle}

\definecolor{lightgrey}{rgb}{0.9,0.9,0.9}
\definecolor{frenchplum}{RGB}{190,20,83}


\lstdefinelanguage{jitsi} {
	style=estyle,
	autogobble=true,
	texcsstyle=*\color{winered},
	numbers=none,
	breaklines=true,
	keywordstyle=\color{winered},
	commentstyle=\color{gray},
	alsoletter=-,
	alsoother=<,
	morekeywords={},
	morestring=[b]",
	morestring=[b]',
	emph={%
		iq,
		conference,
		content,
		channel,
		endpoint,
		channel-bundle,
		payload-type,
		rtcp-fb,
		rtp-hdrext,
		source,
		ssrc-info,
		rtcp-mux,
		transport,
		parameter,
		candidate,
		fingerprint
	}
}

\lstdefinelanguage{sdp} {
	style=estyle,
	autogobble=true,
	texcsstyle=*\color{winered},
	numbers=none,
	breaklines=true,
	keywordstyle=\color{winered},
	commentstyle=\color{gray},
	alsoletter=-,
	alsoother=<,
	morekeywords={},
	morestring=[b]",
	morestring=[b]',
	emph={%
		rtcp,
		ice-ufrag,
		ice-pwd,
		ice-options,
		fingerprint,
		mid,
		extmap,
		rtcp-mux,
		rtpmap,
		rtcp-fb,
		fmtp,
		ssrc,
		ssrc-group,
		parameter,
		candidate,
		sctpmap,
	},
	morekeywords={%
		video,
		audio,
	}
}

\lstdefinelanguage{java} {
	style=estyle,
	autogobble=true,
	texcsstyle=*\color{winered},
	numbers=none,
	breaklines=true,
	keywordstyle=\color{winered},
	commentstyle=\color{gray},
	morekeywords={},
	morestring=[b]",
	morestring=[b]',
	emph={%
		static,
		main,
	},
	morekeywords={%
		class,
		enum,
		@Override,
		public,
		private,
		protected,
		new,
		void,
		int,
		for,
		if,
		else,
		while,
		return,
	}
}

\lstset{language=[LaTeX]TeX,
	style=estyle,
	autogobble=true,
	texcsstyle=*\color{winered},
	numbers=none,
	breaklines=true,
	keywordstyle=\color{winered},
	commentstyle=\color{gray},
	emph={%
		elegantpaper,
		fontenc,
		fontspec,
		xeCJK,
		FiraMono,
		xunicode,
		newtxmath,
		figure,
		fig,
		image,
		img,
		table,
		itemize,
		enumerate,
		newtxtext,
		newtxtt,
		ctex,
		microtype,
		description,
		times,
		newtx,
		booktabs,
		tabular,
		PDFLaTeX,
		XeLaTeX,
		type1cm,
		BibTeX,
		device,
		color,
		%mode,%
		chinesefont,
		cite,
		bibstyle,
		math,
		lang,
		amsthm},
	emphstyle={\color{frenchplum}},
	morekeywords={%
		DeclareSymbolFont,
		setCJKfamilyfont,
		SetSymbolFont,
		toprule,
		midrule,
		bottomrule,
		institute,
		version,
		includegraphics,
		setmainfont,
		setsansfont,
		setmonofont ,
		setCJKmainfont,
		setCJKsansfont,
		setCJKmonofont,
		RequirePackage,
		figref,
		pagecolor,
		definecolor,
		tabref,
		email,
		maketitle,
		keywords},
	frame=none,
	tabsize=2}



%\ProvidesClass{art_template_cn_texpad}[2016/10/10 v1.0 Chinese article class]
%
%%\LoadClass[a4paper, zihao=5, hyperref]{ctexart}
%\LoadClass[a4paper]{article}
%\RequirePackage{CJKutf8}
%\RequirePackage{graphicx}
%%\RequirePackage{hyperref}
%
%\RequirePackage[textwidth=14.66cm, textheight=24.8cm, top=2.5cm, headsep=0.8cm, footskip=1.5cm]{geometry}
%
%%\RequirePackage{enumitem} % DO NOT use it for beamer
%
%\RequirePackage{cite} % DO NOT use it for beamer
%\RequirePackage{listings}
%\RequirePackage{color}
%\RequirePackage{url}
%\RequirePackage{array}
%\RequirePackage{multirow}
%\RequirePackage{placeins} % to use \FloatBarrie
%\RequirePackage{subfigure}
%\RequirePackage{longtable}
%\RequirePackage{amsmath}
%\RequirePackage{makecell} % make tables more professional
%
%%%%%%%%%
%\RequirePackage{indentfirst}
%\RequirePackage{anyfontsize}
%
%\RequirePackage{graphicx}
%\RequirePackage{booktabs}
%\let\openbox\relax
%
%\RequirePackage{xcolor}
%\definecolor{winered}{rgb}{0.5,0,0}
%\definecolor{epubblue}{RGB}{1,126,218}
%
%\RequirePackage{hyperref}
%\RequirePackage{xpatch}
%\hypersetup{%
%  pdfborder={0 0 0},
%  colorlinks,
%  citecolor=ecolor,
%  filecolor=ecolor,
%  linkcolor=ecolor,
%  urlcolor=ecolor
%}
%
%\RequirePackage{hologo}
%%%%%%%%%%
%
%
%% 行距设置
%\linespread{1.3}
%\setlength{\parskip}{3mm}
%\setlength{\parindent}{2em}
%
%%\RequirePackage{msc} % Message Sequence Charts
%
%\RequirePackage{makeidx} % fix quotes in lstlisting env
%\RequirePackage{txfonts} % fix quotes in lstlisting env 
%\RequirePackage[T1]{fontenc}
%%\RequirePackage{fontspec} % font select for xelatex
%% fancyvrb, listings provide similar functions. shortvrb defines a command \MakeShortVerb that makes a single character active, expanding to give the effect of a \verb command. Thus, after \MakeShortVerb{\|}, the text |stuff| has the same effect as \verb|stuff|. Package array, then you can avoid conflict with tabular environment. Besides |, " is also a good choice.
%\RequirePackage{shortvrb} 
%\MakeShortVerb{"}
%
%%\CTEXsetup[format+={\zihao{-3}\raggedright}]{section}
%%\CTEXsetup[format+={\zihao{4}}]{subsection}
%
%% enumitem environment
%%\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=2.5pt}
%%\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=2.5pt}
%%\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=2.5pt}
%%\setenumerate{leftmargin=2\ccwd, labelsep=1\ccwd}
%%\setitemize{leftmargin=2\ccwd, labelsep=1\ccwd}
%
%% allow ot use "caption" variants outside figure or table env. Useful for non-floating images/tabs.
%\makeatletter
%  \newcommand\figcaption{\def\@captype{figure}\caption}
%  \newcommand\tabcaption{\def\@captype{table}\caption}
%\makeatother
%
%
%% listlisting environment
%\lstset{%general command to set paramters
%	basicstyle=\small,
%	%numbers=right,
%	%numberstyle=\footnotesize
%	stepnumber=1,
%	numbersep=8pt,
%    escapechar=`, %for national charaters
%    tabsize=4,
%    %keywordstyle=\color{black}\bfseries,
%    keywordstyle=\color{blue!70},
%    commentstyle=\color[rgb]{0.233,0.645,0.233},
%    frame=single, % single/shadowbox
%    rulesepcolor=\color[rgb]{0.20,0.20,0.20},
%    %commentstyle=\color{green},
%    stringstyle=\ttfamily,
%    xleftmargin=1em,
%    xrightmargin=1em,
%    aboveskip=1em,
%    showstringspaces=false,
%    showtabs=false,
%    showspaces=false,
%    breaklines=true,
%    breakatwhitespace=true,
%    captionpos=b,
%    basewidth=0.55em,
%    fontadjust=true,
%    backgroundcolor=\color[rgb]{0.95,0.95,0.95},
%    extendedchars=false,
%}
%
%%define Javascript language
%\definecolor{lightgray}{rgb}{.9,.9,.9}
%\definecolor{darkgray}{rgb}{.4,.4,.4}
%\definecolor{purple}{rgb}{0.65, 0.12, 0.82}
%
%\lstdefinelanguage{JavaScript}{
%    keywords={typeof, new, true, false, catch, function, return, null, catch, switch, var, if, in, while, do, else, case, break},
%    keywordstyle=\color{blue!70}\bfseries,
%    ndkeywords={class, export, boolean, throw, implements, import, this},
%    ndkeywordstyle=\color{darkgray}\bfseries,
%    identifierstyle=\color{black},
%    sensitive=false,
%    comment=[l]{//},
%    morecomment=[s]{/*}{*/},
%    commentstyle=\color{purple}\ttfamily,
%    stringstyle=\color{red}\ttfamily,
%    morestring=[b]',
%    morestring=[b]"
%}
%
%\lstset{
%    language=JavaScript,
%    extendedchars=true,
%    basicstyle=\footnotesize\ttfamily,
%    showstringspaces=false,
%    showspaces=false,
%    %numbers=left,
%    %numberstyle=\footnotesize,
%    %numbersep=9pt,
%    tabsize=2,
%    breaklines=true,
%    showtabs=false,
%    captionpos=b
%}
%
%\RequirePackage{fancyhdr}
%\fancyhf{}
%\lhead{\textnormal{\kaishu\rightmark}}
%\rhead{\thepage}
%\pagestyle{fancy}
%\renewcommand{\headrulewidth}{0pt}
%
%% msc
%%\renewcommand\msckeyword{} 
%%\renewcommand\hmsckeyword{}
%%\renewcommand\mscdockeyword{}
%
%\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}