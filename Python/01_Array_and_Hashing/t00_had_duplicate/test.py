

class Solution:

    # this solution has time complexity at max O(n)
    # has memory complexity O(n)
    def duplicate(self,nums: list[int]) -> bool:

        maps={}

        out=False
        for e in nums:
            maps[e] = 1 + maps.get(e,0)
            if maps[e]>1:
                return True
        
        return out





if __name__ == "__main__":

    print("main")

    test=Solution()

    print("duplicate: ",test.duplicate([1,3,2,3]))
