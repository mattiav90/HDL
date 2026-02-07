


def anagram(s1,s2):

    if len(s1)!=len(s2):
        return False


    mapp1={}
    mapp2={}
            

    for c1,c2 in zip(s1,s2):

        if c1 not in mapp1:
            mapp1[c1]=1
        else:
            mapp1[c1]+=1

        if c2 not in mapp2:
            mapp2[c2]=1
        else:
            mapp2[c2]+=1

    return mapp1==mapp2





if __name__=="__main__":

    test=[["racecar","racecar"],["jar","jam"],["x","xx"],["pillo","pallo"],["onomato","otamono"]]


    
    for t in test:

        result=anagram(t[0],t[1])
        print("[ {} , {} ] result: {}".format(t[0],t[1],result))
