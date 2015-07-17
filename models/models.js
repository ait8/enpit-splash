var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/enpit-splash');
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
  console.log('Connected to "enpit-splash" database');
});

module.exports = mongoose;
