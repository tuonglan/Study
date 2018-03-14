#include "stdio.h"


class Animal
{
public:
	Animal(): age(0), weight(0) {printf("C++: Animal constructor\n");}
	Animal(int a, int w): age(a), weight(w) {printf("C++: Animal constructor\n");}
	~Animal() {}

	int getAge() const {return age;}
	int getWeight() const {return weight;}

private:
	int age;
	int weight;
};


class Mammal : public Animal
{
public:
	Mammal(): mana(0) {printf("C++: Mammal constructor\n");}
	Mammal(int a, int w, int m): Animal(a, w), mana(m) {printf("C++: Mammal constructor\n");}
	~Mammal() {}

	void sound() const {printf("I'm a mammal, I can speak\n");}
	int getMana() const {return mana;}

protected:
	int mana;
};
