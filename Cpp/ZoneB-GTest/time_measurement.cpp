#include <time.h>
#include <gtest/gtest.h>


class QuickTest : public ::testing::Test {
 protected:
 	void SetUp() {
		start = time(NULL);
	}

	void TearDown() {
		end = time(NULL);
		EXPECT_TRUE(end - start < 1.5) << "The run time should be smaller than 1.5 seconds";
	}
 private:
 	time_t start;
	time_t end;
};


class TortureTest : public QuickTest {
 protected:
 	void run_test() {sleep(2);}
};


TEST_F(TortureTest, TortureSpeedTest) {
	fprintf(stderr, "This is the speed test of the SpeedTest class\n");
	sleep(1.3);
	EXPECT_EQ(1,1);
}

#ifdef __UNIT_TEST__
int main(int argc, char *argv[]) {
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}
#endif
