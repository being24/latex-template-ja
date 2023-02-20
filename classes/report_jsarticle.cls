\ProvidesClass{classes/report}[2021/02/16 report]

\RequirePackage{plautopatch}
\LoadClass[a4paper, 11pt, uplatex, dvipdfmx]{jsreport}
\plautopatchdisable{eso-pic}

\usepackage{subfiles}
\usepackage{listings}
\usepackage{plistings}
\usepackage{color}
\usepackage[dvipdfmx]{graphicx}
\usepackage[hyphens]{url}
\urlstyle{same}
\usepackage{siunitx}
\usepackage{enumerate}
\usepackage{paralist}
\usepackage{amsmath,amssymb}
\usepackage{mathtools}
\usepackage{times}
\usepackage[newfloat]{minted}
\usepackage[hang,small,bf,labelsep=space]{caption}
\usepackage[subrefformat=parens]{subcaption}
\usepackage[dvipdfmx]{hyperref}
\usepackage{pxjahyper}
\usepackage{framed}
\usepackage{type1cm}
\usepackage[truedimen,margin=25truemm]{geometry}
\usepackage{pdfpages}
\usepackage[backend=biber,style=ieee]{biblatex}
\addbibresource{references.bib}
\captionsetup{compatibility=false}


\newcommand{\code}[1]{\texttt{#1}}

\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

\renewcommand{\figurename}{\normalsize Fig.}
\renewcommand{\tablename}{\normalsize Table}

\SetupFloatingEnvironment{listing}{name=Code.}