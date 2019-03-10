library(testthat)
source("../../problems/shoe-maze-problem.R")

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

test_that("Are initial and final states well defined", {
  problem <- initialize.problem()

  for (state in list(problem$state.initial, problem$state.final)) {
    expect_true(is.list(state))

    expect_true(state$row <= nrow(problem$kMaze) & state$row > 0)
    expect_true(state$column <= ncol(problem$kMaze) &  state$column > 0)
  }
})

test_that("Are possible actions well defined", {
  problem <- initialize.problem()

  expect_true(is.data.frame(problem$actions.possible))

  expect_true(problem$actions.possible[1, ] == "up")
  expect_true(problem$actions.possible[2, ] == "down")
  expect_true(problem$actions.possible[3, ] == "left")
  expect_true(problem$actions.possible[4, ] == "right")
})

test_that("Does 'is.applicable' take into account color", {
 problem <- initialize.problem()

 kMazeCell <- problem$kMaze[1, 1]
 kMazeCell$isRed <- TRUE
 kMazeCell$walls <- lapply(kMazeCell$walls, function(x) FALSE)

 problem$kMaze <- matrix(list(kMazeCell), nrow = 3, ncol = 3)
 kState <- list(row=2, column=2)

 for (direction in problem$actions.possible[, ])
   expect_false(is.applicable(kState, direction, problem))

 problem$kMaze[kState$row, kState$column][[1]]$isRed <- FALSE
 for (direction in problem$actions.possible[, ])
   expect_true(is.applicable(kState, direction, problem))
})