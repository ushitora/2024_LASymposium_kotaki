%-*- coding: utf-8 -*-

% -------------------------------------------------
% jsmaster.cls
% -------------------------------------------------
% 1999/02/18 Ver.1.00 : とりあえず完成
% 2007/12くらい : 九州大学のを元にして東北大学版を作成
% 2021/3くらい : jreportからjsreportをベースにするように改訂し，名前も jmasterからjsmasterに
% -------------------------------------------------
% 作成者: K.Honda
% modified: T.Okuyama
% modified: R.Yoshinaka
% -------------------------------------------------
% 使用方法
%
% jsmaster.clsを主ファイルと同じ階層（パスが通るところ）に置いて、クラス指定を以下のようにして下さい。
% dvipdfmx オプションは特に tikz を使う場合に必須。
%
%	\documentclass[a4paper,twoside,12pt,dvipdfmx]{jsmaster}
%
%
% -------------------------------------------------
\ProvidesClass{jsmaster}[2021/03/33]	%% class name: jsmaster
\LoadClassWithOptions{jsreport}		%% jsreportをベースにする。
% -------------------------------------------------
%  double space setting
% -------------------------------------------------
\def\baselinestretch{1.1} % 過剰な行間空白はむしろ読みにくくなる

% -------------------------------------------------
%  title page setting
% -------------------------------------------------
\renewcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 1cm
  \begin{center}%
    {\LARGE LA \par}%
    \vskip 0.5cm%
    {\huge \@title \par}%
    \vskip 5cm%
    {\Large 東北大学 大学院情報科学研究科 \\
  		システム情報科学専攻 篠原・吉仲研究室 \\
		修士課程1年 \\}%
    {\Large \@author \par}%
    \vskip 1cm
    {\Large \@date \par}%
  \end{center}\par
  \end{titlepage}%
  % \newpage\null\thispagestyle{empty}\newpage % 表紙のあとに空頁
  \setcounter{page}{0}
  \setcounter{footnote}{0}%
  \pagenumbering{roman}
  \let\thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@title\@empty
  \global\let\maketitle\relax
%
}

% -------------------------------------------------
%  abstract page setting
% -------------------------------------------------
\def\abstract{\titlepage
  \setcounter{page}{0}
  \null\vfil
}
\def\endabstract{\par\vfil\null\endtitlepage}

% -------------------------------------------------
%  pagestyle setting
% -------------------------------------------------
\setlength\paperheight {297mm}%
\setlength\paperwidth  {210mm}
\pagestyle{myheadings}

% -------------------------------------------------
%  bibliography heading setting
% -------------------------------------------------
\def\thebibliography#1{%
  \chapter*{\refname\@mkboth{\refname}{\refname}}%
  \list{[\arabic{enumi}]}{%
    \settowidth\labelwidth{[#1]}%
    \leftmargin\labelwidth%
    \advance\leftmargin\labelsep%
    \usecounter{enumi}%
  }%
  \addcontentsline{toc}{chapter}{\refname}%
  \def\newblock{\hskip .11em plus .33em minus .07em}%
  \sloppy\clubpenalty4000\widowpenalty4000%
  \sfcode`\.=1000\relax%
}

% -------------------------------------------------
%  no numbers set on section/subsection/subsubsection
% -------------------------------------------------
\renewcommand{\thepart		}{\Roman{part}}
\renewcommand{\thechapter	}{\arabic{chapter}}
\renewcommand{\thesection	}{\thechapter.\arabic{section}}
\renewcommand{\thesubsection	}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection	}{\thesubsection.\arabic{subsubsection}}
\renewcommand{\theparagraph	}{\thesubsubsection.\arabic{paragraph}}
\renewcommand{\thesubparagraph	}{\theparagraph.\arabic{subparagraph}}

\renewcommand{\chapter}{%	章の開始ページのスタイル変更
  \clearpage%
  \thispagestyle{myheadings}%
  \global\@topnum\z@%
  \@afterindentfalse%
  \secdef\@chapter\@schapter%
}
\renewcommand{\@makechapterhead}[1]{%	見出しの変更(\chapter)
  \vspace*{30pt}{%
    \parindent 0pt \raggedright%
    \ifnum%
      \c@secnumdepth >\m@ne \LARGE\bf \@chapapp{\thechapter}\@chappos\par%
      \vskip 20pt%
    \fi%
    \LARGE\bf #1\par%
    \nobreak \vskip 40pt%
  }%
}
\renewcommand{\@makeschapterhead}[1]{%	見出しの変更(\chapter*)
  \vspace*{20pt}{%
    \parindent 0pt \raggedright%
    \LARGE \bf #1\par%
    \nobreak \vskip 40pt%
  }%
}
%\renewcommand{\thechapter}{\sf\@arabic\c@chapter} % 見出し数字のフォントをサンセリフに

\renewcommand{\section}{%	見出しの変更
  \@startsection{section}{1}{\z@}%
  {3.5ex plus 1ex minus .2ex}%	前の空き
  {2.3ex plus .2ex}%		後ろの空き
  {\large\bf}%			書式
}
\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{\z@}%
  {3.25ex plus 1ex minus .2ex}%
  {1.5ex plus .2ex}%
  {\normalsize\bf}%
}
\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{\z@}%
  {3.25ex plus 1ex minus .2ex}%
  {1.5ex plus .2ex}%
  {\normalsize\bf}%
}

% -------------------------------------------------
%  索引ページの指定
% -------------------------------------------------
\renewenvironment{theindex}
  {\if@twocolumn\@restonecolfalse\else\@restonecoltrue\fi
   \columnseprule\z@ \columnsep 35\p@
   \twocolumn[\@makeschapterhead{\indexname}]%
   \@mkboth{\indexname}{\indexname}%
%% \thispagestyle{jpl@in}\parindent\z@	%%	<- jreport.cls
   \thispagestyle{myheadings}\parindent\z@%	<- 変更
   \parskip\z@ \@plus .3\p@\relax
   \let\item\@idxitem}
  {\if@restonecol\onecolumn\else\clearpage\fi}

% -------------------------------------------------
%  
% -------------------------------------------------
\def\abstractname{要 旨}
\def\tablename{表}
\def\figurename{図}
\def\indexname{索引}
\def\refname{参考文献} 
\def\listtablename{表一覧}
\def\listfigurename{図一覧}
\def\contentsname{目次}
%
\renewcommand{\emph}[1]{\if@english\textit{#1}\else\textsf{\textgt{#1}}}  %% \emph{和文英文の強調の書体の見た目を揃える}

% ----------------------------------------------- end of jsmaster.cls
