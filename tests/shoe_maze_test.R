library(testthat)
source("../src/shoe_maze.R")

test_that("Is maze a matrix", {
  problem <- initialize.problem()
  expect_true(is.matrix(problem$kRedMaze))
})

test_that("Is kRedMaze not empty", {
  problem <- initialize.problem()
  expect_false(anyNA(problem$kRedMaze))
})

test_that("Are kRedMaze states well defined", {
  problem <- initialize.problem()
  expect_true(is.logical(problem$kRedMaze))
})