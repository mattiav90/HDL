



def is_palindrome_iterative(s):

    left  = 0
    right = len(s)-1

    while left<right:

        while left<right and not s[left].isalnum():
            left+=1
        while left<right and not s[right].isalnum():
            right-=1

        if s[left].lower() != s[right].lower():
            return False

        left+=1
        right-=1
        
    
    return True


    

def is_palindrome_recursive(s):

    def check(left,right):

        while left<right and not s[left].isalnum():
            left+=1
        while left<right and not s[right].isalnum():
            right-=1

        if left>right:
            return True

        if s[left].lower() != s[right].lower():
            return False

        return check(left+1,right-1)
    
    return check(0,len(s)-1)






examples = [
    "A man, a plan, a canal: Panama",  # True
    "race a car",                      # False
    "No 'x' in Nixon",                 # True
    " ",                               # True
    "ab@a",                            # True
]

for s in examples:
    print(is_palindrome_iterative(s))

print("-----")
for s in examples:
    print(is_palindrome_recursive(s))

