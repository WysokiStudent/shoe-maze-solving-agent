# =======================================================================
# Names: Aleksander Bobiński, Karolina Palka, Maciej Stokfisz
# Group Number: Group I
# Assignment: shoe-maze
# Date: 10.03.2019
# =======================================================================
# 1. Be sure to include, with this template, any necessary files
#    for execution, including datasets (problem.R, methodXXX.R, ...)
#    (submission of the entire template folder is recommended)
# 2. If you use a function of a certain package, do not forget to include the
#    corresponding call to the "library ()" function
# 3. Do not forget to comment on the code, especially those non-trivial commands
#    (remember that part of the rating depends on the cleaning of the code)
# 4. It is strongly recommended to test any implemented function in order to
#    check for its proper operation
# =======================================================================
# (This is a general code, you must adapt it)
# =======================================================================

# This function must return a list with the information needed to
# solve the problem.
# (Depending on the problem, it should receive or not parameters)
initialize.problem = function(csv.directory, rows, columns){
  problem = list()
  problem$actions.possible <- data.frame(direction = c("up", "down", "left", "right"), stringsAsFactors = F)
  problem$name = "shoe-maze-problem"
  # problem$<aditional info> = <Insert code here>
  csv = read.csv(csv.directory, header = FALSE)
  problem$kMaze <- matrix(
    mapply(
      function(isRed, north, south, west, east)
        list(
          list(
            isRed=isRed,
            walls=list(north=north, south=south, west=west, east=east)
          )
        ),
      csv[, 1], csv[, 2], csv[, 3], csv[, 4], csv[, 5]
    ),
    nrow=rows, ncol=columns
  )
  problem$state.initial <- list(row = rows, column = 1)
  problem$state.final <- list(row = 1, column = columns)
  return(problem)
}

# =======================================================================
# Must return TRUE or FALSE according with if the action can be done or not
# over the specific state
is.applicable <- function (state, action, problem){
  result <- switch (action,
    up = {
      if (state$row == 1) return (FALSE)
      return ((problem$kMaze[state$row, state$column][[1]]$isRed !=
                problem$kMaze[state$row - 1, state$column][[1]]$isRed) &&
                !(problem$kMaze[state$row, state$column][[1]]$walls$north)
              )
    },
    down = {
      if (state$row + 1 > nrow(problem$kMaze)) return (FALSE)
      return ((problem$kMaze[state$row, state$column][[1]]$isRed !=
                problem$kMaze[state$row + 1, state$column][[1]]$isRed) &&
                !(problem$kMaze[state$row, state$column][[1]]$walls$south)
              )
    },
    left = {
      if (state$column == 1) return (FALSE)
      return ((problem$kMaze[state$row, state$column][[1]]$isRed !=
                problem$kMaze[state$row, state$column - 1][[1]]$isRed) &&
                !(problem$kMaze[state$row, state$column][[1]]$walls$west)
              )
    },
    right = {
      if (state$column + 1 > ncol(problem$kMaze)) return (FALSE)
      return ((problem$kMaze[state$row, state$column][[1]]$isRed !=
                problem$kMaze[state$row, state$column + 1][[1]]$isRed) &&
                !(problem$kMaze[state$row, state$column][[1]]$walls$east)
              )
    }
  )

  return(result)
}

# =======================================================================
# Must return the state resulting on applying the action over the state
effect <- function (state, action){
  result <- switch (action,
      up = {
        state$row = state$row - 1
        return (state)
      },
      down = {
        state$row = state$row + 1
        return (state)
      },
      left = {
        state$column = state$column - 1
        return (state)
      },
      right = {
        state$column = state$column + 1
        return (state)
      }
    )

  return (result)
}


# =======================================================================
# Must return TRUE or FALSE according with the state is final or not
# * In case the final state is stablished by a condition, second argument
#   could be omited
is.final.state = function (state, finalstate=NULL){
  return(identical(state, finalstate))
}

# =======================================================================
# Must print the state in console (in a legible way)
to.string = function (state){
  # <insert code here to print the state>
}

# =======================================================================
# Return the cost of applying an action over a state
get.cost = function (action,state){
  # Return the cost of applying an action over a state
  return(1)
}

# =======================================================================
# (Used for Informed Algorithms)
# Heuristic function used in Informed algorithms
get.evaluation = function(state,problem){
	return(1)
}