\ProvidesClass{resumed}[2021/07/14 v1.0.0 Typeset a sleek one-page resume]

% Dimensions

\DeclareOption{a4}{
    \setlength\paperwidth{210mm}
    \setlength\paperheight{297mm}
}

\DeclareOption{letter}{
    \setlength\paperwidth{8.5in}
    \setlength\paperheight{11in}
}

\ExecuteOptions{a4}

% Fonts

\DeclareOption{10pt}{\def\@ptsize{0}} % We strongly recommend 10pt!
\DeclareOption{11pt}{\def\@ptsize{1}}
\DeclareOption{12pt}{\def\@ptsize{2}}

\ExecuteOptions{11pt}

\ProcessOptions\relax
\input{size1\@ptsize.clo}

% Packages used for formatting and logic

\RequirePackage[top = 1cm, bottom = 1cm, left = 1cm, right = 1cm]{geometry}

\RequirePackage{tikz}

\pgfdeclarelayer{bckg}
\pgfsetlayers{bckg,main}

\RequirePackage{macrolist} % used for socials formatting; written by Dennis Chen 2021/07/13

% Colors

\RequirePackage{xcolor}

\definecolor{headerorange}{HTML}{f0aa00}
\definecolor{footergray}{HTML}{454550}

% Info commands

\def\@name{}
\def\@position{}
\def\@address{}
\def\@socials{}
\def\@socialcount{}
\newcommand\setsocials{}
\macronewlist{socials} % From macrolist

\newcommand\addsocial[1]{
    \ifnum\listsize{socials}<\@socialcount\relax
    
    \else
        \ClassError{resumed}{Social list already full}{You may not add a social when the number of defined socials is equal to the social count.}    
    \fi
}

% Set info

\def\name#1{\def\@name{#1}}
\def\position#1{\def\@position{#1}}
\def\address#1{\def\@address{#1}}
% \def\socialcount#1{
%     \let\@oldsocialcount\@socialcount
%     \def\@socialcount{#1}
    
%     % Cut off last socials if socialcount decreases
    
%     \ifnum\@socialcount<\@oldsocialcount\relax
%         %\foreach \@index in {1, ..., \the\numexpr\@oldsocialcount-\@socialcount\relax} {
%             %\macrolistremovelast{socials}
%         %}    
%     \fi
    
%     % % Set socials
    
%     % \renewcommand\setsocials[#1]{
%     %     \macrolistclear{socials}
%     %     \foreach \@index in {1, ..., \@socialcount} {
%     %         \macrolistadd{socials}{##\@index}
%     %     }
%     % }
% }

% % Default info

% \socialcount{4}

% Fonts

\RequirePackage{newpxtext}

% TO-DO get better font(s) for title

% Header

\newcommand{\header}{
    \begin{tikzpicture}[remember picture, overlay]
        \draw (current page.north) node (headerbox) [text width = \paperwidth, anchor = north] {
            \begin{center}
            \vskip 2.5mm
                {\color{white}\Huge\MakeUppercase{\@name}}
            \vskip 5mm
                {\Large\@position}
            \vskip 2.5mm
            \end{center}
        };
        \begin{pgfonlayer}{bckg}
            \filldraw[headerorange] (headerbox.north west) rectangle (headerbox.south east);
        \end{pgfonlayer}
    \end{tikzpicture}
}

\newcommand{\footer}{
    \begin{tikzpicture}[remember picture, overlay]
        \draw (current page.south) node (footerbox) [text width = \paperwidth, anchor = south] {
            \begin{center}
                \vskip 2.5mm
                    {\color{white}\@address}
                \vskip 1mm
                    \@socials
                \vskip 2.5mm
            \end{center}
        };
        \begin{pgfonlayer}{bckg}
            \filldraw[footergray] (footerbox.north west) rectangle (footerbox.south east);
        \end{pgfonlayer}
    \end{tikzpicture}
}

% Hook to typeset header and footer

\AtBeginDocument{
    \header
    \footer
}