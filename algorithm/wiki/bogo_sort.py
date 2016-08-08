# 在计算机科学中，Bogo排序（bogo-sort）是個既不實用又原始的排序演算法，其原理等同將一堆卡片拋起，落在桌上後檢查卡片是否已整齊排列好，若非就再拋一次from random import shuffle
from itertools import izip, tee

def in_order(my_list):
    """Check if my_list is ordered"""
    it1, it2 = tee(my_list)
    it2.next()
    return all(a<=b for a,b in izip(it1, it2))

def bogo_sort(my_list):
    """Bogo-sorts my_list in place."""
    while not in_order(my_list):
        shuffle(my_list)
