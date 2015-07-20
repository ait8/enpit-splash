var Keyword = require('../models/keywords');
var seeds = require('../db/seeds/keywords.json');

seeds.forEach(function(seed) {
  Keyword.addKeyword(seed, function() {
    console.log("Keyword seeds loaded.");
  },function(err) {
    console.error("Keyword seeds NOT loaded.");
  });
});
