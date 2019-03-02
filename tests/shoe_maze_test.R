source("../src/shoe_maze.R")

test_that("Is maze a matrix", {
  problem <- initialize.problem()
  expect_true(is.matrix(problem$kRedMaze))
})