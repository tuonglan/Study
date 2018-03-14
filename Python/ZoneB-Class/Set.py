class Set(list):
	def __init__(self, value=[]):
		super().__init__(value)
	def intersect(self, other):
		re = Set()
		for x in self:
			if x in other:
				re.append(x)
		return re
	def union(self, other):
		re = Set(self[:])
		for x in other:
			if not x in self:
				re.append(x)
		return re
	def concate(self, other):
		for x in other:
			if not x in self:
				self.append(x)

	def __and__(self, other): return self.intersect(other)
	def __or__(self, other): return self.union(other)
	def __repr__(self): return 'Set:' + list.__repr__(self)


if __name__ == '__main__':
	x = Set([1,3,5,7])
	print(x)
	print(x.union(Set([1,4,7])))
	print(x | Set([1,4,6]))
