\ProvidesClass{classes/report}[2023/02/20 report]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

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


\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{setspace} % 行間設定用パッケージ
\RequirePackage{caption} % キャプションとサブキャプションのパッケージ
\RequirePackage{subcaption}
\RequirePackage{here} % 好きな位置にfigなどを置くためのパッケージ
\RequirePackage{bm} % ベクトルを大文字で書くためのパッケージ
\RequirePackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\RequirePackage{paralist} % インラインリストのパッケージ
\RequirePackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\RequirePackage{tabularray} % 高度な表組み用パッケージ
% \RequirePackage{minted} % ソースコード表示の用パッケージ
\RequirePackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\RequirePackage{subfiles} % 大規模な文章を分割して記述して、統合するためのパッケージ
\RequirePackage{indentfirst} % 最初の段落でインデントするためのパッケージ
\RequirePackage{framed} % 囲み付き文章を出すためのパッケージ
\RequirePackage{type1cm} % 文字の大きさを自由に変えるためのパッケージ
\RequirePackage{tikz} % 図を描くためのパッケージ

\ifptex
    \ifnativeuptex
    %upLaTeX
        \RequirePackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref} % ハイパーリンクをつけるためのパッケージ、unicodeの使用を許可、リンクの下線を消す、pdfのメタデータをタイトルにする
        \RequirePackage[T1]{fontenc} % 欧文フォントをT1エンコーディングに
        \RequirePackage{newtxmath} % 数式フォントをnewtxmathにする
        \RequirePackage{tgtermes} % 本文フォントをTeX Gyre Termesにする
    
        \else
    %pLaTeX
    \fi
\fi

\ifluatex
    % LuaLaTeX
    \RequirePackage{luatexja}
    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref} % ハイパーリンクをつけるためのパッケージ、unicodeの使用を許可、リンクの下線罫線を消す、pdfのメタデータをタイトルにする、pdfのバージョンを1.4にする
    % \RequirePackage{hyperxmp} % PDFのメタデータを設定するためのパッケージ

    \RequirePackage[scale=1]{luatexja-fontspec}
    \RequirePackage[haranoaji,deluxe]{luatexja-preset}

    \setmainfont[BoldFont=TeXGyreTermes-Bold,ItalicFont=TeXGyreTermes-Italic,Ligatures=TeX]{TeXGyreTermes}
    \setsansfont[BoldFont=TeXGyreHeros-Bold,ItalicFont=TeXGyreHeros-Italic,Ligatures=TeX]{TeXGyreHeros}

    \RequirePackage{unicode-math}
    \setmathfont{TeX Gyre Termes Math}
    
\fi

\RequirePackage{enumitem} % 高機能番号付き箇条書きのパッケージ
\RequirePackage{tabularx} % 表の幅を指定するためのパッケージ
\RequirePackage[backend=biber,style=trad-unsrt]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}
\DeclareFieldFormat*{journaltitle}{\textit{#1}} % 日本語雑誌名を通常に、英語雑誌名を斜体に
\DeclareFieldFormat*{title}{\textit{#1}}
\DeclareFieldFormat[inproceedings]{booktitle}{\textit{#1}}
\DeclareFieldFormat[book]{title}{\textit{#1}}


% キャプションとサブキャプションの設定
\captionsetup[figure]{labelsep=space, labelformat=simple, name=Fig.}
\captionsetup[subfigure]{labelsep=space, labelformat=simple, name=Fig.}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=space, labelformat=simple, name=Table}

% sectionのサイズを合わせる
\RenewBlockHeading{chapter}{0}{indent=1\jlreq@zw,lines=6,label_format={第\thechapter 章},font={\huge},after_label_space=1\jlreq@zw,second_heading_text_indent={-1\jlreq@zw,1\jlreq@zw},subtitle_font={\jlreq@keepbaselineskip{\Large}}}
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
