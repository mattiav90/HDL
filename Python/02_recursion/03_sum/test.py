

#return the sum of the numbers in a number. 

def summ(d):

    if d==0:
        return 0
    return summ(d//10) + d%10




if __name__ == "__main__":

    print("sum")

    num=123455

    print("out: ",summ(num))
