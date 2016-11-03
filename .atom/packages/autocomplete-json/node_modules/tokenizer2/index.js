var core = require("./core");
var through2 = require("through2");

module.exports = function(){
  var t = core(function(err, token){
    if(err){
      token_stream.emit("error", err);
    }else{
      token_stream.push(token);
    }
  });

  var token_stream = through2.obj(function(chunk, enc, done){
    t.onText(chunk.toString());
    done();
  }, function(done){
    t.end(done);
  });
  token_stream.addRule = t.addRule;
  return token_stream;
};
