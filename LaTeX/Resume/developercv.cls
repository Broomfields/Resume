%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developer CV
% LaTeX Class
% Version 1.0 (28/1/19)
%
% This class originates from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Jan Vorisek (jan@vorisek.me)
% Based on a template by Jan Küster (info@jankuester.com)
% Modified for LaTeX Templates by Vel (vel@LaTeXTemplates.com)
%
% License:
% The MIT License (see included LICENSE file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{developercv}[2019/01/28 Developer CV class v1.0]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{extarticle} % Load the base class

%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

\setlength{\parindent}{0mm} % Suppress paragraph indentation

\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links

\newcommand{\lorem}{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.} % Dummy text

\pagestyle{empty} % No headers or footers

\usepackage{moresize} % Provides more font size commands (\HUGE and \ssmall)

\usepackage{ifthen}

\usepackage{pifont}

\RequirePackage{accsupp}

%----------------------------------------------------------------------------------------
%	PAGE LAYOUT
%----------------------------------------------------------------------------------------

\usepackage{geometry} % Required for adjusting page dimensions and margins

\geometry{
	paper=a4paper, % Paper size, change to letterpaper for US letter size
	top=1.75cm, % Top margin
	bottom=1.75cm, % Bottom margin
	left=2cm, % Left margin
	right=2cm, % Right margin
	headheight=0.75cm, % Header height
	footskip=1cm, % Space from the bottom margin to the baseline of the footer
	headsep=0.5cm, % Space from the top margin to the baseline of the header
	%showframe, % Uncomment to show how the type block is set on the page
}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage[utf8]{inputenc} % Required for inputting international characters
\usepackage[T1]{fontenc} % Output font encoding for international characters

\usepackage[default]{raleway}
%\usepackage[defaultsans]{droidsans}
%\usepackage{cmbright}
%\usepackage{fetamont}
%\usepackage[default]{gillius}
%\usepackage{roboto}

\renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used

%------------------------------------------------

\usepackage{fontawesome} % Required for FontAwesome icons

% Command to output an icon in a black square box with text to the right
\newcommand{\icon}[3]{% The first parameter is the FontAwesome icon name, the second is the box size and the third is the text
	\vcenteredhbox{\colorbox{black}{\makebox(#2, #2){\textcolor{white}{\large\csname fa#1\endcsname}}}}% Icon and box
	\hspace{0.2cm}% Whitespace
	\vcenteredhbox{\textcolor{black}{#3}}% Text
}

%----------------------------------------------------------------------------------------
%	GRAPHICS DEFINITIONS
%---------------------------------------------------------------------------------------- 

\usepackage{tikz} % Required for creating the plots
\usetikzlibrary{arrows}
\usetikzlibrary{shapes, backgrounds}
% \usetikzlibrary{arrows}
\tikzset{x=1cm, y=1cm} % Default tikz units

% Command to vertically centre adjacent content
\newcommand{\vcenteredhbox}[1]{% The only parameter is for the content to centre
	\begingroup%
		\setbox0=\hbox{#1}\parbox{\wd0}{\box0}%
	\endgroup%
}

\colorlet{accent}{blue!70!black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{black!80!white}
\colorlet{name}{heading}
\colorlet{tagline}{accent}

%----------------------------------------------------------------------------------------
%	CHARTS
%---------------------------------------------------------------------------------------- 

\newcounter{barcount}

% Environment to hold a new bar chart
\newenvironment{barchart}[1]{ % The only parameter is the maximum bar width, in cm
	\newcommand{\barwidth}{0.35}
	\newcommand{\barsep}{0.2}
	
	% Command to add a bar to the bar chart
	\newcommand{\baritem}[2]{ % The first argument is the bar label and the second is the percentage the current bar should take up of the total width
		\pgfmathparse{##2}
		\let\perc\pgfmathresult
		
		\pgfmathparse{#1}
		\let\barsize\pgfmathresult
		
		\pgfmathparse{\barsize*##2/100}
		\let\barone\pgfmathresult
		
		\pgfmathparse{(\barwidth*\thebarcount)+(\barsep*\thebarcount)}
		\let\barx\pgfmathresult
		
		\filldraw[fill=black, draw=none] (0,-\barx) rectangle (\barone,-\barx-\barwidth);
		
		\node [label=180:\colorbox{black}{\textcolor{white}{##1}}] at (0,-\barx-0.175) {};
		\addtocounter{barcount}{1}
	}
	\begin{tikzpicture}
		\setcounter{barcount}{0}
}{
	\end{tikzpicture}
}


%------------------------------------------------


% Adapted from @Jake's answer at http://tex.stackexchange.com/a/82729/226
\newcommand{\wheelchart}[4][0]{%
    \begingroup\centering
    \def\innerradius{#3}%
    \def\outerradius{#2}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach \value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
      \pgfmathsetmacro{\totalrot}{-90 + #1}

      % Rotate so we start from the top
      \begin{scope}[rotate=\totalrot]

      % Loop through each value set. \cumnum keeps track of where we are in the wheel
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
            (-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

            % Draw the data labels
            % v1.6: Use accsupp so that the numeric number is copied/pasted too
            \draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\BeginAccSupp{method=pdfstringdef,ActualText={\name: \value}}\name\EndAccSupp{}};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
    \end{tikzpicture}\par
    \endgroup
}


%------------------------------------------------


%%% Label
\newcommand{\Label}[2]{% Highlight color, Text
    \tikz[baseline]\node[anchor=base,draw=#1,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex, thick]{#2};
}


%------------------------------------------------


\newcounter{a}
\newcounter{b}
\newcounter{c}

% Command to output a number of automatically-sized bubbles from a string in the format of '<size>/<label>', e.g. \bubbles{5/Eclipse, 6/git, 4/Office, 3/Inkscape, 3/Blender}
\newcommand{\bubbles}[1]{
	% Reset counters
	\setcounter{a}{0}
	\setcounter{c}{150}
	
	\begin{tikzpicture}[scale=3]
		\foreach \p/\t in {#1} {
			\addtocounter{a}{1}
			\bubble{\thea/2}{\theb}{\p/25}{\t}{1\p0}
		}
	\end{tikzpicture}
}

% Command to output a bubble at a specific position with a specific size
\newcommand{\bubble}[5]{
	\filldraw[fill=black, draw=none] (#1,0.5) circle (#3); % Bubble
	\node[label=\textcolor{black}{#4}] at (#1,0.7) {}; % Label
}


%------------------------------------------------


% Command to output a number of automatically-sized spaced bubbles
\newcommand{\spacedbubbles}[1]{
	% Reset counters
	\setcounter{a}{0}
	\setcounter{b}{0} % This counter is used to adjust the x position of each bubble based on the previous bubble's size
	
	\begin{tikzpicture}[scale=3]
		\foreach \p/\t [remember=\p as \prevp (initially 0)] in {#1} {
			\addtocounter{a}{1}
			\addtocounter{b}{\prevp}
			\spacedbubble{\thea/2+\value{b}/6}{0.5}{\p/25}{\t}{1\p0}
		}
	\end{tikzpicture}
}

% Command to output a spaced bubble
\newcommand{\spacedbubble}[5]{
	\filldraw[fill=black, draw=none] (#1, #2) circle (#3); % Bubble
	\node[label=\textcolor{black}{#4}] at (#1, #2 + 0.2) {}; % Label with a little vertical offset for clarity
}


%----------------------------------------------------------------------------------------
%	CUSTOM SECTIONS
%----------------------------------------------------------------------------------------

% Command to output section title headings
\newcommand{\cvsect}[1]{% The only parameter is the section text
	\vspace{\baselineskip} % Whitespace before the section title
	\colorbox{black}{\textcolor{white}{\MakeUppercase{\textbf{#1}}}}\\% Section title
}

%----------------------------------------------------------------------------------------
%	ENTRY LIST
%----------------------------------------------------------------------------------------

\usepackage{longtable} % Required for tables that span multiple pages
\setlength{\LTpre}{0pt} % Remove default whitespace before longtable
\setlength{\LTpost}{0pt} % Remove default whitespace after longtable

\setlength{\tabcolsep}{0pt} % No spacing between table columns

% Environment to hold a new list of entries
\newenvironment{entrylist}{
	\begin{longtable}[H]{l l}
}{
	\end{longtable}
}

\newcommand{\entry}[4]{% First argument for the leftmost date(s) text, second is for the bold entry heading, third is for the bold right-aligned entry qualifier and the fourth is for the entry description
	\parbox[t]{0.175\textwidth}{% 17.5% of the text width of the page
		#1 % Leftmost entry date(s) text
	}%
	&\parbox[t]{0.825\textwidth}{% 82.5% of the text width of the page
		\textbf{#2}% Entry heading text
		\hfill% Horizontal whitespace
		{\footnotesize \textbf{\textcolor{black}{#3}}}\\% Right-aligned entry qualifier text
		#4 % Entry description text
	}\\\\}

% Command to output a separator slash between lists, e.g. '  /  '
\newcommand{\slashsep}{\hspace{3mm}/\hspace{3mm}}
