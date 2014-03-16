% Custom minutes documentclass.
%
% TODO:
% - Make sure the document title is visible in the header (it
%   used to work, something to do with encapsulating the title calls in
%   macros?
% - Translate everything into english (or back to swedish)
% - A bit of documentation wouldn't hurt
% - Find a suitable license
% - Find a better way of specifying data to include than to redefine
%   macros..
%
% Copyright Karl Mikaelsson <derfian@hamsterkollektivet.se> 2014

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{protokoll}[2014/03/16 Karl Mikaelsson <derfian@hamsterkollektivet.se>]
\LoadClassWithOptions{article} % We use the same options as article.
\RequirePackage{fancyhdr} % Headers and footers.
\RequirePackage{pdfpages} % Embed multi-page PDF, used for attachments
\RequirePackage{lastpage} % Page NN of MM

\newcommand{\protokollOrganization}{(set me by redefining \protokollOrganization)}

% Redefine \maketitle to exclude author, include organization.
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
    {\Large \protokollOrganization \par}%
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}

% Define commands for fancyhdr setup, so we don't have to repeat
% ourselves, and so the user can override them if needed.

\newcommand{\protokollSignHere}{%
  \ldots{}\ldots{}\ldots{}\ldots{}\ldots{}\ldots{}
}

\newcommand{\protokollFooter}{%
  \vspace{1.5cm}
  \begin{tabular}{cccc}
    \protokollSignHere & \protokollSignHere & \protokollSignHere & \protokollSignHere \\
    \small{name} & \small{name}  & \small{name} & \small{name} \\
    \small{\textit{title}} & \small{\textit{title}} & \small{\textit{title}} & \small{\textit{title}}
  \end{tabular}}

\newcommand{\protokollFancyHdrSetup}{%
  \fancyhf{}
  \fancyhead[L]{\@title}
  \fancyhead[C]{\protokollOrganization}
  \fancyhead[R]{sida \thepage\ av \pageref{LastPage}}
  \fancyfoot[C]{\protokollFooter}
  \setlength{\headheight}{14pt}}

% Finally set up fancyhdr
\pagestyle{fancy}
\protokollFancyHdrSetup
% and redefine plain style so first page also gets the header/footer
\fancypagestyle{plain}{%
  \protokollFancyHdrSetup
}

% \bilaga{label}{pdf file}
\newcommand{\bilaga}[2]{%
  \pagebreak
  \thispagestyle{empty}
  \begin{center}
    \section*{Bilaga: #1}
    \label{bilaga:#1}
  \end{center}
  \pagebreak
  \includepdf[pages=-]{#2}}
