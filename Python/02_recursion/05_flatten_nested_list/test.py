

# take in a list of lists, and then flatten it out. 


def flatten(lst):

    out=[]

    for i in lst:

        if isinstance(i,list):
            out.extend(flatten(i))
        else:
            out.append(i)

    return out




if __name__ == "__main__":

    print("flatten nested list")

    lista= [1, [2, [3, 4]], 5]

    print("out: ",flatten(lista))

 
