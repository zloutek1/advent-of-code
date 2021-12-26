PriorityQueue = {
    __index = {
        put = function(self, p, v)
            local q = self[p]
            if not q then
                q = {first = 1, last = 0}
                self[p] = q
            end
            q.last = q.last + 1
            q[q.last] = v
        end,
        pop = function(self)
            -- sort keys
            local sorted_keys = {}
            for k in pairs(self) do table.insert(sorted_keys, k) end
            table.sort(sorted_keys)

            for _, p in ipairs(sorted_keys) do
                q = self[p]
                if q.first <= q.last then
                    local v = q[q.first]
                    q[q.first] = nil
                    q.first = q.first + 1
                    return p, v
                else
                    self[p] = nil
                end
            end
        end
    },
    __call = function(cls)
        return setmetatable({}, cls)
    end
}

setmetatable(PriorityQueue, PriorityQueue)




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


function print_grid(table, w, h)
    for y = 1, h do
        for x = 1, w do
            if table[y][x] == nil then
                io.write(" nil")
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

function print_queue(pq)
    for prio, queue in pairs(pq) do
        for key, item in pairs(queue) do
            if key ~= "first" and key ~= "last" then
                io.write(string.format("(%d, (%d, %d)), ", prio, getX(item) - 1, getY(item) - 1))
            end
        end
    end
    print()
end


function print_arr(arr)
    for i = 1, #arr do
        if arr[i] == nil then
            io.write("nil, ")
        else
            io.write(string.format("%d, ", arr[i]))
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

function dijkstra(graph, start, goal)

    queue = PriorityQueue()
    queue:put(0, start)

    visited = {}

    for risk, current in queue.pop, queue do
        if current == goal then
            return risk
        end

        if visited[current] ~= nil then
            goto continue
        end

        visited[current] = true

        for _, neighbor in pairs(getNeighbors(graph, current)) do
            if visited[neighbor] == nil then
                local x, y = getX(neighbor), getY(neighbor)
                queue:put(risk + graph[x][y], neighbor)
            end
        end

        ::continue::
    end
end


function extend_grid(grid, offsetX, offsetY)
    for y = (DIMENSIONS * offsetY + 1), (DIMENSIONS * (offsetY + 1)) do
        for x = (DIMENSIONS * offsetX + 1), (DIMENSIONS * (offsetX + 1)) do
            i = (y - 1) % DIMENSIONS + 1
            j = (x - 1) % DIMENSIONS + 1

            if grid[y] == nil then
                grid[y] = {}
            end
            grid[y][x] = (grid[i][j] + offsetX + offsetY - 1) % 9 + 1
        end
    end
    return grid
end


function part1()
    DIMENSIONS = #graph
    start = point(1, 1)
    goal = point(DIMENSIONS, DIMENSIONS)

    result = dijkstra(graph, start, goal)
    print("[Part1]", result)
end

function part2()
    for offsetY = 0, 4 do
        for offsetX = 0, 4 do
            graph = extend_grid(graph, offsetX, offsetY)
        end
    end

    DIMENSIONS = #graph
    start = point(1, 1)
    goal = point(DIMENSIONS, DIMENSIONS)

    result = dijkstra(graph, start, goal)
    print("[Part2]", result)
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

graph = parseFile("input.txt")

part1()
part2()


