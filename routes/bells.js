var express = require('express');
var request = require("request");
var slack = require("../config/slack.json");
var router = express.Router();

router.get('/', function(req, res, next) {
  if (!req.query.keywords) {
    res.status(400);
    res.send('400', {message: "不正なパラメータです"});
    return;
  }

  var keywords = req.query.keywords;
  request.post({
    url: slack.url,
    form: {
      payload: JSON.stringify({
        channel: slack.channel,
        username: slack.username,
        text: "<!channel>: 次のキーワードに関して参加者がヘルプを求めています *「" + keywords + "」*",
        icon_emoji: slack.icon
      })
    }
  }, function(err, res, body) {
    if (err) {
      console.err(err, body);
    }
    console.log(body);
  });
  res.status(200);
  res.send({message: "Send Bell"});
});

module.exports = router;
