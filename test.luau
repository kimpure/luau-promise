local promise = require"./init"
local task = require"@lune/task"

promise.new(function(resolve, reject)
    print(1000) -- 1000
    task.wait(1)
    resolve(1000)
end):connect(function(result)
    print(result + 1000) -- 2000
    task.wait(1)
    return result + 1000
end):connect(function(result)
    print(result + 1000) -- 3000
    task.wait(1)
    return result + 1000
end):connect(function(result)
    print(result + 1000) -- 4000
end)