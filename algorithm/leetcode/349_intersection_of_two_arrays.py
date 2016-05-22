import collections
def intersersection(nums1, nums2):
    return list(set(nums1) & set(nums2))

print intersersection([1,2,2,1], [2,2])

def intersect(nums1, nums2):
    ans = []
    nums1 = collections.Counter(nums1)
    print nums1
    for x in nums2:
        if x in nums1:
            ans.append(x)
            nums1[x] -= 1
            if nums1[x] == 0:
                del nums1[x]
    return ans

print intersect([1,2,2,1], [2,2])
