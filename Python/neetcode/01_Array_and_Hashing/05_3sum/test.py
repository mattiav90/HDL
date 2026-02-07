
def threeSum(nums):
    
    l=len(nums)
    out=[]

    for i in range(l):
        for j in range(i+1,l):
            for k in range(j+1,l):
                if nums[i]+nums[j]+nums[k]==0:
                    temp=[nums[i],nums[j],nums[k]]
                    temp.sort()
                    if temp not in out:
                        out.append(temp)

    return out


if __name__ == "__main__":

    test=[[-1,0,1,2,-1,-4],[0,1,1],[0,0,0]]

    for i in test:
        output=threeSum(i)

        print("test: {} out: {}".format(i,output))
