states_needed = set([“mt”, “wa”, “or”, “id”, “nv”, “ut”, “ca”, “az”])

stations = {}
stations[“kone”] = set([“id”, “nv”, “ut”])
stations[“ktwo”] = set([“wa”, “id”, “mt”])
stations[“kthree”] = set([“or”, “nv”, “ca”])
stations[“kfour”] = set([“nv”, “ut”])
stations[“kfive”] = set([“ca”, “az”])

final_stations = set()

while states_needed:
    best_station = None
    states_covered = set()
    for station, states_for_station in stations.items():
        covered = states_needed & states_for_station
        if len(covered) > len(states_covered):
        best_station = station
        states_covered = covered
    states_needed -= states_covered
    final_stations.add(best_station)

print final_stations

# But if you want to find the shortest path that connects several points,
# that’s the traveling-salesperson problem, which is NP-complete. The
# short answer: there’s no easy way to tell if the problem you’re working
# on is NP-complete. Here are some giveaways:
# • Your algorithm runs quickly with a handful of items but really slows
# down with more items.
# • “All combinations of X” usually point to an NP-complete problem.
# • Do you have to calculate “every possible version” of X because you
# can’t break it down into smaller sub-problems? Might be
# NP-complete.
# • If your problem involves a sequence (such as a sequence of cities, like
# traveling salesperson), and it’s hard to solve, it might be NP-complete.
# • If your problem involves a set (like a set of radio stations) and it’s hard
# to solve, it might be NP-complete.
# • Can you restate your problem as the set-covering problem or the
# traveling-salesperson problem? Then your problem is definitely
# NP-complete.


# Recap
# • Greedy algorithms optimize locally, hoping to end up with a global
# optimum.
# • NP-complete problems have no known fast solution.
# • If you have an NP-complete problem, your best bet is to use an
# approximation algorithm.
# • Greedy algorithms are easy to write and fast to run, so they make
# good approximation algorithms.
