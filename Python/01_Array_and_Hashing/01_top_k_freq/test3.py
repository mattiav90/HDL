


def top_k(lista,k):

    mapp={}

    for e in lista:
        if e not in mapp:
            mapp[e]=1
        else:
            mapp[e]+=1

    my=[]
    for e,c in mapp.items():
        my.append([c,e])

    my.sort(reverse=True)

    out=[]

    for i in range(k):
        out.append(my[i][1])


    return out
    
        





if __name__ == "__main__":

    test=[ [1,2,2,3,3,3] , [7,7] ]
    k=[2,1]
    
    for i in range(len(k)):
        result=top_k(test[i],k[i])
        print("{} k={} res={}".format(test[i],k[i],result))
