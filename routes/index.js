var express = require('express');
var router = express.Router();

var mentors = require("../config/mentors.json"),
    teams = require("../config/teams.json");

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { mentors :  mentors, teams : teams});
});

module.exports = router;
