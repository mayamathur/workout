
library(here)
setwd(here)
source("helper_workout.R")



# CONVERSION EXAMPLES ---------------------------------------

# weekly mileage for a week with 6 hours of running that averages 7:45 pace
pace_to_run_miles(run_pace_mm_ss = "07:45",
                  hrs = 6)

# example of a deload week
pace_to_run_miles(run_pace_mm_ss = "08:30",
                  hrs = 4.5)


# INTERVAL EXAMPLES ---------------------------------------

# generate fixed-time intervals for swimming
# 10 evenly-paced sets, leaving the wall every 1:55
fixed_time_intervals(10, "02:15")

# with target return times
fixed_time_intervals(10,
                     leave_every_mm_ss = "02:15",
                     target_work_times = "01:48" )

# fancier 2-wave ladder structure with 4th set easier
fixed_time_intervals(8,
                     leave_every_mm_ss = "02:15",
                     target_work_times = rep( c("1:48", "1:47", "1:46", "1:55"), 2 ) )


# calculate average pace across intervals of different durations, 
#  given average paces within each interval
paces <- c("06:01", "05:45", "06:30")
durations <- c("01:30", "02:00", "01:45")
calculate_average_pace(paces, durations)
# seems to work even though I don't understand the internal logic of GPT's function