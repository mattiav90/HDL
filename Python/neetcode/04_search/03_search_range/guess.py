



def guessa(n):

    l=0
    r=n
    print("looking")

    while l<=r:
        m=(l+r)//2
        print("m:",m)

        if guess(m)==0:
            return m
        elif guess(m)>0:
            l=m+1
        elif guess(m)<0:
            r=m-1

    return -1


def guess(m):

    target=8

    if m==target:
        return 0
    elif m>target:
        return -1
    elif m<target:
        return 1




if __name__=="__main__":

    print(guessa(10))
    print(guessa(100))
    print(guessa(20))
