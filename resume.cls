%% The MIT License (MIT)
%%
%% Copyright (c) 2015 Daniil Belyakov
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in all
%% copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.
\ProvidesClass{resume}[2017/06/18 v1.2.0 McDowell CV class]
\usepackage{hyperref}
\hypersetup{
    colorlinks=true,
    urlcolor=blue,
    pdfborder={0 0 0},
}
% Set up the fonts according to options
\def\mainfontsize{11pt}
\def\mainfontface{Times New Roman}

\DeclareOption{calibri}{%
  \def\mainfontface{calibri.ttf}
}

\DeclareOption{arial}{%
  \def\mainfontface{Arial}
}

\ProcessOptions\relax

% Set font size and paper type
\LoadClass[letterpaper,\mainfontsize]{article}

% Set document margins
\usepackage[left=0.75in,top=0.5in,right=0.75in,bottom=0.5in]{geometry} 

% Set font face
\usepackage{fontspec}
\setmainfont[SmallCapsFeatures={Renderer=Basic},
Ligatures={TeX, NoCommon, NoDiscretionary}, Path=fonts/,
    BoldItalicFont=calibribi.ttf,
    BoldFont      =calibrib.ttf,
    ItalicFont    =calibrii.ttf]{\mainfontface}

% Remove paragraph indentation
\usepackage[parfill]{parskip} 

% Required for boldface (\bf and \bfseries) tabular columns
\usepackage{array} 

% Required for ifthenelse statements
\usepackage{etoolbox} 

% Suppress page numbers
\pagestyle{empty} 

% Flexible tables
\usepackage{tabu}
\usepackage{tabularray}

\usepackage{graphicx}

% For custom margins
\usepackage{changepage}

% To customize lists
\usepackage{enumitem}
% Remove left margin from lists, suppress vertical item separation and set top 
% separation to a negative value to suppress a single parskip before lists
\setlist{leftmargin=*, noitemsep, topsep=-1\parskip}

% For adjusting spacing based on the platform used
\usepackage{ifthen}
\usepackage{ifplatform}

% For spcaed small caps
\usepackage{microtype}

\DeclareMicrotypeSet*{smallcapsi} { 
	encoding = {OT1,T1,T2A,LY1,OT4,QX,T5,TS1,EU1,EU2},
	shape = {sc*,si,scit}
}

%--------------------------------------------------------------------------------
%                                    Constants                                  -
%--------------------------------------------------------------------------------

\ifthenelse{\equal{\platformname}{\notwindowsname}}{
	\def\namespaceskip{0.575em}
	\def\afterheaderspace{1.1pt}
	\def\beforesectionheaderspace{5pt}
	\def\sectionheadermargin{6pt}
	\def\beforesectionheaderhrulespace{2.85pt}
	\def\sectionheaderhrlueheight{0.518pt}
	\def\aftersectionheaderspace{-5.8pt}
	\def\aftersinglelinesubsectionheaderspace{-20.25pt}
	\def\afterdoublelinesubsectionheaderspace{-11.75pt}
	\def\aftermultilinesubsectionheaderspace{-7.75pt}
	\def\afteremptysubsectionheaderspace{1.25pt}
	\def\subsectionmargin{-5pt}
	\def\aftersubsectionspace{0pt}
}{
	\def\namespaceskip{0.4em}
	\def\afterheaderspace{3pt}
	\def\beforesectionheaderspace{-1pt}
	\def\sectionheadermargin{6pt}
	\def\beforesectionheaderhrulespace{3pt}
	\def\sectionheaderhrlueheight{0.5pt}
	\def\aftersectionheaderspace{-3pt}
	\def\aftersinglelinesubsectionheaderspace{-18.5pt}
	\def\afterdoublelinesubsectionheaderspace{-10pt}
	\def\aftermultilinesubsectionheaderspace{-6pt}
	\def\afteremptysubsectionheaderspace{3pt}
	\def\subsectionmargin{9pt}
	\def\aftersubsectionspace{1pt}
}

%--------------------------------------------------------------------------------
%                            Header Setup and Printing                          -
%--------------------------------------------------------------------------------

% Address
\makeatletter

\newcommand\address[1]{\def\@address{#1}}
\address{}

\newcommand\printaddress{
	\small{\@address}
}

\makeatother

% Name
\makeatletter

\newcommand\name[1]{\def\@name{#1}}
\name{}

\newcommand\printname{
	\textbf{\LARGE\textsc{\@name}}
}

\makeatother

% Contacts
\makeatletter

\newcommand\contacts[1]{\def\@contacts{#1}}
\contacts{}

\newcommand\printcontacts{
	\small{\@contacts}
}

\makeatother
\makeatletter
\newcommand\makeheader{
	\begin{center}
		\begin{tabu} to 1\textwidth { X[l,m] X[2,c,m] X[r,m] }
			\printcontacts & \printname & \printaddress \\
		\end{tabu}	
	\end{center}
	\vspace*{\afterheaderspace}
}
\makeatother

%--------------------------------------------------------------------------------
%                            Sections and Subsections                           -
%--------------------------------------------------------------------------------

% Print a section header
\makeatletter
\newenvironment{cvsection}[1]{
	\vspace*{\beforesectionheaderspace}
	% Set text margins to equal \tabcolsep (6pt by default)
	\begin{adjustwidth}{\sectionheadermargin}{\sectionheadermargin}
		\textsc{\textbf{#1}}
	\end{adjustwidth}
	\vspace*{\beforesectionheaderhrulespace}
	\hrule height \sectionheaderhrlueheight
	\vspace*{\aftersectionheaderspace}
}{}
\makeatother

% Print a subsection
\makeatletter
% Define toggles checking if titles were defined
\newtoggle{lefttitledefined}
\newtoggle{centertitledefined}
\newtoggle{righttitledefined}

\newenvironment{cvsubsection}[4][1]{
	\notblank{#2}{\toggletrue{lefttitledefined}}{}
	\notblank{#3}{\toggletrue{centertitledefined}}{}
	\notblank{#4}{\toggletrue{righttitledefined}}{}
	\ifboolexpr{togl {lefttitledefined} or togl {centertitledefined} or togl {righttitledefined}}{
	        \vspace{-0.3em}
            \begin{tblr}{X[1.2,l] c X[1,r]}
                 \textbf{#2} & \textbf{#3} & \textbf{#4} \\
            \end{tblr}
            \vspace{-1.8em}
	}{}
	\togglefalse{lefttitledefined}
	\togglefalse{centertitledefined}
	\togglefalse{righttitledefined}
	\begin{adjustwidth}{\subsectionmargin}{\subsectionmargin}
}
{
	\end{adjustwidth}
	\vspace*{\aftersubsectionspace}
}
\makeatother