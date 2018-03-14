#include <stdint.h>
#include <gtest/gtest.h>


typedef struct Fibo {} Fibo;
typedef struct Factoiral {} Fact;
typedef struct Sum {} Sum;


template <class T> class Enumerator;

template<>
class Enumerator<Fibo> {
 public:
 	Enumerator(): a(0), b(1) {}
	~Enumerator() {}
	uint64_t next() {uint64_t c = a + b; a = b; b = c; return a;}
 private:
 	uint64_t a;
	uint64_t b;
};

template<>
class Enumerator<Fact> {
 public:
 	Enumerator(): fac(1), idx(1) {}
	~Enumerator() {}
	uint64_t next() {fac *= idx; idx++; return fac;}
 private:
 	uint64_t fac;
	uint64_t idx;
};

template<>
class Enumerator<Sum> {
 public:
 	Enumerator(): sum(0), idx(1) {}
	~Enumerator() {}
	uint64_t next() {sum += idx, idx++; return sum;}
 private:
 	uint64_t sum;
	uint64_t idx;
};


template<class T>
struct Func {
	typedef Enumerator<T> *(*CreateEnumerator)();
};
Enumerator<Fibo> *fiboFunc() {
	return new Enumerator<Fibo>();
}


class EnumeratorTest : public ::testing::TestWithParam<Func<Fibo>::CreateEnumerator> {
 public:
 	virtual ~EnumeratorTest() {delete enu;}
	void SetUp() {
		enu = (GetParam())();
	}

	void TearDown() {
		delete enu;
		enu = NULL;
	}
 protected:
 	Enumerator<Fibo> *enu;
};

#ifdef __UNIT_TEST__

TEST_P(EnumeratorTest, FibonaciTest) {
	EXPECT_EQ(this->enu->next(), 1);
	EXPECT_EQ(this->enu->next(), 1);
	EXPECT_EQ(this->enu->next(), 2);
	EXPECT_EQ(this->enu->next(), 3);
	EXPECT_EQ(this->enu->next(), 5);
	EXPECT_EQ(this->enu->next(), 8);
}

TEST_P(EnumeratorTest, FactorialTest) {
	EXPECT_EQ(this->enu->next(), 1);
	EXPECT_EQ(this->enu->next(), 2);
	EXPECT_EQ(this->enu->next(), 6);
	EXPECT_EQ(this->enu->next(), 24);
	EXPECT_EQ(this->enu->next(), 120);
}

TEST_P(EnumeratorTest, SumTest) {
	EXPECT_EQ(this->enu->next(), 1);
	EXPECT_EQ(this->enu->next(), 3);
	EXPECT_EQ(this->enu->next(), 6);
	EXPECT_EQ(this->enu->next(), 10);
}


INSTANTIATE_TEST_CASE_P(
	FibonaciFactorialSum,
	EnumeratorTest,
	::testing::Values(&fiboFunc));


#endif

int main(int argc, char *argv[]) {
#ifdef __UNIT_TEST__
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
#else
	printf("Hello World\n");
	return 0;
#endif
}
