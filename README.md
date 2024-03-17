# LaTeX Template for Review Responses

[![Overleaf Template](https://img.shields.io/static/v1?label=Overleaf&logo=overleaf&message=Template&color=47A141)](https://www.overleaf.com/latex/templates/review-response-template/tmbvmjstxwrd)

This repository provides a simple LaTeX template for writing responses to
reviewers, which is typically needed when submitting an article to a scientific
journal.

_This template is also available on
[Overleaf](https://www.overleaf.com/latex/templates/review-response-template/tmbvmjstxwrd)._

# Usage

In order to use the `reviewresponse.cls` class in your document, simply include
the following line at the top of your LaTeX document

```latex
\documentclass{reviewresponse}
```

## Commands
The following commands are provided by the package.  
If you are using [TeXstudio](https://www.texstudio.org/), there exists an
autocomplete file (`.cwl`) for the `reviewresponse.cls` package, which can be
found [here](https://gist.github.com/klb2/29f6fffeac8cc79e3b3f79e980a6b9e3).

### Document Metadata
You can use the following commands to specify the metadata of the submitted
document.
Place these commands before `\begin{document}`.

```latex
\title{Title of the Manuscript}
\author{Author One, Author Two, and Author Three}
\journal{Name of the Journal}
\manuscript{ID-of-the-Manuscript}
\editorname{Name of the Editor}
```


### Editor and Reviewers

```latex
\editor
\reviewer
```

These commands start a new editor and reviewer.
The typical usage is

```latex
\begin{document}
...
\editor
Response to the editor

\reviewer
Response to the first reviewer

\reviewer
Response to the second reviewer
```



### Comments and Responses

```latex
\begin{generalcomment}
...
\end{generalcomment}
```

The `generalcomment` environment is meant for general comments given by the
editor and reviewers.



```latex
\begin{revcomment}
...
\end{revcomment}
```

The `revcomment` environment is meant for the individual comments made by the
reviewers.
They are automatically numbered.

It also accepts optional arguments, which are directly passed to the underlying
`tcolorbox` environment.
This is useful, if you want to add some arguments in specific situations, e.g.,
the `breakable` keyword for very long comments.


```latex
\begin{revresponse}[Optional Parameter]
...
\end{revresponse}
```

The `revresponse` environment is meant for responses to the individual comments
of the reviewers and editor.
The optional parameter changes the text on the first line.
By default, this text is "Thank you for the comment.".



### Changes

```latex
\begin{changes}
...
\end{changes}
```

The `changes` environment is meant for indicating changes that you made to your
manuscript.
It sets the content in a box in order to highlight it for the reviewers.


### Bibliography
The `reviewresponse` package supports the use of `biblatex` for references.
Simply include `biblatex` and use the `\cite` command in your response.

If you want to print specific references, e.g., at the end of the response to
one particular comment, you can use the `\printpartbibliography` command.

```latex
\printpartbibliography{bibkey1,bibkey2,...}
```



### Customization
You can customize the appearance of all the boxes in the `reviewresponse.sty`
file.

If you only want to change the colors of the boxes, you need to redefine the
following colors.
The shown values are the defaults.

```latex
\definecolor{colorcommentfg}{RGB}{0,63,87}  % color of the title in the comment box
\definecolor{colorcommentbg}{HTML}{e0f0f6} % color of the background of the comment box
\definecolor{colorcommentframe}{RGB}{0,112,155} % color of the frame of the comment box

\colorlet{colorchangebg}{black!2} % color of the background of the changes box
\colorlet{colorchangeframe}{black!20} % color of the frame of the changes box
```
