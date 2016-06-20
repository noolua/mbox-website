local cjson = require "cjson";
local runtime = require "runtime";
local mboxs = runtime.mboxs;
if not mboxs then
  runtime.mboxs = {};
  mboxs = runtime.mboxs;
end
runtime.mboxs = mboxs;

local err_json = cjson.encode({error = -1});

local function do_it()
  local cmd = ngx.var.arg_cmd;
  local callback = ngx.var.arg_callback;
  local param = ngx.var.arg_param;
  local hash_key = ngx.md5(ngx.var.remote_addr);
  local one = mboxs[hash_key];
  if not one then
    mboxs[hash_key] = {param = ""};
    one = mboxs[hash_key];
  end
  local res = {error = 0};
  if cmd == "update" then
    one.param = param;
  elseif cmd == "query" then
    res.param = one.param;
  end
  if not callback then
    ngx.say(cjson.encode(res));
  else
    local jsonp = string.format("%s('%s');", callback, cjson.encode(res));
    ngx.say(jsonp);
  end
end
do_it();

