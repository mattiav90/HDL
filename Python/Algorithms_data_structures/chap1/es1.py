

word_list = ['cat','dog','rabbit']
letter_list =[]

for a_word in word_list:
    for a_letter in a_word:
        letter_list.append(a_letter)

print(letter_list)



# modify the code so than the list does not have duplicates
# I can do it with a set, a set does not have duplicates and the elements are not ordered. 

my_set=set()

for a_word in word_list:
    for a_letter in a_word:
        my_set.add(a_letter)


set2list=list(my_set)

print(set2list)



# using list comprehension

test=[]
test_i=[]




test = [ l for word in word_list for l in word if l not in 'cat']

print(test)
