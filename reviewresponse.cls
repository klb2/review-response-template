\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2026/06/22 v2.1.1 class for writing rebuttal letters for reviews of submitted papers]
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

\newcommand*{\printtitle}{\@title}
\newcommand*{\printauthor}{\begingroup\renewcommand*{\affil}[1]{\@bsphack\@esphack}\@author\endgroup}
\newcommand*{\printdate}{\@date}
\newcommand*{\printeditor}{\@editorname}
\newcommand*{\printmanuscript}{\@manuscript}

%%% Colors
\colorlet{colorcommentfg}{black}
\definecolor{colorcommentframe}{HTML}{005374}
\colorlet{colorcommentbg}{colorcommentframe!3}

\definecolor{colorchangeframe}{HTML}{006622}
\colorlet{colorchangebg}{colorchangeframe!3}

\colorlet{colorconcludingresponsefg}{black}
\colorlet{colorconcludingresponsebg}{black!1}
\colorlet{colorconcludingresponseframe}{black!20}
%%%

%%% Spacing and Lengths
\newlength{\borderthickness}
\setlength{\borderthickness}{1pt}
\newlength{\accentborderthickness}
\setlength{\accentborderthickness}{5pt}

%%% General Settings
%\setlength{\parindent}{0pt}
%\setlength{\parskip}{.3em plus .2em minus .3em}
%\renewcommand{\baselinestretch}{1.5}

\widowpenalty10000
\clubpenalty10000
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
		\begin{center}
			\singlespacing
			\large
			\vspace*{1cm}
			{Responses to Reviewers' Comments for Manuscript \@manuscript}

			\vspace{5ex}

			{\LARGE\textbf{\@title}}

			\vspace{5ex}

			{Addressed Comments for Publication to}\\[2ex]
			{\Large\@journal}\\[2ex]
			{by}\\[1.5ex]
			{\@author}

			\vspace{1.25ex}

			{\small%
			\begin{tabular}{@{}l@{}}
				\@affiliation
			\end{tabular}}
		\end{center}
	\end{titlepage}
}

\newcommand*{\editor}{
	\clearpage
	\@ifundefined{pdfbookmark}{}{%
		\pdfbookmark[1]{Reponse to the Editor}{hyperref@editor}%
	}%
	\section*{Authors' Response to the Editor}
}

\newcommand*{\reviewer}{
	\clearpage
	\refstepcounter{reviewer}%
	\@ifundefined{pdfbookmark}{}{%
		\pdfbookmark[1]{Reviewer \arabic{reviewer}}{hyperref@reviewer\arabic{reviewer}}%
	}%
	\section*{Authors' Response to Reviewer~\arabic{reviewer}}
}

\newcommand*{\printpartbibliography}[1]{\begin{refsegment}\nocite{#1}\printbibliography[heading=none,segment=\therefsegment]\end{refsegment}}
%%%

%%% Blocks %%%
\newtcolorbox{generalcomment}{attach title to upper, after title={.\enskip}, title={General Comments}, fonttitle={\bfseries\sffamily}, coltitle={colorcommentframe}, colback={colorcommentbg}, colframe={colorcommentframe},boxrule={\borderthickness},bookmark={General Comments}}

\newtcolorbox[use counter*=revcomment]{revcomment}[1][]{adjusted title={Comment~\therevcomment}, fonttitle={\bfseries\sffamily}, colback={colorcommentbg}, colframe={colorcommentframe},coltitle={colorcommentframe},colbacktitle={colorcommentbg},bookmark={Comment \arabic{revcomment}},boxrule={\borderthickness},leftrule={\accentborderthickness},titlerule={\borderthickness},enhanced jigsaw,#1}

\newenvironment{revresponse}[1][{Thank you for the comment.}]{%
	\textbf{Response:} #1\par
}{\vspace{4em plus 0.2em minus 1.5em}}

\newtcolorbox{concludingresponse}[1][]{attach title to upper, after title={.\enskip}, title={Concluding Response #1}, fonttitle={\bfseries\sffamily}, coltitle={colorconcludingresponsefg}, colback={colorconcludingresponsebg}, colframe={colorconcludingresponseframe}, boxrule={\borderthickness}, breakable, enhanced jigsaw,}

\newtcolorbox{changes}{breakable,colback={colorchangebg}, colframe={colorchangeframe},boxrule={\borderthickness},leftrule={\accentborderthickness},enhanced jigsaw}


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
