from collections import deque

graph = {}
graph[“you”] = [“alice”, “bob”, “claire”]
graph[“bob”] = [“anuj”, “peggy”]
graph[“alice”] = [“peggy”]
graph[“claire”] = [“thom”, “jonny”]
graph[“anuj”] = []
graph[“peggy”] = []
graph[“thom”] = []
graph[“jonny”] = []

def search():
    search_queue = deque()
    search_queue += graph["you"]
    searched = []
    while search_queue:
        person = seaerch_queue.popleft()
        if not person in searched:
            if person_is_seller(person):
                print person + " is a mango seller!"
                return true
            else:
                search_queue += graph[person]
            return false

def person_is_seller(name):
    return name[-1] == 'm'

# Recap
# • Breadth-first search tells you if there’s a path from A to B.
# • If there’s a path, breadth-first search will find the shortest path.
# • If you have a problem like “find the shortest X,” try modeling your
# problem as a graph, and use breadth-first search to solve.
# • A directed graph has arrows, and the relationship follows the
# direction of the arrow (rama -> adit means “rama owes adit money”).
# • Undirected graphs don’t have arrows, and the relationship goes both
# ways (ross - rachel means “ross dated rachel and rachel dated ross”).
# • Queues are FIFO (First In, First Out).
# • Stacks are LIFO (Last In, First Out).
# • You need to check people in the order they were added to the search
# list, so the search list needs to be a queue. Otherwise, you won’t get
# the shortest path.
# • Once you check someone, make sure you don’t check them again.
# Otherwise, you might end up in an infinite loop.
