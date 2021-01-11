# cta_reactive_master

CA Tech Accel で iOS アプリ開発における Reactive を理解していく学習リポジトリ

## Setup

以下のコマンドを叩くことで依存しているライブラリをインストールする

```
$ make setup
```

### APIKey の追加

1. Resources ディレクトリ内に`APIKey.plist`ファイルを作成
2. 作成したファイルの Root 内に、以下を記述

- Key: newsAPIKey
- Type: String
- Value: [News API](https://newsapi.org/)で取得した API Key

### プロジェクトファイルの生成

今回このリポジトリでは [`XcodeGen`](https://github.com/yonaskolb/XcodeGen) というツールを使って `CtaReactiveMaster.xcodeproj` を生成しています。
Git の管理からも外しているため、生成しないと開発ができません。
生成するには、以下のコマンドを叩いてください。

```
$ make xcodegen
```

## Getting Started

1. このレポジトリを Fork する

2. slack の GitHub の通知チャンネルに連携する

> slack の`#ios_コロンビア_github`にて`/github subscribe https://github.com/{GITHUB_USER_ID}/cta_reactive_master reviews,comments`を叩く

3. スケジュールに沿って開発を進め、随時 PR を作成し、Approve をもらい次第 Fork したレポジトリに merge する

## Schedule

| Date                    | Title                                                                                                 | Answer Branch           | 
| ----------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------- | 
| 11/21(Sat) - 12/8(Tue)  | RxSwift を利用せずに API(https://newsapi.org/ )を叩いて一覧画面の作成、WebView を用いて詳細画面の作成             | [URL](https://github.com/CA21engineer/cta_reactive_master_answer)
| 12/8(Tue)               | Rx についての概要の説明を受ける                                                                             | -
| 12/8(Tue) - 12/22(Tue)  | Rx を用いて作成した画面を置き換える                                                                          | [URL](https://github.com/CA21engineer/cta_reactive_master_answer/tree/use-rxswift)
| 12/22(Tue)              | MVVM についての概要の説明を受ける                                                                           | -
| 11/22(Tue) - 12/29(Tue) | MVVM に置き換える                                                                                        |[URL](https://github.com/CA21engineer/cta_reactive_master_answer/tree/mvvm)
| -                       | (時間があったら)カスタマイズする(検索機能の追加(filter 処理),差分更新で実装するなど)                                 | -

_スケジュールは暫定的なものなので必要があれば随時更新する予定です。_

## CODING RULES

- base branch への直接 push は禁止(いかなる場合でも Pull Request を作成し、担当の 21 卒学生からの Approve をもらうまでは merge しない)
- AutoLayout を利用する(ViewController 作成時は Storyboard ではなく、xib を利用する)
- ライブラリを追加する際には基本的に CocoaPods を利用する(CocoaPods に対応してないものを利用する場合は相談してください)
- API のレスポンスを受け取るときは `Decodable`で処理する
