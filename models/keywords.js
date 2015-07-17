var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var KeywordSchema = new Schema({
  name       : String,
  send_count : Number
});
mongoose.model('Keyword', KeywordSchema);
var KeywordModel;

mongoose.connect('mongodb://localhost/enpit-splash');
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
  console.log('Connected to "enpit-splash" database');
  KeywordModel = mongoose.model('Keyword');
});

var Keyword = (function() {
  var _Keyword = {};

  _Keyword.findAll = function(success, fail) {
    var keywordsQuery = KeywordModel.where({});
    keywordsQuery.find().lean().exec(function(err, result) {
      if (err) {
        fail(err, result);
        return;
      }
      success(result);
    });
  };

  _Keyword.addKeyword = function(keyword, success, fail) {
    var newKeyword = new KeywordModel(keyword);
    newKeyword.save(function(err) {
      if (err) {
        fail(err);
        return;
      }
      success();
    });
  };

  return _Keyword;
})();

module.exports = Keyword;
