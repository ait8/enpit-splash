var mongoose =  require('./models'),
    Schema = mongoose.Schema;

var IOSTokenSchema = new Schema({
  token : String
});

var IOSTokenModel = mongoose.model('IOSToken', IOSTokenSchema);

var IOSToken = (function() {
  var _IOSToken = {};

  _IOSToken.findAll = function(success, fail) {
    var IOSTokenQuery = IOSTokenModel.where({});
    IOSTokenQuery.find().select('token').lean().exec(function(err, result) {
      if (err) {
        fail(err, result);
        return;
      }
      success(result);
    });
  };

  _IOSToken.addIOSToken = function(token, success, fail) {
    var newIOSToken = new IOSTokenModel(token);
    newIOSToken.save(function(err) {
      if (err) {
        fail(err);
        return;
      }
      success();
    });
  };

  return _IOSToken;
})();

module.exports = IOSToken;
