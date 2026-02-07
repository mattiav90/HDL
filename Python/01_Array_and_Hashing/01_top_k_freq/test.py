

class Solution:

    #this solution uses sorting. 
    #this one has time O(n*logn) because I use sort. 
    def topKFreq(self,nums: list[int], k: int) -> list[int]:

        count = {}

        for e in nums:
            count[e] = 1 + count.get(e,0)

        arr=[]

        for num,cnt in count.items():
            arr.append([cnt,num])

        arr.sort()

        out=[]
        while len(out)<k:
            out.append(arr.pop()[1])

        return out


    #this other solution uses a so called bucket sort. 
    #this solution has time complexity only O(n) beacuse I use the bucket approach.
    def bucket(self, nums: list[int], k: int) -> list[int]:

        count={}

        for e in nums:
            count[e] = 1 + count.get(e,0)

        print("count: ",count)

        freq = [[] for i in range(len(nums)+1)]

        for num, cnt in count.items():
            freq[cnt].append(num)

        print("freq: ",freq)

        res=[]
        for i in range(len(freq)-1,0,-1):
            for e in freq[i]:
                res.append(e)

                if (len(res)==k):
                    return res



if __name__ == "__main__":
    print("main")  
    test = Solution()

    data=[1,5,7,2,1,2,1,1]

   # out = test.topKFreq(data,3)
    out = test.bucket(data,3)

    print("out: ",out)
