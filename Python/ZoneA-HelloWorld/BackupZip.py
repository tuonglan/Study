#! python3

import zipfile, os


def backupToZip(folder):
	
	# Backup the entire content of Quizzes into a Zip file
	folder = os.path.abspath(folder)
	number = 1
	while True:
		zipFileName = os.path.basename(folder) + '_' + str(number) + '.zip'
		if not os.path.exists(zipFileName):
			break
		number = number + 1
