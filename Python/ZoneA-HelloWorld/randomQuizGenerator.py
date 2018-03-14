import random
import os

capitals = {
	'Alabama': 'Montgomery', 'Alaska': 'Juneau', 'Arizona': 'Phoenix',
   'Arkansas': 'Little Rock', 'California': 'Sacramento', 'Colorado': 'Denver',
   'Connecticut': 'Hartford', 'Delaware': 'Dover', 'Florida': 'Tallahassee',
   'Georgia': 'Atlanta', 'Hawaii': 'Honolulu', 'Idaho': 'Boise', 'Illinois':
   'Springfield', 'Indiana': 'Indianapolis', 'Iowa': 'Des Moines', 'Kansas':
   'Topeka', 'Kentucky': 'Frankfort', 'Louisiana': 'Baton Rouge', 'Maine':
   'Augusta', 'Maryland': 'Annapolis', 'Massachusetts': 'Boston', 'Michigan':
   'Lansing', 'Minnesota': 'Saint Paul', 'Mississippi': 'Jackson', 'Missouri':
   'Jefferson City', 'Montana': 'Helena', 'Nebraska': 'Lincoln', 'Nevada':
   'Carson City', 'New Hampshire': 'Concord', 'New Jersey': 'Trenton', 'New Mexico': 'Santa Fe', 'New York': 'Albany', 'North Carolina': 'Raleigh',
   'North Dakota': 'Bismarck', 'Ohio': 'Columbus', 'Oklahoma': 'Oklahoma City',
   'Oregon': 'Salem', 'Pennsylvania': 'Harrisburg', 'Rhode Island': 'Providence',
   'South Carolina': 'Columbia', 'South Dakota': 'Pierre', 'Tennessee':
   'Nashville', 'Texas': 'Austin', 'Utah': 'Salt Lake City', 'Vermont':
   'Montpelier', 'Virginia': 'Richmond', 'Washington': 'Olympia', 'West Virginia': 'Charleston', 'Wisconsin': 'Madison', 'Wyoming': 'Cheyenne'
   }


#Create the folder to store the quizzes
if not os.path.exists('./Quizzes'):
	os.makedirs('./Quizzes')

for quizNum in range(35):
	answerQuizFile = open("./Quizzes/capitalQuizz%s-Answers.txt" % (quizNum + 1), 'w')
	quizFile = open('./Quizzes/capitalQuizz%s.txt' % (quizNum + 1), 'w')
	quizFile.write("Name:\n\nDate:\n\nPeriod:\n\n")
	quizFile.write((' ' * 20) + "State Captials Quiz (Form %s)" % (quizNum + 1))
	quizFile.write("\n\n")
	states = list(capitals.keys())
	random.shuffle(states)

	#Makint qustion for each
	allAnswers = list(capitals.values())
	for quesNum in range(50):
		correctAnswer = capitals[states[quesNum]]
		allAnswers.remove(correctAnswer)
		wrongAnswers = random.sample(allAnswers, 3)
		answersOption = wrongAnswers + [correctAnswer]
		random.shuffle(answersOption)
		
		# Write the questions
		quizFile.write("%s. What is the capital of %s?\n" % (quesNum + 1, states[quesNum]))
		for i in range(4):
			quizFile.write("\t%s. %s" % ('ABCD'[i], answersOption[i]))
		quizFile.write("\n")

		# Write the answer
		answerQuizFile.write("%s. %s\n" % (quesNum + 1, 'ABCD'[answersOption.index(correctAnswer)]))

		#Rrestore the allAnswers
		allAnswers.append(correctAnswer)

