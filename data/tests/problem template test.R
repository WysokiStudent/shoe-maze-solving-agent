library(testthat)
source("../../problems/problem template.R")

test_that("Is kMaze a matrix", {
  problem <- initialize.problem()
  expect_true(is.matrix(problem$kMaze))
})

test_that("Is kMaze not empty", {
  problem <- initialize.problem()
  expect_false(anyNA(problem$kMaze))
})

test_that("Are kMaze cells well defined", {
  problem <- initialize.problem()

  for (r in nrow(problem$kMaze))
    for (c in ncol(problem$kMaze)) {
      expect_true(is.logical(problem$kMaze[r, c][[1]]$isRed))
      expect_true(is.list(problem$kMaze[r, c][[1]]$walls))
      for (wall in problem$kMaze[r, c][[1]]$walls)
        expect_true(is.logical(wall))
    }
})

test_that("Is initial state well defined", {
  problem <- initialize.problem()

  expect_true(is.list(problem$state.initial))

  expect_true(
    problem$state.initial$row <= nrow(problem$kMaze) & problem$state.initial$row > 0
  )
  expect_true(
    problem$state.initial$column <= ncol(problem$kMaze) &  problem$state.initial$column > 0
  )
})