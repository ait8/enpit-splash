var express = require('express');
var router = express.Router();

var Keyword = require('../models/keywords');

/* GET keywords. */
router.get('/', function(req, res, next) {
  Keyword.findAll(function(result){
    res.status('200').send(result);
  }, function(err, result) {
    res.status('500').send({message: "サーバの内部エラーです"});
  });
});

router.post('/', function(req, res, next) {
  if (!req.body.keyword) {
    res.status('400').send({message: "不正なパラメータです"});
    return;
  }

  var keyword = req.body.keyword;
  Keyword.addKeyword(
    {text: keyword, send_count: 0},
    function() {
      res.status('201').send({});
    }, function(err) {
      console.error(err.message);
      res.status(err.status).send({message: err.message});
    });
});

module.exports = router;
