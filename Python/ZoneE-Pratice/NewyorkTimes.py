import requests
from bs4 import BeautifulSoup

class Webgo:
	def __init__(self):
		self.address = ''

	def go(self, addr):
		print("Connecting to %s..." % addr)
		self.address = addr
		self.webContent = requests.get(addr)

	def printHeading(self):
		if self.address == '':
			self.go('http://www.google.com')
		htmlSoup = BeautifulSoup(self.webContent.text)

		# Parsing the htmltext
		for storyHeading in htmlSoup.find_all(class_='story-heading'):
			if storyHeading.a:
				print(storyHeading.a.text.replace("\n",' ').strip())
			else:
				print(storyHeading.contents[0].replace("\n", ' ').strip())


if __name__ == '__main__':
	browser = Webgo()
	browser.go('http://www.nytimes.com')
	browser.printHeading()
