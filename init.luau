--!strict

type fn = ((resolve: (result: any) -> (), reject: (errorMessage: string) -> ()) -> ())
type fn2 = ((result: any) -> (any))

type PromiseImpl = {
    __index: PromiseImpl,
    new: (fn?) -> (promise),
    connect: (self: promise, fn: fn2?) -> (promise),
};

export type promise = typeof(setmetatable({} :: {
    resolve: any,
}, {} :: PromiseImpl));

local promise = {} :: PromiseImpl;
promise.__index = promise

function promise.new(fn)

    local self = setmetatable({
        resolve = nil,
    }, promise)

    if fn then
        fn( function(result)
            self.resolve = result
        end, function(errorMessage)
            error(errorMessage)
        end)
    end

    return self;
end

function promise.connect(self, fn)
    
    if fn then
        local data = fn(self.resolve)
        if data then
            self.resolve = data
        end
    end

    return self
end

return promise