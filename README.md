# SampleSwiftApp
iOS アプリ開発のおすすめ構成模索用。

## お天気アプリ
ランダムにどこかの都道府県の今日の天気を教えてくれるアプリ。履歴も保存できる！

| スタート | お天気 | 履歴（あり） | 履歴（なし） |
| --- | --- | --- | --- |
|![start](https://user-images.githubusercontent.com/34936885/85924073-c66a9600-b8ca-11ea-9176-f7664003afd9.png)|![weather](https://user-images.githubusercontent.com/34936885/85924081-ce2a3a80-b8ca-11ea-9787-a0f2f7cdc0d9.png)|![history](https://user-images.githubusercontent.com/34936885/85924087-d4b8b200-b8ca-11ea-8618-7d0e53212b6d.png)|![no_history](https://user-images.githubusercontent.com/34936885/85924094-df734700-b8ca-11ea-85ad-2cda8928a390.png)|

## 利用 API
下記 API を利用

* [livedoor天気のWeb API](http://weather.livedoor.com/weather_hacks/webservice)(商用利用不可)
* [joe schmoe](https://joeschmoe.io/)（アバター表示用）

## 開発環境
* Xcode 12.0
* Swift 5.3
* Bundler 2.1.4

Target

* iOS 12.0 
* iPhone/iPad

## セットアップ
基本的に全 push しているので pull したらすぐビルドできるはず。。。だけどもしかしたら dikitgen いるかも？ 
下記手順でインストール。（もしくはビルドするだけなら Build Phases の DIKit Run Script を削除すればいけるはず）

1. DIKit から zip をダウンロード
1. zip 解凍
1. ターミナルで解凍したディレクトリに移動
1. ターミナルで make install コマンド実行

## スキーム
* SampleSwiftApp  
通信してデータを取得する
* SampleSwiftAppDummy  
通信はせずプロジェクト内のファイルを取得する

## 使用ライブラリ
| ライブラリ | 用途 |
| --- | --- |
| [mac-cain13/R.swift](https://github.com/mac-cain13/R.swift) | リソース管理用 |
| [realm/SwiftLint](https://github.com/realm/SwiftLint) | Lint ツール |
| [ishkawa/DIKit](https://github.com/ishkawa/DIKit) | DI 用 |
| [realm/realm-cocoa](https://github.com/realm/realm-cocoa) | DB |
| [mono0926/LicensePlist](https://github.com/mono0926/LicensePlist) | ライセンス表記用（ライセンス表記は大事😇） |
| [ishkawa/APIKit](https://github.com/ishkawa/APIKit) | 通信用 |
| [SwiftyBeaver/SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) | ログ出力用 |
| [Quick/Quick](https://github.com/Quick/Quick) | テスト用 |
| [Quick/Nimble](https://github.com/Quick/Nimble) |テスト用 |

pod install する場合は bundler を利用する。下記手順でインストール。

```
// 1. インストール可能な ruby バージョンを調べる
$ rbenv install -l
 
// 2. 指定のバージョンの ruby をインストール
$ rbenv install <バージョン>
 
// 3. 使用する ruby バージョンを指定（.ruby-version ができるはず）
$ rbenv local <バージョン>
 
// 4. .zprofileに「eval "$(rbenv init -)"」追記
 
// 5.インストールした ruby を使用可能な状態にする
$ rbenv rehash
 
// 6. ターミナル再起動（.zprofile のやつ反映するため）
 
// 7. ruby のパス（/.rbenv/shims/rubyになっていれば成功）
$ which ruby
 
// 8. bundler をインストール
$ gem install bundler
 
// 9. bundler 設定（Gemfile ができるはず）
$ bundle init
 
// 10. Gemfileに「gem "cocoapods", "<バージョン>"」を追加
 
// 11. cocoapodsをインストール（Gemfile.lock ができるはず）
$ bundle install --path vendor/bundle
```

`pod install` は `bundle exec pod install` で実行する。