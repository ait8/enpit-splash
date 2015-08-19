var mongoose =  require('./models'),
    Schema = mongoose.Schema;

var LogSchema = new Schema({
  team    : String,
  keyword : String,
  timestamp : {type: Date, default: Date.now}
});

var LogModel = mongoose.model('Log', LogSchema);

var Log = (function() {
  var _Log = {};

  _Log.addLog = function(team, keyword, success, fail) {
    var newLog = new LogModel({team: team, keyword: keyword});
    newLog.save(function(err) {
      if (err) {
        fail({status: 500, message: err});
        return;
      }
      success();
    });
  };

  return _Log;
})();

module.exports = Log;
