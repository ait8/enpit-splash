var express = require('express');
var router = express.Router();

var keywords = require("../config/keywords.json"),
    teams = require("../config/teams.json");

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { mentors :  keywords, teams : teams});
});

module.exports = router;
