local graph = {}

graph.__index = graph

graph.Edge = {}
graph.Edge.__index = graph.Edge

--!strict

-- graph.Edge.create - Create a new edge between:
-- @params <any> v
-- @params <any> w
-- @params <number?> weight - Determines weight in shortest-path considerations.
function graph.Edge.create(v, w, weight: number?)
    local s = {}
    setmetatable(s, graph.Edge)

    if weight == nil then
        weight = 1.0
    end

    s.v = v
    s.w = w
    s.weight = weight

    return s
end

-- graph.Edge:from() - Returns origin of edge
function graph.Edge:from()
    return self.v
end

-- graph.Edge:to() - Returns end of edge
function graph.Edge:to()
    return self.w;
end

-- graph.Edge:either() - Returns origin of edge
function graph.Edge:either()
    return self.v
end

-- graph.Edge:other() - Returns edge omitted from:
-- @params <any> x - Other Vertice ignored.
function graph.Edge:other(x)
    if x == self.v then
        return self.w
    else
        return self.v
    end

end

-- graph.create - Create a new graph from:
-- @params <number> V - Amount of vertices to create.
-- @params <boolean?> directed
function graph.create(V, directed: boolean?)
    local g = setmetatable({}, graph)
    
    g.vertexList = require(script.list).create()
    g.adjList = {}
    for v = 0,V-1 do
        g.vertexList:add(v)
        g.adjList[v] = require(script.list).create()
    end
    g.directed = directed ~= nil and true or false

    return g
end

-- graph:vertexCount() - Returns amount of vertices in current graph.
function graph:vertexCount()
    return self.vertexList:size()
end

-- graph:vertexCount() - Returns vertices in current graph.
function graph:vertices()
    return self.vertexList
end

-- graph.createFromVertexList - Create a new graph from:
-- @params <any[]> V - Vertices to create.
-- @params <boolean?> directed
function graph.createFromVertexList(vertices, directed: boolean?)
    local g = setmetatable({}, graph)
    

    if directed == nil then
        directed = false
    end

    g.vertexList = vertices
    g.adjList = {}
    for i = 0,g.vertexList:size()-1 do
        local v = g.vertexList:get(i)
        g.adjList[v] = require(script.list).create()
    end
    g.directed = directed ~= nil and true or false

    return g
end

-- graph:addVertexIfNotExists() - Add a vertice if it doesn't exist in graph:
-- @params <any> v - Vertice to append.
function graph:addVertexIfNotExists(v)
    if self.vertexList:contains(v) then
        return false
    else
        self.vertexList:add(v)
        self.adjList[v] = require(script.list).create()
        return true
    end
end

-- graph:removeVertex - Remove a vertice from graph:
-- @params <any> v - Vertice to remove.
function graph:removeVertex(v)
    if self.vertexList:contains(v) then
        self.vertexList:remove(v)
        self.adjList[v] = nil
        for i=0,self.vertexList:size()-1 do
            local w = self.vertexList:get(i)
            local adj_w = self.adjList[w]
            for k = 0,adj_w:size()-1 do
                local e = adj_w:get(k)
                if e:other(w) == v then
                    adj_w:removeAt(k)
                    break
                end

            end

        end

    end
end

-- graph.createFromVertexList - Create a new graph from:
-- @params <any> v - Vertice to check for.
function graph:containsVertex(v)
    return self.vertexList:contains(v)
end

-- graph:adj()
-- @params <any> v
function graph:adj(v)
    return self.adjList[v]
end

-- graph:addEdge() - Create a new graph from:
-- @params <any[]> V - Vertices to 
function graph:addEdge(v, w, weight: number?)
    local e = graph.Edge.create(v, w, weight)
    self:addVertexIfNotExists(v)
    self:addVertexIfNotExists(w)
    if self.directed then
        self.adjList[e:from()]:add(e)
    else
        self.adjList[e:from()]:add(e)
        self.adjList[e:to()]:add(e)
    end

end

function graph:reverse()
    local g = graph.createFromVertexList(self.vertexList, self.directed)
    for k=0,self:vertexCount()-1 do
        local v = self:vertexAt(k)
        local adj_v = self:adj(v)
        for i=0,adj_v:size()-1 do
            local e = adj_v:get(i)
            g:addEdge(e:to(), e:from(), e.weight)
        end

    end

    return g
end

function graph:vertexAt(i)
    return self.vertexList:get(i)
end

function graph:edges()
    local list = require('luagraphs.data.list').create()

    for i=0,self.vertexList:size()-1 do
        local v = self.vertexList:get(i)
        local adj_v = self:adj(v)
        for i=0,adj_v:size()-1 do
            local e = adj_v:get(i)
            local w = e:other(v)
            if self.directed == true or w > v then
                list:add(e)
            end

        end

    end

    return list
end

function graph:hasEdge(v, w)
    local adj_v = self:adj(v)
    for i=0,adj_v:size()-1 do
        local e = adj_v:get(i)
        if e:to() == w then
            return true
        end
    end
    return false
end

return graph
