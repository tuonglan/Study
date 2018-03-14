import openpyxl

wb = openpyxl.load_workbook('produceSales.xlsx')
sheet = wb.get_sheet_by_name('Sheet')

PRICE_UPDATES = {
	'Celery': 1.19,
	'Garlic': 3.07,
	'Lemon': 1.27
}

for rowNum in range(2, sheet.get_highest_row()):
	productName = sheet.cell(row = rowNum, column =1)
	if productName.value in PRICE_UPDATES:
		productName.offset(0,1).value = PRICE_UPDATES[productName.value]

wb.save('produceSales-Updated.xlsx')
	
