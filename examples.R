
library(here)
setwd(here)
source("helper_workout.R")


# INTERVAL EXAMPLES ---------------------------------------

# generate fixed-time intervals for swimming
# 10 evenly-paced sets, leaving the wall every 1:55
fixed_time_intervals(10, "02:15")

# fancier 2-wave ladder structure with 4th set easier
fixed_time_intervals(8,
                     leave_every_mm_ss = "02:15",
                     target_work_times = rep( c("1:48", "1:47", "1:46", "1:55"), 2 ) )
