import re

phoneNumberReg = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d')
mo = phoneNumberReg.search('My number is 415-555-d4242')
print(mo)

heroReg = re.compile(r'Batmans|Suaerman')
mo = heroReg.findall('The battle between Batman vs. Superman')
print(mo)
print(mo == []) 


def isStrongPassword(password):
	uppercaseReg = re.compile(r'[A-Z]')
	lowercaseReg = re.compile(r'[a..z]')
	digitReg = re.compile(r'\d')
	if uppercaseReg.search(password) != None and lowercaseReg.search(password) != None and digitReg.search(password) != None:
		return True
	return False

print(isStrongPassword('I know youre names5'))
	
