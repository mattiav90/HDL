

def reverse (s):

    if len(s)<=1:
        return s

    return reverse(s[1:])+s[0]

if __name__=="__main__":
    test=["sdfghjk","cccvvvbbb","ciao"]

    for t in test:
        out=reverse(t)
        print("t: {} out: {}".format(t,out))
