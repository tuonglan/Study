#include <stdio.h>
#include <gtest/gtest.h>


namespace {

// Provide alternative output mode which prodeces minimal amount
class TersePrinter : public ::testing::EmptyTestEventListener {
 private:
 	// Called before any test activities have ended
	virtual void OnTestProgramStart(const ::testing::UnitTest&) {}

	// Called after all test activities have ended
	virtual void OnTestProgramEnd(const ::testing::UnitTest &unit_test) {
		fprintf(stdout, "TEST %s\n", unit_test.Passed() ? "PASSED" : "FAILED");
		fflush(stdout);
	}

	// Called before a test starts
	virtual void OnTestStart(const ::testing::TestInfo &test_info) {
		fprintf(stdout,
					"*** Test %s, %s starting.\n",
					test_info.test_case_name(),
					test_info.name());
		fflush(stdout);
	}

	// Called after a failed assertion or a SUCCED() invocation
	virtual void OnTestPartResult(const ::testing::TestPartResult &test_part_result) {
		fprintf(stdout,
					"%s in %s: %d\n%s\n",
					test_part_result.failed() ? "*** Failure" : "Success",
					test_part_result.file_name(),
					test_part_result.line_number(),
					test_part_result.summary());
		fflush(stdout);
	}

	// Called after a test ends
	virtual void OnTestEnd(const ::testing::TestInfo& test_info) {
		fprintf(stdout,
					"** Test %s.%s ending.\n",
					test_info.test_case_name(),
					test_info.name());
		fflush(stdout);
	}
};

TEST(CustomOutputTest, PrintMessage) {
	printf("Printing something from the test body...\n");
}

TEST(CustomOutputTest, Succeeds) {
	SUCCEED() << "SUCCEED() has been invoked from here";
}

TEST(CustonOutputTest, Fails) {
	EXPECT_EQ(1,2) << "This test fails in order to demonstrate the alternative failure message";
}

} // End of the namespace


int main(int argc, char *argv[]) {
	::testing::InitGoogleTest(&argc, argv);

	// Check if the output is changed or not
	bool terse_output = false;
	if (argc > 1 && strcmp(argv[1], "--terse_output") == 0)
		terse_output = true;
	else
		printf("Run this program with --terse_output to change the way it prints its output\n");

	::testing::UnitTest &unit_test = *::testing::UnitTest::GetInstance();
	if (terse_output) {
		::testing::TestEventListeners &listeners = unit_test.listeners();
		delete listeners.Release(listeners.default_result_printer());
		listeners.Append(new TersePrinter);
	}

	int ret_val = RUN_ALL_TESTS();

	return ret_val;
}
