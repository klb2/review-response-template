\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2024/06/25 v2.0.1 class for writing rebuttal letters for reviews of submitted papers]
%\ProvidesClass{reviewresponse}[2024/09/10 v2.0.2 Sina Ebrahimi: added number formatting for reviewer's (and editor's) comments and author's responses. ]
% Author: Karl-Ludwig Besser
% Email: karl.besser@princeton.edu

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
%%%


%%% General Settings
\setlength{\parindent}{0pt}
\setlength{\parskip}{.3em plus .2em minus .3em}
\renewcommand{\baselinestretch}{1.5}

\widowpenalty10000
\clubpenalty10000
%%%

%%% Counters
\newcounter{reviewer@counter}
\setcounter{reviewer@counter}{0}
\newcounter{reviewcomment@counter}[reviewer@counter]
\setcounter{reviewcomment@counter}{0}
\newcounter{revresponse@counter}[reviewer@counter]
\setcounter{revresponse@counter}{0}
%%%


%%% Commands
\renewcommand*{\maketitle}{%
	\begin{titlepage}
		\begin{center}
			\vspace*{1cm}
			\large{Responses to Reviewers' Comments for Manuscript \reviewresponse@manuscript}\\
			
			\vspace{1cm}
			\textbf{\LARGE{\@title}}\\
			\vspace{1cm}
			\large{Addressed Comments for Publication to}
			
			\Large{\reviewresponse@journal}
			
			\large{by}
			
			{\large{\@author}}
		\end{center}
	\end{titlepage}
}

\newcommand{\editor}{
	\clearpage
	\@ifundefined{pdfbookmark}{}{%
		\pdfbookmark[1]{Reponse to the Editor}{hyperref@editor}%
	}%
	\section*{Authors' Response to the Editor}
}

\newcommand{\reviewer}{
	\clearpage
	\refstepcounter{reviewer@counter}%
	\setcounter{reviewcomment@counter}{0} % Reset comment counter for each reviewer
	\setcounter{revresponse@counter}{0} % Reset response counter for each reviewer
	\@ifundefined{pdfbookmark}{}{%
		\pdfbookmark[1]{Reviewer \arabic{reviewer@counter}}{hyperref@reviewer\arabic{reviewer@counter}}%
	}%
	\section*{Authors' Response to Reviewer \arabic{reviewer@counter}}
}

%%% Blocks %%%
\newenvironment{generalcomment}{%
    \setcounter{revresponse@counter}{0}% Reset the response counter for the general comment
	\begin{tcolorbox}[attach title to upper, title={General Comments}, after title={.\enskip}, fonttitle={\bfseries}, coltitle={colorcommentfg}, colback={colorcommentbg}, colframe={colorcommentframe},]
}{\end{tcolorbox}}

\newenvironment{revcomment}[1][]{\refstepcounter{reviewcomment@counter}%
	\begin{tcolorbox}[adjusted title={R\arabic{reviewer@counter}C\arabic{reviewcomment@counter} (Comment \arabic{reviewcomment@counter})}, fonttitle={\bfseries}, colback={colorcommentbg}, colframe={colorcommentframe},coltitle={colorcommentbg},#1]
}{\end{tcolorbox}}

\newenvironment{revresponse}[1][{Thank you for the comment.}]{%
    \ifnum\value{revresponse@counter}=0
        \textbf{R\arabic{reviewer@counter}A\arabic{revresponse@counter} (Response \arabic{revresponse@counter}):} #1\par
    \else
        \textbf{R\arabic{reviewer@counter}A\arabic{revresponse@counter} (Response \arabic{revresponse@counter}):} #1\par
    \fi
    \refstepcounter{revresponse@counter}% Increment for the next response after printing
}{\vspace{1.5em plus 0em minus 1em}}

\newenvironment{changes}{\begin{tcolorbox}[breakable,colback={colorchangebg}, colframe={colorchangeframe},enhanced jigsaw,]
}{\end{tcolorbox}}

\newcommand{\printpartbibliography}[1]{\begin{refsegment}\nocite{#1}\printbibliography[heading=none,segment=\therefsegment]\end{refsegment}}
