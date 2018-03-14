import openpyxl, sys

n = int(sys.argv[1])
wb = openpyxl.Workbook()
sheet = wb.get_sheet_by_name('Sheet')

cell = sheet.cell(row=1,column=1)
for index in range (1, n):
	cell.offset(0, index).value = index
	cell.offset(index, 0).value = index

for i in range (1, n):
	for j in range (1, n):
		cell.offset(i,j).value = "=%s*%s" % (cell.offset(0, j).value, cell.offset(i,0).value)

wb.save('multiplicationTable.xlsx')


