% Documentclass geomorphica.cls for Geomorphica, a community-driven, Diamond Open Access journal publishing peer-reviewed research in geomorphology.

% Current version with inputs from:
% Roberto Fernández (Roberto@psu.edu) - May, 2023
%
% Based on the class for Seismica (www.seismica.org) 
% and used with their authorization. 
% Seismica class developed with inputs from:
% Théa Ragon, Hannah Mark, Wasja Bloch, Thomas Lecocq

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{geomorphica}[2022 LaTeX2e document class]

\newif\if@review
\@reviewfalse
\DeclareOption{review}{\@reviewtrue}

\newif\if@anonymous
\@anonymousfalse
\DeclareOption{anonymous}{\@anonymoustrue}

\newif\if@titlepage
\@titlepagefalse
\DeclareOption{titlepage}{\@titlepagetrue}

\newif\if@breakmath
\@breakmathfalse
\DeclareOption{breakmath}{\@breakmathtrue}

\newif\if@languages
\@languagesfalse
\DeclareOption{languages}{\@languagestrue}

\newif\if@preprint
\@preprintfalse
\DeclareOption{preprint}{\@preprinttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Review option by default
\if@preprint
\else
\@reviewtrue
\fi

\LoadClass[11pt,twoside,a4paper,onecolumn]{article}


\RequirePackage[headsep=0.7cm, top=2cm, bottom=1.5cm, left=1.5cm, right=1.5cm, footskip=0.7cm]{geometry}
\setlength{\columnsep}{0.8cm}
\RequirePackage[table]{xcolor}
% Geomorphica logo has a gradient of blues defined as follows (R,G,B) 
% First Color (0.00 offset) R,G,B = 0,0,43 (dark blue)
% Second color (0.05 offset) = 2,91,214
% Third color (0.85 offset) = 33,187,246
% Last color (1.00 offset) = 42,212, 255 (light blue)
% For submission teplate we will probably settle for all black and then make it prettier after acceptance. 
\definecolor{linkgeomorphica}{RGB}{0,0,0} % light-blue
\definecolor{geomorphicacolor1}{RGB}{0,0,0} % 
\definecolor{geomorphicacolor2}{RGB}{0,0,0} % 
\definecolor{geomorphicacolor3}{RGB}{0,0,0} % dark-blue
\definecolor{codebackcolor}{RGB}{243,243,243} %background shade
\RequirePackage[unicode, bookmarks=true, linkcolor=geomorphicacolor2, citecolor=geomorphicacolor2, hidelinks, hyperfootnotes=false]{hyperref}
\hypersetup{colorlinks,linkcolor=geomorphicacolor2}
\hypersetup{colorlinks,citecolor=geomorphicacolor2}
\hypersetup{colorlinks,urlcolor=geomorphicacolor2}

\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{titling}
\RequirePackage{abstract}
\RequirePackage{fancyhdr}
\RequirePackage{bookmark}
\RequirePackage{caption} 
\RequirePackage[round]{natbib}
\IfFileExists{abbrvnat_geomorphica_upcasetitle.bst}{\bibliographystyle{abbrvnat_geomorphica_upcasetitle}}{\bibliographystyle{abbrvnat}}
\RequirePackage{doi}
%\RequirePackage{orcidlink}
\RequirePackage[noblocks]{authblk}
\setcounter{Maxaffil}{0}
\RequirePackage{datatool}
\RequirePackage{etoolbox}
\RequirePackage{comment}
\RequirePackage{physics}
\RequirePackage{listings}
\RequirePackage{changepage}
\RequirePackage{setspace}
\RequirePackage{xcolor}
% fonts and math
\RequirePackage{amsmath}
\if@breakmath
\RequirePackage{breqn}
\BeforeBeginEnvironment{dmath}{\begin{nolinenumbers}}
    \AfterEndEnvironment{dmath}{\end{nolinenumbers}}
\BeforeBeginEnvironment{dmath*}{\begin{nolinenumbers}}
	\AfterEndEnvironment{dmath*}{\end{nolinenumbers}}
% patches \eq@setnumber to use \refstepcounter instead of \stepcounter, from https://tex.stackexchange.com/questions/241118/autoref-to-dmath-from-breqn-package-generates-wrong-link-text
\patchcmd\eq@setnumber{\stepcounter}{\refstepcounter}{}{%
	\errmessage{Patching \noexpand\eq@setnumber failed}%
}
% break equations
\renewenvironment{equation}{%
	\begin{dmath}}{%
\end{dmath}}
\fi
\newcommand{\mathbfup}[1]{\mathord{\textnormal{\textbf{#1}}}}

\RequirePackage[mathlines]{lineno} %% loaded here because incompatibility with breqn
\if@review
\linenumbers
\doublespacing
\fi

\if@languages
\RequirePackage{polyglossia}
\RequirePackage{fontspec}
\setmainlanguage[]{english}
\RequirePackage[autostyle=false, style=english]{csquotes}
%\RequirePackage[opentype,default,tabular,lining]{sourcesanspro}
%\RequirePackage[opentype,default,tabular,lining]{sourceserifpro}
%\RequirePackage[opentype,default,lining]{sourcecodepro}
\RequirePackage[regular]{sourcesanspro}
\RequirePackage[regular]{sourcecodepro}
\RequirePackage[default,regular]{sourceserifpro}
\RequirePackage[T1]{fontenc}
\else
\RequirePackage[regular]{sourcesanspro}
\RequirePackage[regular]{sourcecodepro}
\RequirePackage[default,regular]{sourceserifpro}
\RequirePackage[T1]{fontenc}
\RequirePackage[autostyle=false, style=english]{csquotes}
\fi

\newcommand{\sff}{\sourcesanspro}
\newcommand{\rmf}{\sourceserifpro}
\newcommand{\sflight}{\sourcesansprolight}
\newcommand{\rmlight}{\sourceserifprolight}
\urlstyle{sf}


%-------------------------------------------------------------------------------
%                Configuration for authors
%-------------------------------------------------------------------------------

% package authblk
\renewcommand*{\Authsep}{, }
\renewcommand*{\Authand}{, }
\renewcommand*{\Authands}{, }
\renewcommand*{\Authfont}{\sffamily\bfseries\color{geomorphicacolor2}}    % make author names boldface    
\setlength{\affilsep}{0.2cm}   % set the space between author and affiliation
\renewcommand*{\Affilfont}{\normalfont\sffamily\small}
\renewcommand\AB@affilsepx{, \protect\Affilfont}

% For orcid symbol without lualatex
% Copy of orcidlinks.sty / https://github.com/duetosymmetry/orcidlink-LaTeX-command
\RequirePackage{tikz}
\usetikzlibrary{svg.path}

\definecolor{orcidlogocol}{HTML}{A6CE39}
\tikzset{
	orcidlogo/.pic={
		\fill[orcidlogocol] svg{M256,128c0,70.7-57.3,128-128,128C57.3,256,0,198.7,0,128C0,57.3,57.3,0,128,0C198.7,0,256,57.3,256,128z};
		\fill[white] svg{M86.3,186.2H70.9V79.1h15.4v48.4V186.2z}
		svg{M108.9,79.1h41.6c39.6,0,57,28.3,57,53.6c0,27.5-21.5,53.6-56.8,53.6h-41.8V79.1z M124.3,172.4h24.5c34.9,0,42.9-26.5,42.9-39.7c0-21.5-13.7-39.7-43.7-39.7h-23.7V172.4z}
		svg{M88.7,56.8c0,5.5-4.5,10.1-10.1,10.1c-5.6,0-10.1-4.6-10.1-10.1c0-5.6,4.5-10.1,10.1-10.1C84.2,46.7,88.7,51.3,88.7,56.8z};
	}
}
%% Reciprocal of the height of the svg whose source is above.  The
%% original generates a 256pt high graphic; this macro holds 1/256.
\newcommand{\@OrigHeightRecip}{0.00390625}
%% We will compute the current X height to make the logo the right height
\newlength{\@curXheight}

\DeclareRobustCommand\orcidlink[1]{%
	\texorpdfstring{%
		\setlength{\@curXheight}{\fontcharht\font`X}%
		\href{https://orcid.org/#1}{\XeTeXLinkBox{\mbox{%
					\begin{tikzpicture}[yscale=-\@OrigHeightRecip*\@curXheight,
						xscale=\@OrigHeightRecip*\@curXheight,transform shape]
						\pic{orcidlogo};
					\end{tikzpicture}%
	}}}}{}}

\newcommand{\orcid}[1]{\orcidlink{#1}}

% Credit
\DTLgnewdb{credits}
\newcommand*{\credit}[2]{%
	\DTLnewrow{credits}%
	\DTLnewdbentry{credits}{credrole}{#1}%
	\DTLnewdbentry{credits}{credauthor}{#2}%
}

\if@anonymous
\renewcommand{\@author}{}
\fi

% Redefine thanks symbol for compatibility with fonts
\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or
		\mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger
		\or \ddagger\ddagger \else\@ctrerr\fi}}
%-------------------------------------------------------------------------------
%                Configuration for heading
%-------------------------------------------------------------------------------

% For credit
\newcommand{\printcreditifnotempty}{%
	\ifdim\DTLrowcount{credits}pt=0pt
	\else
	\vskip .5em
	\sffamily\footnotesize\raggedright\textcolor{black}{Author contributions:} \DTLforeach*{credits}{\Credrole=credrole, \Credauthor=credauthor}{\textcolor{black}{ \textit{ \Credrole}: \Credauthor.} }
	\fi
}

\pretitle{
            \begin{flushleft}
            \fontsize{21pt}{1em}\sffamily\bfseries\color{geomorphicacolor2}
	   }
\posttitle{
        	\end{flushleft}
            \vskip .2cm
          }
\preauthor{
            \lineskip 0.2cm%
            \begin{flushleft}
          }
\if@anonymous
	\postauthor{
                \end{flushleft}%
	          \vskip -.5em
	          \par
                }
\else
    \postauthor{
                \end{flushleft}
                \vskip -.5em
                \printcreditifnotempty
                \par
                }
\fi
\predate{}
\postdate{}
\date{}

\newcommand{\banner}{banner}

\def\doi#1{\def\@doi{#1}}
\doi{}

\renewcommand\maketitlehooka{%

\begin{nolinenumbers}

\vspace{-1.5cm} %\hspace{0.0}
\href{https://geomorphica.org/}{\includegraphics[width=\textwidth]{\banner}}

\if@review
{\vspace*{-1.3cm} \hspace{0.1cm} 
	\href{https://geomorphica.org/}{\color{black} \sffamily\small Non-peer reviewed manuscript submitted to} }
\else
{\vspace*{-1.0cm} \hspace{0.1cm} 
	\href{https://geomorpohica.org/}{\color{black} \sffamily\small Non-peer reviewed manuscript submitted to} }
\fi
\vspace*{1.7cm}
\end{nolinenumbers}
}

\renewcommand\maketitlehookd{%
\pagestyle{fancy}
\thispagestyle{plain}
}

%-------------------------------------------------------------------------------
%                Configuration for abstract
%-------------------------------------------------------------------------------

\newcommand*{\abstracttitlestyle}[1]{{\sffamily\large\color{geomorphicacolor2} \bfseries #1}}

\newcommand*{\keywordtitlestyle}[1]{{\sffamily\large\color{geomorphicacolor2} \bfseries #1}}

\newenvironment{summary}[1]
{
\par
\noindent \abstracttitlestyle{#1} \hspace{0.2cm}\sffamily
}{
\vspace{0.3cm}}%

\newenvironment{keywords}[1]
{
\par
\noindent \keywordtitlestyle{#1} \hspace{0.2cm}\sffamily
}{
\vspace{0.3cm}}

\newcommand*{\makegeomorphicatitle}[1]{%
\maketitle #1
\vspace{0.7cm}
}
\newcommand*{\addsummaries}[1]{%
#1
\vspace{0.7cm}
}

%-------------------------------------------------------------------------------
%                Configuration for sections
%-------------------------------------------------------------------------------

\titleformat{\section}{\fontsize{14pt}{1em}\bfseries\sffamily\color{geomorphicacolor2}}{\thesection}{1em}{}
\titleformat{\subsection}{\fontsize{12pt}{0.3em}\bfseries\sffamily\color{geomorphicacolor2}}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\fontsize{11pt}{0.1em}\bfseries\sffamily\color{geomorphicacolor2}}{\thesubsubsection}{1em}{}

\renewcommand{\normalsize}{\sffamily}

\setcounter{secnumdepth}{3}

\newenvironment{closing}[1]
{
\section*{#1}
}{
\vspace{0.3cm}}

\if@anonymous
\excludecomment{closing}
\fi

%-------------------------------------------------------------------------------
%                Configuration for header and footer
%-------------------------------------------------------------------------------

\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\fancyfoot[R]{\sffamily\bfseries\footnotesize \thepage}
\fancyhead[R]{\sffamily\footnotesize \color{geomorphicacolor2}This is a non-peer reviewed manuscript submitted to {\scshape \bfseries\href{https://geomorphica.org/}{\color{geomorphicacolor2}Geomorphica}} }
\renewcommand{\headrule}{}

\fancypagestyle{plain}{%
\fancyhead{}
\renewcommand{\headrule}{}
}

%-------------------------------------------------------------------------------
%                Configuration for captions
%-------------------------------------------------------------------------------

\captionsetup{font={sf},
labelfont={bf,color=geomorphicacolor2},
labelsep=quad, 
justification=justified, 
singlelinecheck=false, oneside}


% equations
\if@breakmath
\renewcommand{\eqnumcolor}{\color{geomorphicacolor2}}
\renewcommand{\eqnumfont}{\sffamily}
\else
\renewcommand{\eqref}[1]{\textup{\eqreftagform@{\ref{#1}}}}
\let\eqreftagform@\tagform@
\def\tagform@#1{%
\maketag@@@{\color{geomorphicacolor2}\sffamily(\ignorespaces#1\unskip\@@italiccorr)}%
}
\fi

\renewcommand{\theequation}{\color{geomorphicacolor2}\arabic{equation}}

%-------------------------------------------------------------------------------
%                Configuration for references
%-------------------------------------------------------------------------------

\setlength{\bibsep}{3pt}
\renewcommand{\bibsection}{\section*{References}}
\def\bibfont{\sffamily\small}
\renewcommand*{\doi}[1]{\href{http://doi.org/#1}{\color{geomorphicacolor2}doi:~#1}}

%-------------------------------------------------------------------------------
%                Configuration for code
%-------------------------------------------------------------------------------

% in-line code words
\def\code#1{\fontsize{9}{10}\colorbox{codebackcolor}{\texttt{#1}}}
\setlength{\fboxsep}{1pt}

\lstset{
tabsize=4,
captionpos=t,
breaklines=true,
showstringspaces=false,
basicstyle=\fontsize{9}{10}\ttfamily,
keywordstyle=\color{geomorphicacolor2},
commentstyle=\color{gray},
stringstyle=\color{geomorphicacolor2},
emphstyle=\color{geomorphicacolor2},
%	frameshape={RYR}{Y}{Y}{RYR},
backgroundcolor=\color{codebackcolor},   
rulecolor=\color{codebackcolor}
}


%-------------------------------------------------------------------------------
%                Configuration for math line numbers
%-------------------------------------------------------------------------------
% from  https://tex.stackexchange.com/questions/461186/how-to-use-lineno-with-amsmath-align

\if@review
% Patch 'normal' math environments:
\newcommand*\linenomathpatch[1]{%
\cspreto{#1}{\linenomath}%
\cspreto{#1*}{\linenomath}%
\csappto{end#1}{\endlinenomath}%
\csappto{end#1*}{\endlinenomath}%
}
% Patch AMS math environments:
\newcommand*\linenomathpatchAMS[1]{%
\cspreto{#1}{\linenomathAMS}%
\cspreto{#1*}{\linenomathAMS}%
\csappto{end#1}{\endlinenomath}%
\csappto{end#1*}{\endlinenomath}%
}

% Definition of \linenomathAMS depends on whether the mathlines option is provided
\expandafter\ifx\linenomath\linenomathWithnumbers
\let\linenomathAMS\linenomathWithnumbers
% The following line gets rid of an extra line numbers at the bottom:
\patchcmd\linenomathAMS{\advance\postdisplaypenalty\linenopenalty}{}{}{}
\else
\let\linenomathAMS\linenomathNonumbers
\fi

\linenomathpatch{equation}
\linenomathpatchAMS{gather}
\linenomathpatchAMS{multline}
\linenomathpatchAMS{align}
\linenomathpatchAMS{alignat}
\linenomathpatchAMS{flalign}
\fi

% end of geomorphica.cls 
