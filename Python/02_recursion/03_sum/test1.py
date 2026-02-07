

def summ(val):

    if val<=9:
        return val

    return summ(int(val/10))+val%10






if __name__ == "__main__":

    print("sum")

    num=123455

    print("out: ",summ(num))
    
