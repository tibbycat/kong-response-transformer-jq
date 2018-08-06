local BasePlugin = require "kong.plugins.base_plugin"
local jq_filter = require "kong.plugins.response-transformer-jq.jq_transformer"

local table_concat = table.concat

local ResponseTransformerHandlerJq = BasePlugin:extend()


function ResponseTransformerHandlerJq:new()
  ResponseTransformerHandlerJq.super.new(self, "response-transformer-jq")
end

function ResponseTransformerHandlerJq:access(conf)
  ResponseTransformerHandlerJq.super.access(self)

  local ctx = ngx.ctx

  ctx.rt_body_chunks = {}
  ctx.rt_body_chunk_number = 1
end

function ResponseTransformerHandlerJq:body_filter(conf)
  ResponseTransformerHandlerJq.super.body_filter(self)

  local ctx = ngx.ctx
  local chunk, eof = ngx.arg[1], ngx.arg[2]
  if eof then
    local body = jq_filter.transform_jq_body(conf, table_concat(ctx.rt_body_chunks))
    ngx.arg[1] = body
  else
    ctx.rt_body_chunks[ctx.rt_body_chunk_number] = chunk
    ctx.rt_body_chunk_number = ctx.rt_body_chunk_number + 1
    ngx.arg[1] = nil
  end
end

ResponseTransformerHandlerJq.PRIORITY = 800
ResponseTransformerHandlerJq.VERSION = "0.1.0"

return ResponseTransformerHandlerJq
