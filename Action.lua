function action(baseTime)
    return function(...)
        local t = table.pack(...)
        
        local start = t[1]
        local stop = t[2]
        local method = t[3]

        local params = {}
        if #t > 3 then
            for i = 4, #t do
                params[#params + 1] = t[i]
            end
        end

        if time.total >= baseTime + start and (stop == nil or time.total <= baseTime + stop) then
            method(table.unpack(params))
        end
    end
end
