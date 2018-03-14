a = [1, 2, 3, 4, 5, 7, 13, 32, 71, 55, 89]
n = 10 # int(input("Please enter a number: "))
print(list(filter((lambda x: x < n),a)))

b = [1,2,3,4,5,6,7,8,9,10,11,12,13]

import random
x = []
y = []
for i in range(31):
	x.append(random.randrange(100))
	y.append(random.randrange(100))

print(x)
print(y)
print("The common value is: ")
z = []
for value in x:
	if value in y:
		z.append(value)
print(z)
print([x for x in set(a + b) if (x in a) and (x in b)])


squareList = [x*x for x in range(10)]
print([x for x in squareList if x % 2 == 0])
