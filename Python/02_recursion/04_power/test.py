

# implement the power function with recursion


def power(v,p):

    if p==0:
        return 1s

    return v * power(v,p-1)





if __name__ == "__main__":

    print("power function")

    print("out: ",power(2,4))
