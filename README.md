#enPiT Splash
あばばばばあっば
=====
# 要求アプリケーション
* Node.js
* MongoDB

# 実行方法
1. 予め別のコンソールでMongoDBを実行しておく。
```
% mongod --dbpath <database-path>
```

2. アプリケーションを実行
```
% cd enpit-splash
% npm install
% npm start
```

`npm start` 時にエラーが出る場合は以下の設定ファイルを見直しましょう。

# 設定ファイル
`config`以下に置いてある以下3つのファイルを自分の環境に合わせて作り直し、
`.sample` を消すと動作します。
また、cloneしてすぐに動かしたいだけであれば、リネームするだけでも動きます。

- `keywords.json.sample`
- `slack.json.sample`
- `teams.json.sample`

また、送信時にSlackに通知する機能を有効化するためには
`slack.json` にSlackのアクセストークンなどの情報を置く必要があります。
これらの情報はSlackのIntegration設定画面のIncoming Webhookを参照してください。

```json
{
    "url" : "https://hooks.slack.com/services/XXXXXXXXX/hogehogehogehoge",
    "channel" : "#channel_name",
    "username" : "bot's_username",
    "icon" : ":innocent:"
}
```

======
This software is released under the MIT License, see LICENSE.txt.
