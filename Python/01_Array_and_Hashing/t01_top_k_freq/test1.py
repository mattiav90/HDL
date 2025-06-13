

class Solution:

    # I use sorting here so the time complexity is O(n*log(n))
    # and the memory complexity is O(n)
    def sorting(self,nums: list[int], k: int) -> list[int]:

        maps={}

        for e in nums:
            maps[e] = 1 + maps.get(e,0)

        print("original count: ",maps)


        freq=[]
        for e,c in maps.items():
            freq.append([c,e])

        freq.sort()

        out=[]
        for i in range(k):
            out.append(freq.pop()[1])
        
        return out

    # done with a bucket. 
    # here I do not use sorting so the time complexity is O(n) and the mem complexity O(n)
    def bucket(self,nums: list[int],k: int ) -> list[int]:

        maps={}

        for e in nums:
            maps[e] = 1 + maps.get(e,0)

        freq = [[] for i in range(len(nums))]

        for e in maps:
            freq[maps[e]].append(e)

        out=[]
        for i in range(len(freq)-1,0,-1) :

            for e in freq[i]:
                out.append(e)

                if(len(out)==k):
                    return out
        return out

        




if __name__ == "__main__":

    print("main")

    test=Solution()
    

    print("sorting: ",test.sorting([1,1,3,4,4,4,4,2,3,1],3))
    print("bucket: ",test.bucket([1,1,3,4,4,4,4,2,3,1],3))
