# generate all permitations of a list of unique integers 



def permute(nums):
    if len(nums) == 0:
        return [[]]
    res = []
    for i in range(len(nums)):
        for p in permute(nums[:i] + nums[i+1:]):
            res.append([nums[i]] + p)
    return res




test=[1,2,3]


print("out: ",permute(test))
