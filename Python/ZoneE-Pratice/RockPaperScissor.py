import random

rock = "rock"
paper = 'paper'
scissors = 'scissors'

while True:
	plInput = input("Please enter %s, %s or %s: " % (rock, paper, scissors))
	if (plInput == ""):
		break;
	if (plInput != rock) and (plInput != paper) and (plInput != scissors):
		print("Please make sure the input is among %s, %s or %s" % (rock, paper, scissors))
		continue
	if ((random.randrange(2) + 1) % 2 == 0):
		print("Congratulation, you're a good player")
	else:
		print("Bad bad bad...")
