# 日本語論文をLaTeXで書いて、textlintをするためのテンプレート

<https://poyo.hatenablog.jp/entry/2020/12/05/110000>

## 機能

* 個人環境にLaTeX workshopを構築せず、dockerでビルドします
* GitHub Actionsを使用してtextlintを実行します
* github上にreleaseします
* レジュメや論文用のテンプレートを持ちますが、あくまで個人の環境用に構築したものです

## 環境

* macOS 10.14 or later
* Ubuntu 18.04 LTS or later
* Windows 10

Docker環境が必要ですが、多少弄ればCloud LaTeX等でも使用できます

* Docker Desktop for Mac 2.1 or later
* Docker 18.06 or later
* Docker Desktop for Windows

Ubuntu 20.04 LTS上の TeX Live 2021を使用します  
ビルド用のdocker imageは<https://github.com/being24/latex-docker>を参照してください

また、VSCodeが必要です

![demo](figures/screenshot.png)

## License

CC0

## Author

Being

## config

VSCode上での設定例は[settings.json](/settings.json)を参照してください

## テンプレートについて

できるだけモダナイズを意識して作成したテンプレートですが、LaTeXに詳しいわけではないので誤りがあった場合は教えていただけると幸いです

jlistingの代わりにmintedを使用し、参考文献はbiblatexを使用します

### resume.cls

[resume.cls](/resume.cls)は2段組みのレジュメを作成するためのクラスファイルです  
使用方法は[例](/example/resume_template.tex)を参照してください

### report.cls

[report.cls](/report.cls)は論文を作成するためのクラスファイルです  
使用方法は[例](/example/report_template.tex)を参照してください
