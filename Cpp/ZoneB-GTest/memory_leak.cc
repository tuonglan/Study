#include <stdio.h>
#include <gtest/gtest.h>


namespace {
using ::testing::EmptyTestEventListener;
using ::testing::TestInfo;

class Water {
 public:
 	Water() {allocated++;}
	~Water() {allocated--;}

	static unsigned int get_allocated() {return allocated;}
	static void init_allocated() {allocated = 0;}
 private:
 	static unsigned int allocated;
};
unsigned int Water::allocated = 0;

class LeakChecker : public EmptyTestEventListener {
 private:
 	virtual void OnTestStart(const TestInfo&) {
		init_allocated = Water::get_allocated();
	}

	virtual void OnTestEnd(TestInfo const &) {
		int difference = Water::get_allocated() - init_allocated;
		EXPECT_EQ(difference, 0) << "Leaked " << difference << " unit(s) of water";
	}
	
	unsigned int init_allocated;
};

TEST(MemoryLeakTest, NoLeak) {
	Water *water = new Water();
	delete water;
}

TEST(MemoryLeakTest, LeaksWater) {
	Water *water = new Water();
	EXPECT_TRUE(water != NULL);
}

} // End of anonymous namespace


int main(int argc, char *argv[]) {
	::testing::InitGoogleTest(&argc, argv);
	bool memory_test = false;
	if (argc > 1 && strcmp(argv[1], "--memory_test") == 0)
		memory_test = true;
	else
		printf("Run with option --memory_test to run the memory test\n");

	if (memory_test) {
		::testing::TestEventListeners &listeners = ::testing::UnitTest::GetInstance()->listeners();
		listeners.Append(new LeakChecker());
	}

	return RUN_ALL_TESTS();
}



