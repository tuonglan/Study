class Lara:
	motto = "There's must be a way to handle it"


class Robot:
	__counter = 0
	Three_Laws = (
		"A robot may not injure a human being or, through in action, allow a human being to come to harm.",
		"A robot must obey the orders given to it by human beings, except  where such orders would conflict the First Law.",
		"A robot must protect its own existence as long as such protection does not conflict the First and the Second law."
	)

	def __init__(self, name, build_year):
		self.name = name
		self.build_year = build_year
		type(self).__counter += 1

	def RobotInstances():
		return Robot.__counter


if __name__ == "__main__":
	x = Lara()
	print(x.motto)
	print(Lara.motto)
	for number, text in enumerate(Robot.Three_Laws):
			print(str(number) + ": " + text)
