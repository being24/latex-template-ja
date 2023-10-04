\ProvidesClass{classes/report}[2023/02/20 report]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
% \RequirePackage{plautopatch}

% 2カラム,A4,フォントサイズ9pt
\LoadClass[
    paper=a4,
    fontsize=11pt,
    disablejfam,
    head_space=25mm,
    foot_space=25mm,
    gutter=25mm,
    fore-edge=25mm,
    report]
    {jlreq}

\PassOptionsToPackage{hyphens}{url}
\usepackage{luatexja} % LuaLaTeXに移行
\usepackage{setspace} % 行間設定用パッケージ
\usepackage{caption} % キャプションとサブキャプションのパッケージ
\usepackage{subcaption}
\usepackage{here} % 好きな位置にfigなどを置くためのパッケージ
\usepackage{bm} % ベクトルを大文字で書くためのパッケージ
\usepackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\usepackage{enumitem} % 高機能番号付き箇条書きのパッケージ
\usepackage{paralist} % インラインリストのパッケージ
\usepackage{graphicx} % 画像の挿入、テキストや図の操作のためのパッケージ
\usepackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\usepackage{mathtools} % 高度な数式記述用パッケージ
\usepackage{tabularray} % 高度な表組み用パッケージ
\usepackage{tgtermes} % 欧文、数式のフォントをtimes系に
\usepackage[T1]{fontenc} % 欧文フォントをT1エンコーディングに
% \usepackage{minted} % ソースコード表示の用パッケージ
\usepackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\usepackage{subfiles} % 大規模な文章を分割して記述して、統合するためのパッケージ
\usepackage{indentfirst} % 最初の段落でインデントするためのパッケージ
\usepackage{framed} % 囲み付き文章を出すためのパッケージ
\usepackage{type1cm} % 文字の大きさを自由に変えるためのパッケージ
\usepackage[unicode,hidelinks,pdfusetitle]{hyperref} % ハイパーリンクをつけるためのパッケージ
\usepackage{tabularx} % 表の幅を指定するためのパッケージ
\usepackage[backend=biber,style=trad-unsrt]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}
\DeclareFieldFormat{journaltitle}{\textit{#1}} % 日本語雑誌名を通常に、英語雑誌名を斜体に

% キャプションとサブキャプションの設定
\captionsetup[figure]{labelsep=space, name=Fig.}
\captionsetup[subfigure]{labelsep=space, labelformat=simple, name=Fig.}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=space, name=Table}

% sectionのサイズを合わせる
\RenewBlockHeading{section}{1}{font={\jlreq@keepbaselineskip{\normalsize\bfseries}},after_label_space=1\jlreq@zw}
\RenewBlockHeading{subsection}{2}{font={\jlreq@keepbaselineskip{\normalsize\bfseries}},after_label_space=1\jlreq@zw}
\RenewBlockHeading{subsubsection}{3}{font={\jlreq@keepbaselineskip{\normalsize\bfseries}},after_label_space=1\jlreq@zw}

% セクション類の空白の設定
% \ModifyHeading{section}{before_space=5pt, after_space=5pt}
% \ModifyHeading{subsection}{before_space=5pt, after_space=5pt}
% \ModifyHeading{subsubsection}{before_space=5pt, after_space=5pt}
% セクションタイトルが一行以下なら下、２行以上なら上
\ModifyHeading{section}{lines=1}
\ModifyHeading{subsection}{lines=1}
\ModifyHeading{subsubsection}{lines=1}

\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}
