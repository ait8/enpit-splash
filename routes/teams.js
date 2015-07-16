var express = require('express');
var router = express.Router();

var teams = require("../config/teams.json");

/* GET Teams. */
router.get('/', function(req, res, next) {
  res.send('200', teams);
});

module.exports = router;
