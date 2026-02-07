

class Solution:

    def group_anagrams(self, strs: list[str]) -> list[list[str]]:

        count={{} for i in range(len(strs))}


        for i, st in enumerate(strs):
            #map of a string
            for c in st:
                count[c] = count.get(c,0)


                
                
                
                

            
            
            

        return 0




if __name__ == "__main__":

    print("main")

    sol=Solution();

    strs = ["act","pots","tops","cat","stop","hat"]
    out=sol.group_anagrams(strs)

    print("out:",out)
