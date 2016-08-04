# To recap, Dijkstra’s algorithm has four steps:
# 1. Find the cheapest node. This is the node you can get to in the least
# amount of time.
# 2. Check whether there’s a cheaper path to the neighbors of this node.
# If so, update their costs.
# 3. Repeat until you’ve done this for every node in the graph.
# 4. Calculate the final path. (Coming up in the next section!)

graph[“start”] = {}
graph[“start”][“a”] = 6
graph[“start”][“b”] = 2

graph[“a”] = {}
graph[“a”][“fin”] = 1

graph[“b”] = {}
graph[“b”][“a”] = 3
graph[“b”][“fin”] = 5

graph[“fin”] = {}

infinity = float(“inf”)
costs = {}
costs[“a”] = 6
costs[“b”] = 2
costs[“fin”] = infinity

parents = {}
parents[“a”] = “start”
parents[“b”] = “start”
parents[“fin”] = None

processed = []

node = find_lowest_cost_node(costs)

while node is not None:
    cost = costs[node]
    neighbors = graph[node]
    for n in neighbors.keys():
        new_cost = cost + neieghbors[n]
        if costs[n] > new_cost:
            costs[n] = new_cost
            parents[n] = node
    processed.append(node)
    node = find_lowest_cost_node(costs)

def find_lowest_cost_node(costs):
    lowest_cost = float("inf")
    lowest_cost_node = None
    for node in costs:
        cost = costs[node]
        if cost < lowest_cost and node not in processed:
            lowest_cost = cost
            lowest_cost_node = node
    return lowest_cost_node

# Recap
# • Breadth-first search is used to calculate the shortest path for
# an unweighted graph.
# • Dijkstra’s algorithm is used to calculate the shortest path for
# a weighted graph.
# • Dijkstra’s algorithm works when all the weights are positive.
# • If you have negative weights, use the Bellman-Ford algorithm.
