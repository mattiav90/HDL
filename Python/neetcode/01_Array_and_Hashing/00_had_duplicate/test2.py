

def has_duplicate(lista):

    mapp={}

    for v  in lista:
        if v in mapp:
            mapp[v]+=1
            return True
        else:
            mapp[v]=1
    return False



if __name__ == "__main__":

    test=[[1,2,3,4,5,3,3],[1,2,3,4,5,6]]


    for i in test:
        result=has_duplicate(i)
        print("test: ",i," result: ",result)
