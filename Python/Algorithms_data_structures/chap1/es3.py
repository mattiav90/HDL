


class Fraction:
	def __init__(self,up,down):
		
		if type(up) is not int:
			raise	ValueError("please enter integers for num and denum")
		if type(down) is not int:
			raise ValueError("enter an integer")
		
		use=self.gcd(up,down)
		self.num=up//use
		self.den=down//use
	
	def show(self):
		print(self.num,"/",self.den)
	
	def __str__(self):
		return str(self.num) + "/" + str(self.den)

	def gcd(self,m,n):
		while m%n!=0:
			old_m=m
			old_n=n
			
			m=old_n
			n=old_m%old_n
		return n

	def __add__(self,other):
		
		denum=self.den*other.den
		num=self.num*other.den + other.num*self.den
		
		return Fraction(num,denum)
	
	def __sub__(self,other):
		
		denum=self.den*other.den
		numer=self.num*other.den - self.den*other.num
		return Fraction(numer,denum)
	
	def __mul__(self,other):
		numer=self.num * other.num
		denumer=self.den * other.den
		return Fraction(numer,denumer)
	
	def __eq__(self,other):
		
		l= self.num*other.den
		r= other.num*self.den
		return l==r
	
	def get_num(self):
		return self.num
	
	def get_denum(self):
		return self.den
	



my_f = Fraction(3,9)


stringa = my_f.__str__()
print(stringa)

f1=Fraction(1,2)
f2=Fraction(1,5)

test=f1+f2
print(test)

test1 = f1==f2

print(test1)

print("num: ",f1.get_num())
print("denum: ",f1.get_denum())

print("subtraction")
subtract= f1-f2

print(subtract)

print("mutiplication")
multipl=f1*f2
print(multipl)
