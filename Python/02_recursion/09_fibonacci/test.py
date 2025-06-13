
# implement the fibonacci sequence with recursion


# the time complexity O(n)
# but the memory complexity is acally high because I am calling 2 fibonaccy at the same time. 



def fib(n):

    if n<=1:
        return n

    return fib(n-1)+fib(n-2)



print("out: ",fib(10))
