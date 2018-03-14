#include <gtest/gtest.h>


class TestFixture : public ::testing::Test {
 public:
 	TestFixture();
	~TestFixture();

	// Communication functions
	int getAge() {return age;}

 protected:
	// GTest initialization
	virtual void SetUp();
	virtual void TearDown();
 private:
 	int age;
};
