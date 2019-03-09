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

      # This could be done in a loop but we wish to be explicit about the names
      expect_true(is.logical(problem$kMaze[r, c][[1]]$walls$north))
      expect_true(is.logical(problem$kMaze[r, c][[1]]$walls$south))
      expect_true(is.logical(problem$kMaze[r, c][[1]]$walls$east))
      expect_true(is.logical(problem$kMaze[r, c][[1]]$walls$west))
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

test_that("Is final state well defined", {
  problem <- initialize.problem()

  expect_true(is.list(problem$state.final))

  expect_true(
    problem$state.final$row <= nrow(problem$kMaze) & problem$state.final$row > 0
  )
  expect_true(
    problem$state.final$column <= ncol(problem$kMaze) &  problem$state.final$column > 0
  )
})

test_that("Are possible actions well defined", {
  problem <- initialize.problem()

  expect_true(is.data.frame(problem$actions.possible))

  expect_true(problem$actions.possible[1, ] == "up")
  expect_true(problem$actions.possible[2, ] == "down")
  expect_true(problem$actions.possible[3, ] == "left")
  expect_true(problem$actions.possible[4, ] == "right")
})