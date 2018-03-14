def echo(message):
	print(message)

echo('Direct Call')
x = echo
x('Indirect Call')

schedule = [(echo, 'Hello'), (echo, ' World')]
for (func, arg) in schedule:
	func(arg)

print((lambda x, y, z: x + y + z)(3,4,5))

import sys
showAll = lambda x : list(map(sys.stdout.write, x))
t = showAll(['smap\n', 'toast\n', 'eggs\n'])

def plusWith(x):
	return (lambda y: x + y)

plusWith99 = plusWith(99)
print(plusWith99(2))

counters = [1, 2, 3, 4]
print(list(map((lambda x: x + 10), counters)))
print(list(map((lambda x, y: x ** y), [1, 2, 3], [2, 3, 4])))

print([ord(x) for x in 'spam'])
print([x for x in range(100) if x % 3 == 0])
print([(x, y) for x in range(5)
	for y in "abcdefgh"
	])
print('')
print(list(map((lambda x, y: (x, y)), range(3), "abcdefgh")))

M = [
	[1, 2, 3],
	[4, 5, 6],
	[7, 8, 9]
	]

N = [[2, 2, 2,],
	[3, 3, 3],
	[4, 4, 4]]

print([row[1] for row in M])

print("----------------------------------------------------")
L = [1,2,3,4,5,6,7]
print(L[2:])


def scamble(seq):
	for i in range(len(seq)):
		seq = seq[1:] + seq[:1]
		yield seq
print(list(scamble("moment")))
