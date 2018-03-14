import os

print(os.getcwd())
print(os.path.basename('./'))
print(os.path.dirname('./'))
print(os.path.getsize('.'))
print(os.listdir('.'))

fileStream = open('Hello.txt', 'a')
fileStream.write("Are you a true Christain believer?\n")
fileStream.close()
fileStream = open('Hello.txt')
print(fileStream.readlines())
fileStream.close()


import shelve
fileStream = shelve.open('myData')
cats = ['Sophie', 'Pooks', 'Simon']
fileStream['cats'] = cats
fileStream.close()

