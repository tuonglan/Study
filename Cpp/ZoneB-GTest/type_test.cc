#include <stdint.h>
#include <gtest/gtest.h>

typedef struct _Fibo {} Fibo;
typedef struct _Factorial {} Factorial;
typedef struct _Sum {} Sum;

template <class T> class Enumerator;

template <>
class Enumerator<Fibo> {
 public:
 	Enumerator() :a(0), b(1) {}
	~Enumerator() {}
 	uint64_t next() {uint64_t c = a+b; a = b; b = c; return a;}
 private:
 	uint64_t a;
	uint64_t b;
};


template <>
class Enumerator<Factorial> {
 public:
 	Enumerator(): fac(1), idx(1) {}
	~Enumerator() {}
	uint64_t next() {fac *= idx; idx++; return fac;}
 private:
 	uint64_t fac;
	uint64_t idx;
};

template <>
class Enumerator<Sum> {
 public:
 	Enumerator(): sum(0), idx(1) {}
	~Enumerator() {}
	uint64_t next() {sum += idx, idx++; return sum;}
 private:
 	uint64_t sum;
	uint64_t idx;
};


template <class T>
class EnumeratorTest : public ::testing::Test {
 public:
 	EnumeratorTest(): num_creator(new Enumerator<T>()) {}
	~EnumeratorTest() {delete this->num_creator;}
 protected:
 	Enumerator<T> *num_creator;
};

#ifdef __UNIT_TEST__

typedef ::testing::Types<Fibo, Factorial, Sum> TypeLists;
TYPED_TEST_CASE(EnumeratorTest, TypeLists);

TYPED_TEST(EnumeratorTest, FibonaciTest) {
	EXPECT_EQ(this->num_creator->next(), 1);
	EXPECT_EQ(this->num_creator->next(), 1);
	EXPECT_EQ(this->num_creator->next(), 2);
	EXPECT_EQ(this->num_creator->next(), 3);
	EXPECT_EQ(this->num_creator->next(), 5);
	EXPECT_EQ(this->num_creator->next(), 8);
}

TYPED_TEST(EnumeratorTest, FactorialTest) {
	EXPECT_EQ(this->num_creator->next(), 1);
	EXPECT_EQ(this->num_creator->next(), 2);
	EXPECT_EQ(this->num_creator->next(), 6);
	EXPECT_EQ(this->num_creator->next(), 24);
	EXPECT_EQ(this->num_creator->next(), 120);
}

TYPED_TEST(EnumeratorTest, SumTest) {
	EXPECT_EQ(this->num_creator->next(), 1);
	EXPECT_EQ(this->num_creator->next(), 3);
	EXPECT_EQ(this->num_creator->next(), 6);
	EXPECT_EQ(this->num_creator->next(), 10);
}

#endif
	
int main(int argc, char *argv[]) {

#ifdef __UNIT_TEST__
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
#else
	printf("Hello World\n");
	Enumerator<Factorial> num_creator;
	for (int i=0;i<10;++i)
		printf("The fibonaci: %dth is: %lu\n",i, num_creator.next());
#endif
}
