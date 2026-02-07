

def factorial(v):

    if v<=1:
        return 1

    return v*factorial(v-1)


if __name__ == "__main__":

    test=[1,2,3,4,5,6,7]

    for e in test:
        
        out=factorial(e)
        print("test: ",e," out: ",out)
