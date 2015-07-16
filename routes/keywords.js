var express = require('express');
var router = express.Router();

var keywords = require("../config/keywords.json");

/* GET keywords. */
router.get('/', function(req, res, next) {
  res.send('200', keywords);
});

module.exports = router;
