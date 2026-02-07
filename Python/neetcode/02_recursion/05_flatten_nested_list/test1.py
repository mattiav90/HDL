


def flatten(lista):

    if len(lista)<=1:
        return list


    return extend(lista[0]) + flatten(lista[1:])   








if __name__ == "__main__":

    print("flatten nested list")

    lista= [1, [2, [3, 4]], 5]

    print("out: ",flatten(lista))

 
