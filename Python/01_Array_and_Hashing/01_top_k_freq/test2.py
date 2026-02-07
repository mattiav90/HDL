

class Solution:

    def k_top(self,nums: list[int], k: int) -> list[int]:

        count={}

        for e in nums:
            count[e] = 1 + count.get(e,0)

        freq=[[] for i in range(len(nums))]

        for e,c in count.items():
            freq[c].append(e)


        sol=[]

        for i in range(len(freq)-1,0,-1):
            for e in freq[i]:
                sol.append(e)
                if len(sol)==k:
                    return sol

        
        return count





if __name__ == "__main__":

    print("main")


    nums=[1,2,3,4,5,6,7,8,1,2,3,4,1,2,1]

    sol=Solution()

    result= sol.k_top(nums,2)

    print("nums: ",nums)
    print("k_top: ",result)
            
