


class Solution:

    def anagrams(self, s: str, t: str) -> bool:

        if len(t)!=len(s):
            return False

        ct={}
        cs={}


        for i in range(len(t)):

            cs[s[i]] = 1 + cs.get(s[i],0)
            ct[t[i]] = 1 + ct.get(t[i],0)


        return (cs==ct)





if __name__ == "__main__":

    print("main")

    s="ciao"
    t="oaaic"
    t1="ccc"

    sol=Solution()

    result=sol.anagrams(s,t)

    print("result: ",result)
