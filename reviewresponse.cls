\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2025/01/16 v2.0.1 class for writing rebuttal letters for reviews of submitted papers]
% Author: Karl-Ludwig Besser
% Email: karl-ludwig.besser@liu.se

\RequirePackage{kvoptions}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass{scrartcl}


\RequirePackage[breakable,skins]{tcolorbox}
\RequirePackage{xcolor}


\newcommand*{\journal}[1]{\renewcommand*{\@journal}{#1}}
\newcommand*{\@journal}{}
\newcommand*{\editorname}[1]{\renewcommand*{\@editorname}{#1}}
\newcommand*{\@editorname}{}
\newcommand*{\manuscript}[1]{\renewcommand*{\@manuscript}{#1}}
\newcommand*{\@manuscript}{}

\newcommand*{\thetitle}{\@title}
\newcommand*{\theauthor}{\@author}
\newcommand*{\thedate}{\@date}
\newcommand*{\theeditor}{\@editorname}
\newcommand*{\themanuscript}{\@manuscript}

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
\setlength{\parindent}{0pt}
\setlength{\parskip}{.3em plus .2em minus .3em}
\renewcommand{\baselinestretch}{1.5}

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
			\vspace*{1cm}
			\large{Responses to Reviewers' Comments for Manuscript \@manuscript}\\
			
			\vspace{1cm}
			\textbf{\LARGE{\@title}}\\
			\vspace{1cm}
			\large{Addressed Comments for Publication to}
			
			\Large{\@journal}
			
			\large{by}
			
			{\large{\@author}}
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

\newcommand{\printpartbibliography}[1]{\begin{refsegment}\nocite{#1}\printbibliography[heading=none,segment=\therefsegment]\end{refsegment}}


\providecommand*{\revcommentautorefname}{Comment}
\AddToHook{package/hyperref/after}{
	\hypersetup{
		bookmarksopen,
		pdfcreator={LaTeX with the reviewresponse package},
	}
}
\AddToHook{begindocument/before}{
	\IfPackageLoadedTF{hyperref}{
		\hypersetup{
			pdfauthor={\@author},
			pdftitle={Review Response -- \@title{}},
			pdfkeywords={\@journal{}, \@manuscript{}, review response}
		}
	}{}
}
\AddToHook{begindocument/end}{\def\sectionautorefname{Reviewer}}