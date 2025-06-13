
# this is an example of recursion. 
# implement a factorial calculation using recursion


def factorial(v):

    if v<1:
        return 1

    return v* factorial(v-1)




if __name__ == "__main__":


    print("factorial")

    print("out: ",factorial(5))
