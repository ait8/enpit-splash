var mongoose =  require('./models'),
    Schema = mongoose.Schema;

var KeywordSchema = new Schema({
  text       : String,
  send_count : Number
});

var KeywordModel = mongoose.model('Keyword', KeywordSchema);

var Keyword = (function() {
  var _Keyword = {};

  _Keyword.findAll = function(success, fail) {
    var keywordsQuery = KeywordModel.where({});
    keywordsQuery.find().select('text send_count').lean().exec(function(err, result) {
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
