using Base.Unicode

function parse(filepath)
    edges = Dict()
    open(filepath) do file
        while !eof(file)
            line = readline(file)
            left,right = split(line, "-")
            if haskey(edges, left)
                push!(edges[left], right)
            else
                edges[left] = [right]
            end
            if haskey(edges, right)
                push!(edges[right], left)
            else
                edges[right] = [left]
            end
        end
    end
    edges
end

function dfs(edges, current, visited, visited_twice)
    paths = 0
    for option in edges[current]
        visited_copy = copy(visited)
        visited_twice_copy = copy(visited_twice)
        if option == "end"
            paths += 1
            continue
        end

        if option == "start"
            continue
        end

        if islowercase(option[1])
            if option in visited
                if visited_twice_copy
                    continue
                end
                visited_twice_copy = true
            end
            push!(visited_copy, option)
        end
        
        paths += dfs(edges, option, visited_copy, visited_twice_copy)
    end
    paths
end

edges = parse("input.txt")
result = dfs(edges, "start", [], true)
println("[Part1] $result")
result = dfs(edges, "start", [], false)
println("[Part2] $result")

