class FirstClass:
	def setData(self, value):
		self.data = value
	def display(self):
		print(self.data)


tmp = FirstClass()
one = FirstClass()
tmp.setData(2015)
tmp.display()
tmp.data = "New Value"
tmp.display()
tmp.newValue = "Really?"
print(tmp.newValue)


class SecondClass(FirstClass):
	def display(self):
		print("Current value = %s" % self.data)

two = SecondClass()
two.setData("Hey jude")
two.display()


class ThirdClass(SecondClass):
	def __init__(self, value):
		self.data = value
	def __add__(self, other):
		return ThirdClass(self.data + other)
	def __str__(self):
		return "[ThirdClas: %s]" % self.data
	def mul(self, other):
		self.data *= other

three = ThirdClass('abc')
three.display()
four = three + 'xyz'
four.display()
