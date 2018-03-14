class Set:
	def __init__(self, value = []):
		self.data = value[:]
		#self.concat(value)
	def intersect(self, other):
		re = []
		for x in self.data:
			if x in other:
				re.append(x)
		return Set(re)
	def union(self, other):
		re = self.data[:]	#Copy all data
		for x in other:
			if not x in re:
				re.append(x)
		return Set(re)
	def concat(self, other):
		for x in other:
			if not x in self.data:
				self.data.append(x)

	def __len__(self): return len(self.data)
	def __getitem(self, index): return self.data[index]
	def __and__(self, other): return self.intersect(other)
	def __or__(self, other): return self.union(other)

	def __repr__(self): return 'Set:' + repr(self.data)
	def __iter__(self): return iter(self.data)


if __name__ == '__main__':
	x = Set([1,3,5,7])
	print(x.union(Set([1,4,7])))
	print(x | Set([1,4,6]))
