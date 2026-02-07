



def together(lista):

    mapp={}

    for e in lista:
        count=[0]*60

        for l in e:

            index= ord(l.lower())-ord('a')
            count[index]+=1

        if tuple(count) not in mapp:
            mapp[tuple(count)]=[e]
        else:
            mapp[tuple(count)].append(e)

    out=[]
    for c,l in mapp.items():
        out.append(l)

    return out
            
        





if __name__ == "__main__":

    test=[ ["act","pots","tops","cat","stop","hat"],["x"], [""] ]


    for t in test:
        result=together(t)
        print("t: {} result: {}".format(t,result))
