


def power(b,p):

    if p<=0:
        return 1

    return b * power(b,p-1)






if __name__=="__main__":

    base=2
    powa=10

    out= power(base,powa)

    print(out)
