RUN_TEST_DIR=data
TEST_COMMAND=Rscript $(RUN_TEST_DIR)/run_tests.R

.PHONY:all test run clean
all: test run
	@echo Tested and Run all

run:
	@echo Run

test:
	@echo Test
	$(TEST_COMMAND)

clean:
	@echo Clean all

