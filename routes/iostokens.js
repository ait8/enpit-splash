var express = require('express');
var router = express.Router();

var IOSToken = require('../models/iostokens');


router.post('/', function(req, res, next) {
  if (!req.body.token) {
    res.status('400').send({message: "不正なパラメータです"});
    return;
  }
  var iosToken = req.body.token;
  IOSToken.addIOSToken(
    {token: iosToken},
    function() {
      res.status('201').send({});
    }, function(err) {
      console.error(err);
      res.status('500').send({message: "サーバの内部エラーです"});
    });
});

module.exports = router;
