

# this is a second method to do permutations in a list. 
# might actually be nicer than the first one. 

#this is implemented with recursion


def permute(l):
    out=[]

    def per(cur,rem):

        if not rem: 
            out.append(cur)
            return

        for i in range(len(rem)):
            per(cur+[rem[i]] , rem[:i]+rem[i+1:])


    per([],l)
    return out





lista=[1,2,3]


print(permute(lista))




