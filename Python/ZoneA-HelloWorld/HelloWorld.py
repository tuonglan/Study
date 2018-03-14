print('Hello World')
myName = "Lan Do"
print('My name is: ' + myName)
if myName == 'Marie':
	print('Hello Marie')
else:
	print('Hello stranger!')

spam = 3
while spam < 5:
	print('Hello World')
	spam = spam + 1

s = 0
for num in range(211):
	s = s + num
print(s)

import random
for i in range(5):
	print(random.randint(1,10))

def hello():
	print("Howly Crap")
	print("Who are you?")

hello()

def devideBy(devidor):
	try:
		return 42 / devidor
	except ZeroDivisionError:
		print('Error: Invalid Argument')
		return 'Undefined'

print(devideBy(16))
print(devideBy(0))

lst = ['One', 'Two', 'Three']
print(lst)

def getMyName():
	temp = ['Lan', 'Do']
	return temp

name = getMyName()
print(name)


myCat = {
	'size': 'fat',
	'color': 'gray',
	'disposition': 'loud'
}
print(myCat)
print(myCat.values())

