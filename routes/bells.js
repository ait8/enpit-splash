var express = require('express');
var request = require("request");
var slack = require("../config/slack.json");
var router = express.Router();

var apns = require('apn');
var apn_options = {
  cert    : "./config/splash-cert.pem",
  key     : "./config/splash-noenc.pem",
  gateway : "gateway.sandbox.push.apple.com",
  port    : 2195
};
var apnConnection = new apns.Connection(apn_options);

router.get('/', function(req, res, next) {
  if (!req.query.keywords || !req.query.team) {
    res.status(400);
    res.send('400', {message: "不正なパラメータです"});
    return;
  }

  var keywords = req.query.keywords;
  var team = req.query.team;

  var message = "次のキーワードに関して *" + team + "* がヘルプを求めています *「" + keywords + "」*";

  var IOSToken = require('../models/iostokens');
  IOSToken.findAll(function(result){
    result.forEach(function(token) {
      var device = new apns.Device(token.token);
      var note = new apns.Notification();
      note.alert = message;
      note.payload = {keyword: keywords, team: "Test team"};
      apnConnection.pushNotification(note, device);
    });
  }, function(err, result){
    console.log(err);
  });


  request.post({
    url: slack.url,
    form: {
      payload: JSON.stringify({
        channel: slack.channel,
        username: slack.username,
        text: "<!channel>: " + message,
        icon_emoji: slack.icon
      })
    }
  }, function(err, res, body) {
    if (err) {
      console.error(err, body);
    }
    console.log(body);
  });

  res.status(200).send({message: "Send Bell"});
});

module.exports = router;
