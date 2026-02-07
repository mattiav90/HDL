
import random



def generate(N):
	
	lista = list(range( ord('a') , ord('z')  ))
	lista.append( ord(' ') )

	word=[]
	for i in range(N):
		word.append(chr(random.choice(lista)))
	
	out = "".join(word)
	
	return out 

	





def score(inn):
	
	target='methinks it is like a vessel'
	
	length=len(target)
	
	
	c=0
	for i,l in enumerate(inn):
		if l==target[i]:
			c+=1

	similar= (c/length)*100
	

	
		
	
	return similar




def run(max):
	
	dimension=27

	
	for i in range(max):
		
		attempt= generate(dimension)
		result = score(attempt)
		
		if (result==100):
			print("got it!!! : ",attempt)
		elif (result>30):
			print("Not bad. score: ",result," string: ",attempt)

	print("timed out")



run(1000000000000000)

