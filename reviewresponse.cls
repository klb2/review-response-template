%% reviewresponse.cls
%% Copyright 2026 Karl-Ludwig Besser
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is K.-L. Besser.
%
% This work consists of the files reviewresponse.cls and the example file
% review_response.tex.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2026/06/24 v3.0.0 class for writing rebuttal letters for reviews of submitted papers]
% Author: Karl-Ludwig Besser
% Email: karl-ludwig.besser@liu.se

%%% Default options for the documentclass
\PassOptionsToClass{parskip=half-}{scrartcl}

%%% Custom options for this class
\RequirePackage{kvoptions}

\DeclareBoolOption{revnumtocomment}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessKeyvalOptions*

\LoadClass{scrartcl}


%%% Required Packages
\RequirePackage[onehalfspacing]{setspaceenhanced}

\RequirePackage[breakable,skins]{tcolorbox}
\RequirePackage{xcolor}


\newcommand*{\journal}[1]{\renewcommand*{\@journal}{#1}}
\newcommand*{\@journal}{}
\newcommand*{\editorname}[1]{\renewcommand*{\@editorname}{#1}}
\newcommand*{\@editorname}{}
\newcommand*{\manuscript}[1]{\renewcommand*{\@manuscript}{#1}}
\newcommand*{\@manuscript}{}
\newcommand*{\affiliation}[1]{\renewcommand*{\@affiliation}{#1}}
\newcommand*{\@affiliation}{}
\newcommand*{\affil}[1]{$^{#1}$}

\newcommand*{\printtitle}{\begingroup\let\\\space\@title\endgroup}
\newcommand*{\printauthor}{\begingroup\renewcommand*{\affil}[1]{\@bsphack\@esphack}\@author\endgroup}
\newcommand*{\printdate}{\@date}
\newcommand*{\printeditor}{\@editorname}
\newcommand*{\printmanuscript}{\@manuscript}

%%% Colors
\colorlet{colorcommentfg}{black}
\definecolor{colorcommentframe}{HTML}{005374}
\colorlet{colorcommentbg}{colorcommentframe!2}

\definecolor{colorchangeframe}{HTML}{006622}
\colorlet{colorchangebg}{colorchangeframe!2}

\colorlet{colorconcludingresponsefg}{black}
\colorlet{colorconcludingresponsebg}{black!1}
\colorlet{colorconcludingresponseframe}{black!20}
%%%

%%% Spacing and Lengths
\newlength{\borderthickness}
\setlength{\borderthickness}{0.75pt}
\newlength{\accentborderthickness}
\setlength{\accentborderthickness}{5pt}

%%% Fonts
\setkomafont{titlehead}{\normalsize\color{black!70}\sffamily}
\setkomafont{title}{\usekomafont{disposition}\Large}
\newkomafont{journalextra}{\normalsize\itshape}
\newkomafont{journal}{\large}
\setkomafont{author}{\large}
\newkomafont{affiliation}{\small}

%%% General Settings
\widowpenalty10000
\clubpenalty10000

%\setcounter{secnumdepth}{\sectionnumdepth}
\setcounter{secnumdepth}{-1}
%%%

%%% Counters
\newcounter{reviewer}
\setcounter{reviewer}{0}
\providecommand*{\reviewerautorefname}{Reviewer}

\newcounter{revcomment}
\ifreviewresponse@revnumtocomment%
\counterwithin{revcomment}{reviewer}
\else%
\counterwithin*{revcomment}{reviewer}
\fi
\providecommand*{\revcommentautorefname}{Comment}
%%%

%%% Commands
\renewcommand*{\maketitle}{%
	\begin{titlepage}
		\singlespacing

		\begin{flushright}
			{\usekomafont{titlehead}Responses to Reviewers\enskip|\enskip Manuscript \@manuscript\par}
		\end{flushright}

		\vspace{20ex plus 5ex minus 5ex}

		\begin{center}
			{\usekomafont{title}\@title\par}

			\vspace{6ex plus 2ex minus 1.5ex}

			{\usekomafont{journalextra}Submitted to\par}

			{\usekomafont{journal}\@journal\par}

			\vspace{10ex plus 0ex minus 4ex}

			{\usekomafont{author}\@author\par}

			\ifx\@affiliation\empty
			\else
			\vspace{1.25ex}

			{\usekomafont{affiliation}%
			\begin{tabular}{@{}l@{}}
				\@affiliation
			\end{tabular}}
			\fi
		\end{center}
	\end{titlepage}
}

\newcommand*{\editor}{
	\clearpage
	\section[Reponse to the Editor]{Authors' Response to the Editor}
}

\newcommand*{\reviewer}{
	\clearpage
	\refstepcounter{reviewer}%
	\section[Reviewer~\arabic{reviewer}]{Authors' Response to Reviewer~\arabic{reviewer}}
}

\newcommand*{\printpartbibliography}[1]{\begin{refsegment}\nocite{#1}\printbibliography[heading=none,segment=\therefsegment]\end{refsegment}}
%%%

%%% Blocks %%%
\newtcolorbox{generalcomment}{%
	attach title to upper,%
	after title={.\enskip},%
	title={General Comments},%
	fonttitle={\bfseries\sffamily},%
	coltitle={colorcommentframe},%
	coltext={colorcommentfg},%
	colback={colorcommentbg},%
	colframe={colorcommentframe},%
	boxrule={\borderthickness},%
	bookmark={General Comments},%
}

\newtcolorbox[use counter*=revcomment]{revcomment}[1][]{%
	adjusted title={Comment~\therevcomment},%
	fonttitle={\bfseries\sffamily},%
	coltitle={colorcommentframe},%
	coltext={colorcommentfg},
	colback={colorcommentbg},%
	colframe={colorcommentframe},%
	colbacktitle={colorcommentbg},
	bookmark={Comment \therevcomment},%
	boxrule={\borderthickness},%
	leftrule={\accentborderthickness},%
	titlerule={\borderthickness},%
%	titlerule style={colorcommentbg},%
	enhanced jigsaw,%
	label={comment:\arabic{reviewer}.\arabic{revcomment}},
	#1%
}

\newenvironment{revresponse}[1][{Thank you for the comment.}]{%
	\par
	\textsf{\textbf{Response:}} #1\par
}{\vspace{4em plus 0.2em minus 2em}}

\newtcolorbox{concludingresponse}[1][]{%
	attach title to upper,%
	after title={.\enskip},%
	title={Concluding Response #1},%
	fonttitle={\bfseries\sffamily},%
	coltitle={colorconcludingresponsefg},%
	coltext={colorconcludingresponsefg},%
	colback={colorconcludingresponsebg},%
	colframe={colorconcludingresponseframe},%
	boxrule={\borderthickness},%
	breakable,%
	enhanced jigsaw,%
}

\newtcolorbox{changes}{%
	colback={colorchangebg},%
	colframe={colorchangeframe},%
	boxrule={\borderthickness},%
	leftrule={\accentborderthickness},%
	breakable,%
	enhanced jigsaw,%
}


%%% Hyperref Settings
\AddToHook{package/hyperref/after}{
	\hypersetup{
		bookmarksopen,
		pdfcreator={LaTeX with the reviewresponse package},
	}
}
\AddToHook{begindocument/before}{
	\IfPackageLoadedTF{hyperref}{
		\begingroup
		\pdfstringdefDisableCommands{\let\\\space}
		\renewcommand*{\affil}[1]{\@bsphack\@esphack}
		\hypersetup{
			pdfauthor={\@author},
			pdftitle={Review Response -- \@title{}},
			pdfkeywords={\@journal{}, \@manuscript{}, review response}
		}
		\endgroup
	}{}
}
\AddToHook{begindocument/end}{\def\sectionautorefname{Reviewer}}
