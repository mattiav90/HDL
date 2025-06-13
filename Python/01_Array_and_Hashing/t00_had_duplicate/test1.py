


class Solution:
    def duplicate(self,nums: list[int]) -> bool:

        maps={}

        for e in nums:
            maps[e] = 1+ maps.get(e,0)
            if maps[e]>1:
                return True

        return False

    


if __name__ == "__main__":
    print("main")


    nums=[1,2,3,4,1]

    sol=Solution();

    result=sol.duplicate(nums)

    print("nums: ",nums)
    print("result: ",result)
            


    
