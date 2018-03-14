import math

def func(*para):
	print(para)


def is_prime(number):
	if number > 1:
		if number == 2:
			return True
		if number % 2 == 0:
			return False
		for current in range(3, int(math.sqrt(number) + 1), 2):
			if number % current == 0:
				return False
		return True
	return False


def get_primes(input_list):
	return (x for x in input_list if is_prime(x))


def generate_prime(number):
	while True:
		if is_prime(number)
			yield number
		number +=1


if __name__ == '__main__':
	func(*list(get_primes(range(3, 100))))
