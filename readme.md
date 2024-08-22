luau promise

use 
```lua
local pro = require"path"
local task = require"@lune/task"

local new = pro.new(function(re)
    task.wait(1)
    re(1000)
end)

new:connect(function(data)
    -- data = 1000
    print(data + 1000)
    task.wait(1)
    return data + 1000
end):connect(function(data)
    --data = 2000
    print(data + 1000)
end)
```