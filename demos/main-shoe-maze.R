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
# Configuring the Environment
rm(list=ls())
cat("\014")
graphics.off()
if (rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
}
getwd()
dir()

# LIBRARIES (add any needed library here)
library(rstudioapi)
library(ggplot2)
library(gridExtra)
library(testthat)

# ADDITIONAL FUNCTIONS (add any used method/problem here)
source("../problems/shoe-maze-problem.R")
source("../methods/Breadth First Search.R")
source("../methods/Depth First Search.R")

# And here, there are additional (needed) functions
source("../methods/Expand Node.R")
source("../methods/Analyze Results.R")
source("../methods/Plot Results.R")
# =======================================================================
# Check the proper operation of implemented function here!
source("../data/run tests.R")

# =======================================================================
# Solving of the problem (you have to adapt it)
problem   = initialize.problem("../data/maze.csv", 7, 7)
# BF <- Breadth.First.Search(problem, count.limit = 268435456)
BF <- Breadth.First.Search(problem, count.limit = 1000) #  not enough depth
DF <- Depth.First.Search (problem, count.limit = 1000) #  stuck in loop
BF.GS <- Breadth.First.Search(problem, graph.search = TRUE)
DF.GS <- Depth.First.Search (problem, graph.search = TRUE)
all <- list(BF.GS, DF.GS, BF, DF)
analyze.results(all, problem)

