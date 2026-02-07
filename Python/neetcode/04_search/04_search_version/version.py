



def version(data):

    l=0
    r=len(data)-1

    while l<=r:

        m=(l+r)//2

        if data[m]:
            r=m-1
            result=m
        else:
            l=m+1
        

    return result





    



if __name__=="__main__":
    print("version")

    data=[[False,True],[False,False,False,False,True,True,True,True,True],[False,False,True,True,True]]

    for v in data:
        out=version(v)
        print("out: ",out)
    
