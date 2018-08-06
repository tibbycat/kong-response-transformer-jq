require("jq")

local table_insert = table.insert
local pcall = pcall

local _M = {}

function _M.is_json_body(content_type)
  return content_type and find(lower(content_type), "application/json", nil, true)
end

function _M.transform_jq_body(conf, buffered_data)
  if buffered_data then
    local status, res = pcall(jq, conf.jq, buffered_data)
    if status then
      if res then
        return res
      else
        return buffered_data
      end
    end
  end
end

return _M
