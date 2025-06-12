\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2025/06/12 v2.1 class for writing rebuttal letters for reviews of submitted papers]
% Author: Karl-Ludwig Besser
% Email: karl-ludwig.besser@liu.se

\RequirePackage{kvoptions}

\PassOptionsToClass{parskip=half-}{scrartcl}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass{scrartcl}

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
\definecolor{colorcommentfg}{RGB}{0,63,87}
\definecolor{colorcommentbg}{HTML}{e0f0f6}
\definecolor{colorcommentframe}{RGB}{0,112,155}

\colorlet{colorchangebg}{black!2}
\colorlet{colorchangeframe}{black!20}

\colorlet{colorconcludingresponsefg}{black!80}
\colorlet{colorconcludingresponsebg}{black!2}
\colorlet{colorconcludingresponseframe}{black!20}
%%%


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
\newcounter{revcomment}[reviewer]
\setcounter{revcomment}{0}
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
\newenvironment{generalcomment}{%
	\begin{tcolorbox}[attach title to upper, title={General Comments}, after title={.\enskip}, fonttitle={\bfseries}, coltitle={colorcommentfg}, colback={colorcommentbg}, colframe={colorcommentframe},bookmark={General Comments}]
	}{\end{tcolorbox}}

\newenvironment{revcomment}[1][]{\refstepcounter{revcomment}
	\begin{tcolorbox}[adjusted title={Comment \arabic{revcomment}}, fonttitle={\bfseries}, colback={colorcommentbg}, colframe={colorcommentframe},coltitle={colorcommentbg},bookmark={Comment \arabic{revcomment}},#1]
	}{\end{tcolorbox}}

\newenvironment{revresponse}[1][{Thank you for the comment.}]{%
	\textbf{Response:} #1\par
}{\vspace{4em plus 0.2em minus 1.5em}}

\newenvironment{concludingresponse}[1][]{%
	\begin{tcolorbox}[attach title to upper, breakable, title={Concluding Response #1}, after title={.\enskip}, fonttitle={\bfseries}, coltitle={colorconcludingresponsefg}, colback={colorconcludingresponsebg}, colframe={colorconcludingresponseframe},]
	}{\end{tcolorbox}}

\newenvironment{changes}{\begin{tcolorbox}[breakable,colback={colorchangebg}, colframe={colorchangeframe},enhanced jigsaw,]
	}{\end{tcolorbox}}

\providecommand*{\revcommentautorefname}{Comment}

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
