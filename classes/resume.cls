\ProvidesClass{classes/resume}[2023/02/06 resume]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

% 2カラム,A4,フォントサイズ9pt
\LoadClass[
    twocolumn,
    paper=a4,
    fontsize=9pt,
    disablejfam,
    head_space=20mm,
    foot_space=20mm,
    gutter=15mm,
    fore-edge=15mm,
    column_gap=10mm]
    {jlreq}

\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{secdot} % sectionの数字の後のドットの制御
\sectiondot{section}
\RequirePackage{setspace} % 行間設定用パッケージ
\setstretch{0.8} % 行間設定
\RequirePackage{here} % 好きな位置にfigなどを置くためのパッケージ
\RequirePackage{bm} % ベクトルを大文字で書くためのパッケージ
\RequirePackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\RequirePackage{paralist} % インラインリストのパッケージ
\RequirePackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\RequirePackage{mathtools} % 高度な数式記述用パッケージ
\RequirePackage{newtxtext,newtxmath} % Times系フォントを使用するためのパッケージ
\RequirePackage{tabularray} % 高度な表組み用パッケージ
% \RequirePackage{minted} % ソースコード表示の用パッケージ
\RequirePackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\RequirePackage{subfiles} % 大規模な文章を分割して記述して、統合するためのパッケージ
\RequirePackage{indentfirst} % 最初の段落でインデントするためのパッケージ
\RequirePackage{type1cm} % 文字の大きさを自由に変えるためのパッケージ


\ifluatex
    % LuaTeXを日本語で使うための設定
    \RequirePackage{luatexja}
    % 日本語フォントは原ノ味フォントを使用
    \RequirePackage{luatexja-fontspec}
    \RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}

    % 図表関連のパッケージを読み込む
    \RequirePackage{graphicx}

    % ハイパーリンクを設定
    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref}
\else
    \ifuptex
        % upLaTeXのフォントを設定
        \RequirePackage[deluxe]{otf}
        \RequirePackage[haranoaji,noalphabet]{pxchfon}

        % Font shape JY2/hmc/b/n' undefined (Font) using JY2/hmc/bx/n' instead.
        \DeclareFontShape{JY2}{hmc}{b}{n}{<->ssub*hmc/bx/n}{}

        % LaTeX Font: Font shape `JT2/hmc/b/n' undefine(Font)	using `JT2/hmc/m/n' instead.
        \DeclareFontShape{JT2}{hmc}{b}{n}{<->ssub*hmc/m/n}{}

        % 図表関連のパッケージを読み込む
        \RequirePackage{color}
        \RequirePackage[dvipdfmx]{graphicx}

        % ハイパーリンクを設定
        \RequirePackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref}

    \else
        % pTeXでコンパイルしようとする場合はエラーを出す
        \ClassError{resume}{This class file is for LuaLaTeX or upLaTeX only.}{Use LuaLaTeX or upLaTeX to compile this document.}
    \fi
\fi

% \RequirePackage{enumitem} % 高機能番号付き箇条書きのパッケージ
\RequirePackage{tabularx} % 表の幅を指定するためのパッケージ
\RequirePackage[bibstyle=bibliography,sorting=none,date=year,isbn=false,doi,giveninits,urldate=iso,seconds]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}

%ページ数の書式
\pagestyle{empty}

% figの余白の調整
\setlength{\intextsep}{0pt}

% キャプションとサブキャプションの設定
\RequirePackage{silence}
\WarningFilter{caption}{Unknown document class (or package)}
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup[figure]{labelsep=quad, labelformat=simple, name=\bfseries Fig., skip=5pt, font={stretch=0.8}, belowskip=0pt}
\captionsetup[subfigure]{labelsep=space, labelformat=simple, name=\bfseries Fig., skip=3pt, font={stretch=0.8}, belowskip=0pt}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=quad, labelformat=simple, name=\bfseries Table, skip=5pt, font={stretch=0.8}, belowskip=0pt}

% 本文中のFigureとTableの表記統一のため，\Fig・\Tableを定義
% 引数としてlabelを受け取り，それを使ってFigureやTableを参照する
% \FigTableマクロの定義
\newcommand{\FigTableEq}[3][]{%
    \def\temp{#1}%
    \ifx\temp\empty
        {#2~\ref{#3}}%
    \else
        \textbf{#2~\ref{#3}}%
    \fi
}

% \Figマクロの定義
\newcommand{\Fig}[2][]{%
    \FigTableEq[#1]{Fig.}{#2}%
}

% \Figureマクロの定義
\newcommand{\Figure}[2][]{%
    \FigTableEq[#1]{Figure}{#2}%
}

% \Tableマクロの定義
\newcommand{\Table}[2][]{%
    \FigTableEq[#1]{Table}{#2}%
}

% \Equationマクロの定義
\newcommand{\Eq}[2][]{%
    \FigTableEq[#1]{Eq.}{#2}%
}

% sectionのサイズを合わせる
\RenewBlockHeading{section}{1}{font={\normalsize\bfseries},after_label_space=0\jlreq@zw}
\RenewBlockHeading{subsection}{2}{font={\normalsize\bfseries},after_label_space=0\jlreq@zw}
\RenewBlockHeading{subsubsection}{3}{font={\normalsize\bfseries},after_label_space=0\jlreq@zw}

% セクション類の空白の設定
\ModifyHeading{section}{before_space=5pt, after_space=5pt}
\ModifyHeading{subsection}{before_space=5pt, after_space=5pt}
\ModifyHeading{subsubsection}{before_space=5pt, after_space=5pt}
% セクションタイトルが一行以下なら下、２行以上なら上
% \ModifyHeading{section}{lines=1}
% \ModifyHeading{subsection}{lines=1}
% \ModifyHeading{subsubsection}{lines=1}

% セクションが連続する際の行取りを設定
\SetBlockHeadingSpaces{
    {_section{*},_subsection{before_space=0pt, after_space=5pt}}
    {_subsection{*},_subsubsection{before_space=0pt, after_space=5pt}}
}

% タイトルの設定
\makeatletter
\renewcommand{\@maketitle}{\newpage
    \centering
    \fontsize{14pt}{14pt}\selectfont
    \@title
    \par

    \vspace{.5\jlreq@zh}
    \fontsize{10pt}{10pt}\selectfont
    \@author
    \par
    \vspace{2\jlreq@zh}
}
\normalsize
\makeatother
