\ProvidesClass{classes/resume}[2023/02/06 resume]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

% 2カラム,A4,フォントサイズ9pt
\LoadClass[
    two column,
    paper=a4,
    fontsize=9pt,
    disablejfam,
    head_space=20mm,
    foot_space=20mm,
    gutter=15mm,
    fore-edge=15mm,
    column_gap=10mm]
    {jlreq}

\usepackage{secdot} % sectionの数字の後のドットの制御
\sectiondot{subsection}
\usepackage{setspace} % 行間設定用パッケージ
\setstretch{0.8} % 行間設定
\usepackage{caption} % キャプションとサブキャプションのパッケージ
\usepackage{subcaption}
\usepackage{here} % 好きな位置にfigなどを置くためのパッケージ
\usepackage{bm} % ベクトルを大文字で書くためのパッケージ
\usepackage[hyphens]{url} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\usepackage{enumerate} % 高機能番号付き箇条書きのパッケージ
\usepackage[dvipdfmx]{graphicx} % 画像の挿入、テキストや図の操作のためのパッケージ
\usepackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\usepackage[T1]{fontenc} % 欧文フォントを標準以外に
\usepackage{times} % 欧文、数式のフォントをtimes系に
\usepackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\usepackage{subfiles} % 大規模な文章を分割して記述して、統合するためのパッケージ
\usepackage{indentfirst} % 最初の段落でインデントするためのパッケージ
\usepackage[backend=biber,style=ieee]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}
\usepackage[dvipdfmx]{hyperref} % ハイパーリンクをつけるためのパッケージ
\usepackage{pxjahyper} % しおりを日本語化するためのパッケージ
\usepackage{tabularx} % 表の幅を指定するためのパッケージ

%ページ数の書式
\pagestyle{empty}

% キャプションとサブキャプションの設定
\captionsetup[figure]{labelsep=space, compatibility=false, name=Fig.}
\captionsetup[subfigure]{labelsep=space, labelformat=simple, compatibility=false, name=Fig.}
\captionsetup[table]{labelsep=space, compatibility=false, name=Table}

% sectionのサイズを合わせる
\RenewBlockHeading{section}{1}{font={\jlreq@keepbaselineskip{\normalsize\bfseries}},after_label_space=0\jlreq@zw}
\RenewBlockHeading{subsection}{2}{font={\jlreq@keepbaselineskip{\normalsize\bfseries}},after_label_space=0\jlreq@zw}
\RenewBlockHeading{subsubsection}{3}{font={\jlreq@keepbaselineskip{\normalsize\bfseries}},after_label_space=0\jlreq@zw}

% セクション類の空白の設定
% \ModifyHeading{section}{before_space=5pt, after_space=5pt}
% \ModifyHeading{subsection}{before_space=5pt, after_space=5pt}
% \ModifyHeading{subsubsection}{before_space=5pt, after_space=5pt}
\ModifyHeading{section}{lines=1}
\ModifyHeading{subsection}{lines=1}
\ModifyHeading{subsubsection}{lines=1}

% タイトルの設定
\makeatletter
\renewcommand{\@maketitle}{\newpage
    \centering
    \fontsize{14truept}{14truept}\selectfont
    \@title
    \par

    \vspace{.5\jlreq@zh}
    \fontsize{10truept}{10truept}\selectfont
    \@author
    \par
    \vspace{2\jlreq@zh}
}
\normalsize
\makeatother
