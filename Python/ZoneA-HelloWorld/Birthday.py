birthday = {
	'Lan': 'April 15th',
	'Leo': 'July 4th',
	'In': 'July 1st'
}


while True:
	print('Enter a name: (blank to quit')
	name = input()
	if name == '':
		break
	
	if name in birthday:
		print(birthday[name] + ' is the birthday of ' + name)
	else:
		print(name + ' is not in the database, please enter ' + name + '\'s birthday: ')
		birth = input()
		birthday[name] = birth
		print('Data base updated')
		
