# MarkDownPSLocalServerWiki

PowerShell製のローカルWebサーバーとWebブラウザーを使い、Windows PC内でMarkdownページを閲覧・編集する個人用Wikiです。

外部のWebサーバーやデータベースは不要です。Wikiの本文は`doc`フォルダー内の`.md`ファイルとして保存されるため、通常のテキストファイルとしてバックアップや検索ができます。

このリポジトリは、Internet Explorer／HTAに依存する[`MarkdownLocalWiki`](https://github.com/papanda925/MarkdownLocalWiki)を、Edge、Chrome、Firefoxなどのブラウザーから使える構成へ移したものです。

> [!IMPORTANT]
> 個人PCのローカル利用を想定しています。待受先は`http://localhost:8000/`に限定していますが、Markdown内のリンクからローカルファイルやフォルダーを開く機能があります。内容を確認できないWikiデータを読み込んだり、インターネットへ公開したりしないでください。

## 主な機能

- Markdownページの表示と編集
- 新規ページ作成、名前変更、削除
- ページ一覧
- Wiki全体の文字列検索
- 表示履歴
- 文字サイズの拡大・縮小
- HTTP／HTTPSリンクを既定ブラウザーで表示
- WindowsのファイルパスやUNCパスをエクスプローラー等で開く機能
- Wikiデータを`doc\*.md`として保存

## 動作環境

- Windows 10／11
- Windows PowerShell 5.1、またはWindows上のPowerShell 7
- Edge、Chrome、Firefoxなどの現在サポートされているブラウザー
- `localhost:8000`を使用できること

## 起動方法

### 方法1：バッチファイルから起動する

1. リポジトリをダウンロードまたはクローンします。
2. `startWiki.bat`をダブルクリックします。
3. PowerShellウィンドウを閉じずに待ちます。
4. ブラウザーで`http://localhost:8000/index.html`が開きます。

### 方法2：PowerShellから起動する

```powershell
Set-Location .\MarkDownPSLocalServerWiki
.\StartWiki.ps1
```

従来のスペルミスを含む`SrartWiki.ps1`は、既存ショートカットとの互換性のため残しています。新しい手順では`StartWiki.ps1`を使用してください。

## 終了方法

起動時のPowerShellウィンドウを閉じます。ブラウザーのタブを閉じるだけでは、ローカルWebサーバーは終了しません。

## ページデータ

| 場所 | 内容 |
| --- | --- |
| `doc\トップページ.md` | 最初に表示するページ |
| `doc\*.md` | 作成したWikiページ |
| `index.html` | ブラウザー側の画面と処理 |
| `WebSV.ps1` | ローカルWebサーバーとファイル操作 |
| `core\marked.js` | MarkdownからHTMLへの変換 |
| `core\github-markdown.css` | Markdown表示用CSS |

バックアップする場合は、最低限`doc`フォルダーをコピーしてください。更新前には`doc`フォルダー全体を別の場所へバックアップすることを推奨します。

## ページ名の扱い

ページ名は`doc`フォルダー内の`.md`ファイル名として使われます。サーバー側では、次の条件を満たさないパスを拒否します。

- `doc`フォルダーの内側であること
- 拡張子が`.md`であること
- `..`などを使ってWikiフォルダー外へ移動しないこと

これにより、ブラウザーから送られたページ名でWiki外のファイルを保存・変更・削除しないようにしています。

## セキュリティ上の注意

- 待受先を`localhost`以外へ変更しないでください。
- ルーターのポート転送や外部公開用リバースプロキシを設定しないでください。
- 信頼できないMarkdownや、第三者から受け取ったWikiフォルダーをそのまま開かないでください。
- ファイル／UNCリンクをクリックすると、Windowsの関連付けに従って外部アプリが起動する場合があります。
- `core`内のJavaScriptライブラリはリポジトリへ同梱されています。更新時は互換性とライセンスを確認してください。

## 実装の概要

ブラウザーとPowerShellサーバーはJSONを使って非同期通信します。

```text
ブラウザー操作
    ↓ XMLHttpRequest / JSON
PowerShell HttpListener（localhost:8000）
    ↓ パス検証
docフォルダー内のMarkdownファイル
```

`HttpListener.BeginGetContext`で次のリクエスト受付を登録し、ブラウザー側は`XMLHttpRequest`のコールバックで画面を更新します。

## 制限事項

- 個人利用向けのサンプルであり、複数利用者、ログイン、権限管理には非対応
- HTTPS、認証、CSRF対策など、公開Webサービス向けの機能はなし
- ページの同時編集や競合解決はなし
- Markdown変換は同梱版`marked.js`の仕様に依存
- 自動バックアップ、世代管理、ごみ箱はなし
- Windowsの`Shell.Application`を使うため、Windows以外では動作しない

## トラブルシューティング

### ブラウザーが開かない

PowerShellウィンドウにエラーがないか確認し、手動で次を開きます。

```text
http://localhost:8000/index.html
```

### ポートを使用できない

別のアプリがポート8000を使っている可能性があります。

```powershell
Get-NetTCPConnection -LocalPort 8000 -ErrorAction SilentlyContinue
```

### スクリプト実行が禁止されている

```powershell
Get-ExecutionPolicy -List
```

組織管理のPCでは管理者の方針に従ってください。`startWiki.bat`の`RemoteSigned`指定は、そのPowerShellプロセス内だけに適用されます。

### ページが保存できない

リポジトリのフォルダーと`doc`フォルダーに書き込み権限があるか確認してください。OneDriveやネットワークドライブ上では、同期・権限設定の影響を受ける場合があります。

## 参考資料

- [HttpListener class](https://learn.microsoft.com/dotnet/api/system.net.httplistener)
- [HttpListener.BeginGetContext](https://learn.microsoft.com/dotnet/api/system.net.httplistener.begingetcontext)
- [Using XMLHttpRequest](https://developer.mozilla.org/docs/Web/API/XMLHttpRequest_API/Using_XMLHttpRequest)
- [marked](https://github.com/markedjs/marked)
- [github-markdown-css](https://github.com/sindresorhus/github-markdown-css)
- [Polaris](https://github.com/PowerShell/Polaris)

## English summary

A Windows-only personal Markdown wiki backed by plain `.md` files and served through a localhost-only PowerShell `HttpListener`. It is not designed for internet exposure or multi-user hosting.
