



def binary_search(data,target):

    ROW=len(data)
    COL=len(data[0])

    l=0
    r=ROW*COL

    while l<=r:

        m=(r+l)//2

        col=m%COL
        row=m//COL

        if data[row][col]==target:
            return True
        elif  data[row][col]<target:
            l=m+1
        else:
            r=m-1

    return False

    




if __name__=="__main__":


    matrix = [ [[1,3,5,7],[10,11,16,20],[23,30,34,60]], [[1,3,5,7],[10,11,16,20],[23,30,34,60]] , [[1,2,4,8],[10,11,12,13],[14,20,30,40]] ]
    target = [ 3, 13,1,2,3,4,5,6,7,8,9]


    for i in range(len(target)):
        out=binary_search(matrix[i%3],target[i])
        print("looking for {} in {} found: {}".format(target[i],matrix[i%2],out))
