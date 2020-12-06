# cta_reactive_master

CA Tech AccelでiOSアプリ開発におけるReactiveを理解していく学習リポジトリ

## Setup

以下のコマンドを叩くことで依存しているライブラリをインストールする

```
$ make setup
```

### パッケージインストール

```
$ mint bootstrap
```

### APIKeyの追加

1. Resourcesディレクトリ内に`APIKey.plist`ファイルを作成
2. 作成したファイルのRoot内に、以下を記述
  - Key: newsAPIKey
  - Type: String
  - Value: [News API](https://newsapi.org/)で取得したAPI Key

## Getting Started

1. このレポジトリをForkする

2. slackのGitHubの通知チャンネルに連携する

> slackの`#ios_コロンビア_github`にて`/github subscribe https://github.com/{GITHUB_USER_ID}/cta_reactive_master reviews,comments`を叩く

3. スケジュールに沿って開発を進め、随時PRを作成し、Approveをもらい次第Forkしたレポジトリにmergeする

## Schedule

| Date | Title |
| ------------- | ------------- |
| 11/21(Sat) - 12/8(Tue) | RxSwiftを利用せずにAPI(https://newsapi.org/ )を叩いて一覧画面の作成、WebViewを用いて詳細画面の作成 |
| 12/8(Tue) | Rxについての概要の説明を受ける |
| 12/8(Tue) - 12/22(Tue) | Rxを用いて作成した画面を置き換える |
| 12/22(Tue) | MVVMについての概要の説明を受ける |
| 11/22(Tue) - 12/29(Tue) | MVVMに置き換える |
| - | (時間があったら)カスタマイズする(検索機能の追加(filter処理),差分更新で実装するなど) |

*スケジュールは暫定的なものなので必要があれば随時更新する予定です。*

## CODING RULES

- base branchへの直接pushは禁止(いかなる場合でもPull Requestを作成し、担当の21卒学生からのApproveをもらうまではmergeしない)
- AutoLayoutを利用する(ViewController作成時はStoryboardではなく、xibを利用する)
- ライブラリを追加する際には基本的にCocoaPodsを利用する(CocoaPodsに対応してないものを利用する場合は相談してください)
- APIのレスポンスを受け取るときは `Decodable`で処理する
