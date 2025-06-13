

# this implements the factorial of a number using recursive functions.

# time complexity is O(n).

# the memory complexity is also O(n) for the recursion case. 
# the memory complexit is O(1) for the iterative case

# iterative function
def factorial_s(v):
    out=1
    for i in range(1,v+1,1):
        out=out*i
    return out


# recursive function
def factorial(v):
    if v==0:
        return 1
    return v * factorial(v-1)




print("factorial: ",factorial(3))
print("factorial: ",factorial_s(3))
