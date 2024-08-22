local pro = require"./init"
local task = require"@lune/task"

local new = pro.new(function(re)
    task.wait(1)
    re(1000)
end)

new:connect(function(data)
    print(data + 1000)
    task.wait(1)
    return data + 1000
end):connect(function(data)
    print(data + 1000)
end)