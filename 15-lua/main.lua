function equals(a, b)
    if #a ~= #b then
        return false
    end
    for k, v in pairs(a) do
        if v ~= b[k] then
            return false
        end
    end
    return true
end

function contains(table, val)
    for _, v in pairs(table) do
       if v == val then
          return true
       end
    end
    return false
 end

 function default(value, default)
    if value == nil then
        return default
    end
    return value
end




function print_distances(table)
    for y = 1, DIMENSIONS do
        for x = 1, DIMENSIONS do
            if table[point(x, y)] == nil then
                io.write("nil ")
            else
                io.write(string.format("% 4d", table[point(x, y)]))
            end
        end
        print()
    end
end


function print_grid(table)
    for y = 1, DIMENSIONS do
        for x = 1, DIMENSIONS do
            if table[y][x] == nil then
                io.write("nil ")
            else
                io.write(string.format("% 4d", table[y][x]))
            end
        end
        print()
    end
end

function print_path(arr)
    for i = 1, #arr do
        if arr[i] == nil then
            io.write("nil ")
        else
            io.write(string.format("(%d, %d), ", getX(arr[i]), getY(arr[i])))
        end
    end
end




function point(x, y)
    return (x - 1) + (y - 1) * DIMENSIONS
end

function getY(index)
    return index // DIMENSIONS + 1
end

function getX(index)
    return index - (getY(index) - 1) * DIMENSIONS + 1
end



function getNeighbors(graph, pos)
    local x, y = getX(pos), getY(pos)

    neighbors = {}
    if y > 1 then table.insert(neighbors, point(x, y - 1)) end
    if x > 1 then table.insert(neighbors, point(x - 1, y)) end
    if y < DIMENSIONS then table.insert(neighbors, point(x, y + 1)) end
    if x < DIMENSIONS then table.insert(neighbors, point(x + 1, y)) end

    return neighbors
end

function dijkstra(graph, start)

    distances = {}
    distances[start] = graph[getY(start)][getX(start)]

    toVisit = { start }
    visited = {}

    parent = {}

    local i = 1
    while #toVisit > 0 do
        local current = toVisit[i]
        table.insert(visited, current)

        if current == nil then
            return { distances = distances, parent = parent }
        end

        for _, neighbor in pairs(getNeighbors(graph, current)) do
            local x, y = getX(neighbor), getY(neighbor)
            local distance = graph[y][x]

            if not contains(visited, neighbor) then
                local oldCost = default(distances[neighbor], 9999)
                local newCost = distances[current] + distance

                if newCost < oldCost then
                    table.insert(toVisit, neighbor)
                    distances[neighbor] = newCost
                    parent[neighbor] = current
                end
            end
        end
        i = i + 1
    end
end

function getPath(parent, goal)
    local path = {goal}

    local current = goal

    while parent[parent[current]] ~= nil do
        table.insert(path, parent[current])
        current = parent[current]
    end

    return path
end

function sumPath(graph, path)
    local sum = 0

    for _, cell in pairs(path) do
        sum = sum + graph[getY(cell)][getX(cell)]
    end

    return sum
end

function parseFile(filename)
    local graph = {}
    local file = io.open(filename, "r")
    local y = 1
    for line in file:lines() do
        graph[y] = {}
        for x = 1, #line do
            graph[y][x] = tonumber(line:sub(x, x))
        end
        y = y + 1
    end
    file:close()
    return graph
end

DIMENSIONS = 100
start = point(1, 1)
goal = point(DIMENSIONS, DIMENSIONS)

graph = parseFile("input.txt")

result = dijkstra(graph, start)
distances, parent = result["distances"], result["parent"]
path = getPath(parent, goal)

print("[Part1]", sumPath(graph, path) - 1)
