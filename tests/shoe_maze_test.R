source("../src/shoe_maze.R")

test_that("Empty test", {

  expect_equal(1, 1)
})

test_that("Is maze a matrix", {
  problem <- initialize.problem()
  expect_true(is.matrix(problem$maze))
})