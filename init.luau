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
    catch: { t: boolean, m: string },
}, {} :: PromiseImpl));

local promise = {} :: PromiseImpl;
promise.__index = promise

function promise.new(fn)

    local self = setmetatable({
        resolve = nil,
        catch = { t = false, m = '' },
    }, promise)

    if fn then
        local s, p = pcall(function()
            fn( function(result)
                self.resolve = result
            end, function(errorMessage)
                self.catch.t = true
                self.catch.m = ''
            end)
        end)
       
        if s then
            self.catch.t = true;
            self.catch.m = p
        end
    end

    return self;
end

function promise.connect(self, fn)
    if self.catch then
        error('')
    end


    if fn then
        local data = fn(self.resolve)
        if data then
            self.resolve = data
        end
    end

    return self
end

return promise