function action(baseTime)
    return function(t)
        local start = t[1]
        local stop = t[2]
        local actionType = t[3]
        local object = t[4]
        local act = t[5]
        local params = t[6] or {}
        
        if start ~= nil and stop ~= nil then
            params.duration = ((stop - start) + 1) / 60
        end

        if act and (time.total == baseTime + start or (time.total > baseTime + start and
            actionType == "each")) then
            
            object[act](params)
        end
        
        if time.total >= baseTime + start and ((stop == nil) or
            (time.total <= baseTime + stop)) then
            
            if object["draw"] then
                object["draw"](params)
            end
        end
    end
end
