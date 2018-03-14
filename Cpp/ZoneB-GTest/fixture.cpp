#include "fixture.h"


TestFixture::TestFixture() :age(27) {

}


TestFixture::~TestFixture() {
}


void TestFixture::SetUp() {
	age++;
}


void TestFixture::TearDown() {
	
}
