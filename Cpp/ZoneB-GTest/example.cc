#include <gtest/gtest.h>
#include <math.h>
//#include "fixture.h"


double square_root(double num) {
	if (num < 0.0) {
		fprintf(stderr, "Error: Negative Input");
		exit(0);
	}
	return sqrt(num);
}

TEST(SquareRootTest, DISABLED_PositiveNos) {
	EXPECT_EQ(18.0, sqrt(324.0));
	EXPECT_EQ(25.4, sqrt(645.16));
	EXPECT_EQ(50.3321, sqrt(2533.310224)) << "Two value should match";
}

TEST(SquareRootTest, DISABLED_ZeroAndNegativeNos) {
	ASSERT_EQ(0.0, sqrt(0.0));
	ASSERT_EQ(-1, sqrt(-22.0)); 
}

TEST(SquareRootTest, DISABLED_ExitOnNegative) {
	ASSERT_EXIT(square_root(-1), ::testing::ExitedWithCode(0), "Error: Negative Input");
}

class TestFixture : public ::testing::Test {
 protected:
 	TestFixture() : age(27) {}
	~TestFixture() {}

	// Communication functions
	int age;
	int getAge() {return age;}

 protected:
	// GTest initialization
	virtual void SetUp() {age++;}
	virtual void TearDown() {}
};


TEST_F(TestFixture, ageShouldBeMatched) {
	EXPECT_EQ(28, age);
}

TEST(StringComparisonTest, if_strings_equal) {
	char const *str1 = "Hello World";
	char const *str2 = "Hello World";
	std::string s1 = "The man from nowhere";
	std::string s2 = "The man from nowhere";
	EXPECT_STREQ(str1, str2);
	EXPECT_EQ(s1, s2);
}


#ifdef __GTEST_UNIT__

int main(int argc, char *argv[]) {
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}

#endif
