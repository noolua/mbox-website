local cjson = require "cjson"
local json = cjson.encode({version = "0.0.1", remote_addr = ngx.var.remote_addr});
ngx.say(json);

