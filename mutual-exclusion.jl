nsize = 6

function IsIllegal(config)
    count = 0

    if config[1] == config[nsize]
        count += 1
    end

    for i in 2:nsize 
        if config[i-1] == config[i] 
            continue
        end

        count += 1

        if count == 2
            return true
        end
    end

    return false
end

function GenerateConfigsHelper(i, set)
    while true
        if i == nsize + 1
            return set
        end

        newSet = Set()
        for j in 0:(nsize-1)
            for config in set
                newConfig = deepcopy(config)
                newConfig[i] = j
                push!(newSet, newConfig)
            end
        end

        i+= 1
        set = newSet
    end

end

function GenerateAllConfigs()
    zero = zeros(UInt8, nsize)
    myS = Set{Array{UInt8, 1}}()
    push!(myS, zero)
    return GenerateConfigsHelper(1, myS)
end

function MaxSteps()
    configs = GenerateAllConfigs()
    
    configs = Set{Array{UInt8, 1}}(filter(x -> IsIllegal(x), configs))
    steps = 0
    while length(configs) != 0
        newConfigs = Set{Array{UInt8, 1}}()

        for config in configs
            if config[1] == config[nsize]
                newConfig = deepcopy(config)
                newConfig[1] = (newConfig[1] + 1) % (nsize + 1)
                push!(newConfigs, newConfig)
            end

            for i in 2:nsize 
                if config[i-1] == config[i]
                    continue
                end

                newConfig = deepcopy(config)
                newConfig[i] = newConfig[i-1]
                push!(newConfigs, newConfig)
            end
        end

        configs = Set{Array{UInt8, 1}}(filter(x -> IsIllegal(x), newConfigs))
        steps += 1
        println("Finished step ", steps)
    end

    return steps
end    

println(MaxSteps())