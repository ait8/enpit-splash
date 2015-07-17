enPiT Splash
==============

# 実行方法
```
% cd enpit-splash
% npm install
% npm start
```

現時点では、`config`以下に置いてある以下3つのファイルの
`.sample` を削除しないと動きません。

- `keywords.json.sample`
- `slack.json.sample`
- `teams.json.sample`

また、送信時にSlackに送信する機能は
`slack.json` にSlackのアクセストークンなどの情報を置く必要があります。

```json
{
    "url" : "https://hooks.slack.com/services/XXXXXXXXX/hogehogehogehoge",
    "channel" : "#channel_name",
    "username" : "bot's_username",
    "icon" : ":innocent:"
}
```
