tableData = [
	['apples', 'oranges', 'cherries', 'banana'],
	['Alice', 'Bob', 'Carol', 'David'],
	['dogs', 'cats', 'moose', 'goose']
]

maxLength = []
for line in tableData:
	for col in range(len(line)):
		if col >= len(maxLength):
			maxLength.append(0)
		if len(line[col]) > maxLength[col]:
			maxLength[col] = len(line[col])

# Adjust the length of string to print out
for line in tableData:
	outStr = ''
	for col in range(len(line)):
		outStr += line[col].rjust(maxLength[col]) + ' '
	print(outStr)


