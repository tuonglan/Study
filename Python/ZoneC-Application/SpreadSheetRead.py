import openpyxl, pprint

wb = openpyxl.load_workbook('censuspopdata.xlsx')
sheet = wb.get_sheet_by_name('Population by Census Tract')
countyData = {}
for row in range(2, sheet.get_highest_row()+1) :
	state = sheet['B' + str(row)].value
	county = sheet['C' + str(row)].value
	pop = sheet['D' + str(row)].value
	countyData.setdefault(state, {})
	countyData[state].setdefault(county, {'tracts':0, 'pop': 0})
	countyData[state][county]['tracts'] += 1
	countyData[state][county]['pop'] += int(pop)


print('Writing data...')
resultFile = open('census2010.py', 'w')
resultFile.write('allData = ' + pprint.pformat(countyData))
resultFile.close()
print('Done')
