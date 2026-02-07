



def twoSum(numbers,target):
    
    for i in range(len(numbers)):
        for j in range(i+1,len(numbers)):

            if(numbers[i]+numbers[j]==target):
                return [i+1,j+1]






if __name__ == "__main__":

   test= [1,2,3,4]
   target=3


   output=twoSum(test,target)
   print("test: {} target: {} output: {}".format(test,target,output))
