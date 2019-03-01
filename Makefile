TEST_COMMAND=Rscript run_tests.R

all: test run
	@echo Tested and Run all

.PHONY: test run clean
run:
	@echo Run

test:
	@echo Test
	$(TEST_COMMAND)

clean:
	@echo Clean all

