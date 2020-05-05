# Title     : Run modificare algo by this script.
# Objective : test built-in TCP algorithms.
# Created by: misha
# Created on: 15.03.2020

# PROJECT_NAME <- "time"

init <- function () {
  source("FDP_Start.R")
  zTryReload()
  zLoadFaultExperiment()
  zLoadFaultLocalizationExperiment()
  zLoadFaultLibraries()
  zLoadProduceOrderingReductionDataFile()
}

save_ordering <- function (y, algoname) {
  ordering <- y$Ord
  ord <- produceOrderingReductionDataFile(testSuite=ordering,
                                          timingsFile=TIMING_FILE)
  write.table(ord, file=sprintf("%s_%s", PROJECT_NAME, algoname), row.names=FALSE,
              col.names=FALSE, quote=FALSE)
}

run_random_n_times <- function (time=10) {
  for (seed in 1:time) {
    print(paste("testing random TCP with seed:", seed))
    y <- Rand_POP(lFM=x, cPopSize=20 + seed, Seed=seed)
    save_ordering(y, sprintf("random_ordering_%s.txt", seed))
  }
}

run_greedy_n_times <- function (times) {
  for (seed in 1:times) {
    print(paste("Testing greedy algorithm with seed:", seed))
    y <- GRD(COV_MATRIX_PATH, TIMING_FILE, seed=seed)
    save_ordering(y, sprintf("greedy_ordering_%s.txt", seed))
  }
}

run_greedy <- function () {
  print("run greedy algorithm:")
  y <- GRD(COV_MATRIX_PATH, TIMING_FILE)
  save_ordering(y, "greedy_ordering.txt")
}

run_GA_n_times <- function (times) {
  for (seed in 1:times) {
    print(paste("Testing GA with seed:", seed))
    y <- GA(x, Seed=seed)
    save_ordering(y, sprintf("genetic_ordering_%s.txt", seed))
  }
}

run_GA <- function () {
  print("Running GA algorithm.")
  y <- GA(x)
  save_ordering(y, "genetic_ordering.txt")
}

run_HC_FA_n_times <- function (times) {
  for (seed in 1:times) {
    print(paste("Testing HC_FA with seed:", seed))
    y <- HC_FA(x, Seed=seed)
    save_ordering(y, sprintf("HC_FA_ordering_%s.txt", seed))
  }
}

run_HC_FA <- function () {
  print("Running HC_FA algorithm.")
  y <- HC_FA(x)
  save_ordering(y, "HC_FA_ordering.txt")
}

run_ART <- function () {
  print("run ART (dist=Manh, avg).")
  y <- ART(read.table(COV_MATRIX_PATH), "ManhattanDistance", "avg")
  save_ordering(y, "ART_man_avg_ordering.txt")
}

run_HC_SA <- function () {
  print("Running HC_SA algorithm.")
  y <- HC_SA(x)
  save_ordering(y, "HC_SA_ordering.txt")
}

# Error in HC_RA_real(lFM, NG, Ord, Seed) (FDP_HC.R#352): object 'ItLimit' not found
# run_HC_RA <- function () {
#   print("Running HC_RA algorithm.")
#   y <- HC_RA(x, NG="NG_LS", Seed=100)
#   save_ordering(y, "HC_RA_ordering.txt")
# }

run_SANN <- function () {
  print("Running SANN algorithm.")
  y <- SANN(x)
  save_ordering(y, "SANN_ordering.txt")
}

PROJECT_NAMES <- c("chart", "lang", "time", "math", "closure")
n <- 5
init()
for (PROJECT_NAME in PROJECT_NAMES) {
  print(sprintf("Running project %s", PROJECT_NAME))
  COV_MATRIX_PATH <- sprintf("reqMatrices/D4J_method_matrices/%s_method_coverage_matrix.txt", PROJECT_NAME)
  TIMING_FILE <- sprintf("reqMatrices/TimingsFiles/%s_id_name_mapping.txt", PROJECT_NAME)
  x <- makeLogFM(read.table(COV_MATRIX_PATH))
  run_HC_FA_n_times(n)
  run_greedy_n_times(n)
  # run_random_n_times(100)
  # run_GA()
  # run_ART()
  # run_greedy()
  # run_HC_SA()
  # run_HC_FA()
  # run_HC_RA()
  # run_SANN()
}
