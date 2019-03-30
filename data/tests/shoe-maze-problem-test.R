library(testthat)
source("../../problems/shoe-maze-problem.R")

GetProblem <- function() {
  return (initialize.problem("../../data/maze.csv", 7, 7))
}

test_that("Is kMaze a matrix", {
  problem <- GetProblem()
  expect_true(is.matrix(problem$kMaze))
})

test_that("Is kMaze not empty", {
  problem <- GetProblem()
  expect_false(anyNA(problem$kMaze))
})

test_that("Are kMaze cells well defined", {
  problem <- GetProblem()

  for (r in 1:nrow(problem$kMaze))
    for (c in 1:ncol(problem$kMaze)) {
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
  problem <- GetProblem()

  for (state in list(problem$state.initial, problem$state.final)) {
    expect_true(is.list(state))

    expect_true(state$row <= nrow(problem$kMaze) & state$row > 0)
    expect_true(state$column <= ncol(problem$kMaze) &  state$column > 0)
  }
})

test_that("Are possible actions well defined", {
  problem <- GetProblem()

  expect_true(is.data.frame(problem$actions.possible))

  expect_true(problem$actions.possible[1, ] == "up")
  expect_true(problem$actions.possible[2, ] == "down")
  expect_true(problem$actions.possible[3, ] == "left")
  expect_true(problem$actions.possible[4, ] == "right")
})

test_that("Does 'is.applicable' check the conditions properly", {
  problem <- GetProblem()

  maze.cell <- problem$kMaze[1, 1][[1]]
  maze.cell$isRed <- TRUE

  # No walls but wrong colors
  maze.cell$walls <- lapply(maze.cell$walls, function(x) {return (FALSE)})
  problem$kMaze <- matrix(list(maze.cell), nrow = 3, ncol = 3)
  kState <- list(row=2, column=2)
  for (direction in problem$actions.possible[, ])
    expect_false(is.applicable(kState, direction, problem))

  # No walls and correct colors
  problem$kMaze[kState$row, kState$column][[1]]$isRed <- FALSE
  for (direction in problem$actions.possible[, ])
    expect_true(is.applicable(kState, direction, problem))

  # No walls, correct colors current cell is in the edge of the maze
  corner.state <- list(row=1, column=1)
  problem$kMaze[corner.state$row, corner.state$column][[1]]$isRed = FALSE
  expect_false(is.applicable(corner.state, "up", problem))
  expect_true(is.applicable(corner.state, "down", problem))
  expect_false(is.applicable(corner.state, "left", problem))
  expect_true(is.applicable(corner.state, "right", problem))

  corner.state <- list(row=3, column=3)
  problem$kMaze[corner.state$row, corner.state$column][[1]]$isRed = FALSE
  expect_true(is.applicable(corner.state, "up", problem))
  expect_false(is.applicable(corner.state, "down", problem))
  expect_true(is.applicable(corner.state, "left", problem))
  expect_false(is.applicable(corner.state, "right", problem))

  # Walls and wrong colors
  maze.cell$isRed = TRUE
  maze.cell$walls <- lapply(maze.cell$walls, function(x) {return (TRUE)})
  problem$kMaze <- matrix(list(maze.cell), nrow = 3, ncol = 3)
  corner.state = list(row = 2, column = 2)
  for (direction in problem$actions.possible[, ])
    expect_false(is.applicable(kState, direction, problem))

  # Walls and correct colors
  problem$kMaze[corner.state$row, corner.state$column][[1]]$isRed = FALSE
  for (direction in problem$actions.possible[, ])
    expect_false(is.applicable(kState, direction, problem))

})

test_that("Does 'effect' change state properly", {
  initial.state = list(row = 2, column = 2)

  expected.state = list(row = 1, column = 2)
  expect_true(identical(effect(initial.state, "up"), expected.state))

  expected.state = list(row = 3, column = 2)
  expect_true(identical(effect(initial.state, "down"), expected.state))

  expected.state = list(row = 2, column = 1)
  expect_true(identical(effect(initial.state, "left"), expected.state))

  expected.state = list(row = 2, column = 3)
  expect_true(identical(effect(initial.state, "right"), expected.state))
})

test_that("Is 'is.final.state' well implemented", {
  current.state = list(row = 2, column = 2)
  final.state = list(row = 2, column =2)

  expect_true(identical(current.state, final.state))
  current.state$row = current.state$row - 1
  expect_false(identical(current.state, final.state))
})
