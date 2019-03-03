RUN_TEST_DIR=data
TEST_COMMAND=Rscript run\ tests.R

MAIN_DIR=demos
RUN_MAIN_COMMAND=Rscript $(MAIN_DIR)/main\ file\ template.R

.PHONY:all test run clean
all: test run
	@echo Tested and Run all

run:
	@echo Run
	$(RUN_MAIN_COMMAND)

test:
	@echo Test
	cd $(RUN_TEST_DIR) && \
	$(TEST_COMMAND)

clean:
	@echo Clean all

