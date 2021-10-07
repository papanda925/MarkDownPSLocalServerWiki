# MarkdownPSLocalSerVerWiki
Markdown Local Server Wiki, that is made with Power Shell Web Server, Marked.js  and so on..

MarkDown記法が使える、ディスクトップ上で動くwiki のローカルサーバ版

## 使い方：
  
  リポジトリ―をダウンロードし、中に入っている「startWiki.bat」を起動すると利用開始です。（外部サーバ不要）
  
  作成したコンテンツ（mdファイル）は、docフォルダに格納されてきます。
  
　コンテンツにはマークダウン技法が使えます。
 　

## ツール解説

- Internet Explorer のサービス終了[^1]に備え、MarkdownLocalWiki（HTA版）[^2]をローカルWebサーバ版[^3]に作りなおしたもの。

- ブラウザからローカルWebサーバへの通信には　XMLHttpRequestを使ってJson形式[^4]の電文を非同期通信することとした。

- ローカルWebサーバはPolaris[^5]を参考にBeginGetContextを使った非同期通信とした。

- markdown技法については、Marked.jsのライブラリ[^6]、CSSを使ったボタンの実装、外観はgithub[^7]風にした。

- 機能はMarkdownLocalWiki(HTA版)と同等[^8]


[^1]:Internet Explorer は Microsoft Edge へ – Windows 10 の Internet Explorer 11 デスクトップアプリは 2022 年 6 月 15 日にサポート終了
https://blogs.windows.com/japan/2021/05/19/the-future-of-internet-explorer-on-windows-10-is-in-microsoft-edge/

[^2]:HTA(HTML Applications)
https://ja.wikipedia.org/wiki/%E3%83%80%E3%82%A4%E3%83%8A%E3%83%9F%E3%83%83%E3%82%AFHTML
HTAは、Internet Explorerと密接関係しているため将来性が不明
[^3]:ローカルWebサーバ
・ローカルWebサーバがあれば、ブラウザ（Edge、chrome、FireFox等）との間でJavascript(XMLHttpRequest)を通信が使える。
・ローカルWebサーバをPowerShellで作成することで、ブラウザからの指示で、特定フォルダをターゲットに好きにファイル処理、フォルダ処理ができる。
　（HTML5だけでは好きにファイル処理、フォルダ処理ができない。）

[^4]:Json形式
参考サイトにより、独自に電文方式を決めてJson形式データをブラウザ、ローカルWebサーバ双方で授受する仕様とした。
https://qiita.com/keniooi/items/458732fc8f29cc8e445a
https://mebee.info/2020/10/25/post-20785/

[^5]:Polaris PowerShellで実装されたWebサーバ
https://github.com/PowerShell/Polaris

[^6]:marked
https://github.com/markedjs/marked

[^7]:github-markdown-css
https://github.com/sindresorhus/github-markdown-css


[^8]:MarkdownLocalWiki
https://github.com/papanda925/MarkdownLocalWiki


