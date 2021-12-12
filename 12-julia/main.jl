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

function part1(edges, current, visited)
    paths = 0
    for option in edges[current]
        visited_copy = copy(visited)
        if option == "end"
            paths += 1
            continue
        end

        if option == "start"
            continue
        end

        if islowercase(option[1])
            if option in visited
                continue
            end
            push!(visited_copy, option)
        end
        
        paths += part1(edges, option, visited_copy)
    end
    paths
end

edges = parse("input.txt")
result = part1(edges, "start", [])
println("[Part1] $result")

