class Wrapper:
	def __init__(self, object):
		self.wrapped = object
	def __getattr__(self, attrname):
		print('Invoking: ' + attrname)
		return getattr(self.wrapped, attrname)
	def __repr___(self):
		return (self.wrapped)
	def __str__(self):
		return str(self.wrapped)

	
if __name__ == '__main__':
	x = Wrapper([1, 2, 3])
	x.append(4)
	print(x)
