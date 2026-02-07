
#implement the reverse of a string using recursion



def reverse(s):

    if len(s)<=1:
        return s
    
    return reverse(s[1:]) + s[0]




if __name__ == "__main__":

    print("reverse a string")

    str1="pillopallo"

    print("out: ",reverse(str1))
    
    
