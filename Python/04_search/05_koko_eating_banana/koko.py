
import math

#this is the brute force solution
def koko_bf(data,h):

    maxd=max(data)
    
    for rate in range(1,maxd+1):
        hours=0
        
        for p in data:
            hours+=math.ceil(p/rate)
            
        if hours<=h:
            return rate



# basically I am implemeting a binary search on the possible range of numbers.
# the solution might be a number of hours that is smaller then the hours given. 
# so you have to consider that in the assignments. 

def koko_log(data,h):

    l=1
    r=max(data)


    while l<=r:
        m=(l+r)//2
        hours=0
        for p in data:
            hours+=math.ceil(p/m)

        if hours>h:
            l=m+1
        elif hours<=h:
            result=m
            r=m-1

    return result

        


if __name__=="__main__":

    data=[[1,4,3,2],[25,10,23,4]]
    hours=[9,4]

    print("brute force solution")
    for i in range(len(data)):
        out=koko_bf(data[i],hours[i])
        print("out: ",out)

        
    print("log solution")
    for i in range(len(data)):
        out=koko_log(data[i],hours[i])
        print("out: ",out)
       
