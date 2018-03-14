class Number:
	def __init__(self, start):
		self.data = start
	def __sub__(self, other):
		return Number(self.data - other)
	def __repr__(self):
		return self.data
	def __str__(self):
		return str(self.data)

class Indexer:
	data = [5, 6, 7, 8 , 10]
	def __getitem__(self, index):
		print('getitem:', index)
		return self.data[index]

class Squares:
	def __init__(self, start, stop):
		self.value = start-1
		self.stop = stop
	def __iter__(self):
		return self
	def __next__(self):
		if self.value == self.stop:
			raise StopIteration
		self.value += 1
		return self.value ** 2

class SkipObject:
	def __init__(self, wrapped):
		self.wrapped = wrapped
	def __iter__(self):
		return SkipIterator(self.wrapped)

class SkipIterator:
	def __init__(self, wrapped):
		self.wrapped = wrapped
		self.offset = 0
	def __next__(self):
		if (self.offset >= len(self.wrapped)):
			raise StopIteration
		else:
			item = self.wrapped[self.offset]
			self.offset += 2
			return item

class PrivacyExc(Exception): pass
class Privacy:
	def __setattr__(self, attrname, value):
		print("Checking attrname:%s in privacy list: %s" % (attrname, self.__dict__))
		if attrname in self.privates:
			raise PrivacyExc(attrname, self)
		else:
			self.__dict__[attrname] = value

class Test1(Privacy):
	privates = ['age']
class Test2(Privacy):
	privates = ['name', 'pay']
	def __init__(self):
		self.__dict__['name'] = 'Tom'

class Callee:
	def __call__(self, *pargs, **kargs):
		print('Called: ', pargs, kargs)

class Life:
	#def __new__(self, name):
		#print("New is runing")
	def __init__(self, name='Unknown'):
		print('Hello ' + name)
		self.name = name
	def live(self):
		print(self.name)
	def __del__(self):
		print('Goodbye ' + self.name)


if __name__ == '__main__':
	a = Number(5)
	c = a - 2
	print(c)
	x = Indexer()
	print(x[1:3])
	print([c*c for c in x])
	Y = Squares(1,7)
	for i in Y:
		print(i, end=' ')
	for a in Y:
		print(a, end=' ')
	print(' ')
	skipper = SkipObject('abcdef')
	for x in skipper:
		for y in skipper:
			print(x + y, end=' ')
	print('')
	x = Test1()
	y = Test2()
	x.name = 'Bob'
	print(x.name)
	y.age = 30
	print(y.age)
	c = Callee()
	c(3, 7, 2, x=7, y=8)
	brian = Life('Brian')
	brian = 'Die die die'

