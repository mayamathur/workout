

# FNS FOR PACE CONVERSIONS ---------------------------------------------


### Convert running hours into miles. Especially useful for converting cross-training hours using running paces equivalent to the intensity of the cross-training (e.g., based on time trial results).

# run_pace_mm_ss: quoted string "mm:ss" for average run pace (e.g., over a week) or cross-training equivalent
# hrs: numeric hours of training

pace_to_run_miles = function( run_pace_mm_ss,
                              hrs
) {
  require(lubridate)
  
  sec_per_mile = period_to_seconds( ms(run_pace_mm_ss) )
  
  (hrs*(60^2))/sec_per_mile
  
}


# FNS FOR INTERVALS ---------------------------------------------

### For fixed-time intervals (e.g., swim intervals where you leave the wall
#  every 2:00), generates a chart of times to leave. Optionally generates target return times depending on how long each work set should take.

# n_sets: number of intervals
# leave_every_mm_ss: quoted string "mm:ss" for how long each interval, including rest, lasts
# target_work_times: quoted string "mm:ss" for how the target work times for each interval. If length = 1, assumes each target time is the same (i.e. even pacing).
fixed_time_intervals = function(n_sets,  
                                leave_every_mm_ss,
                                target_work_times = NULL ){
  
  # # TEST only
  # n_sets = 4
  # leave_every_mm_ss = "02:15"
  # target_work_times = c("1:48", "1:47", "1:46", "1:55")
  
  require(lubridate)
  
  leave_every_sec = period_to_seconds( ms(leave_every_mm_ss) )
  
  
  # last time I should leave the wall
  leave_time_sec = ( 0 : (n_sets-1) ) * leave_every_sec 
  
  d = data.frame( set = 1:n_sets,
                  leave_at = sec_to_mm_ss(leave_time_sec) )
  
  
  
  if ( !is.null(target_work_times) ) {
    
    if ( length(target_work_times) == 1 ){
      target_work_times = rep( target_work_times, n_sets )
    }
    
    if ( length(target_work_times) < n_sets ) {
      stop("target_work_times should have length equal to n_set or 1")
    }
    
    target_work_sec = period_to_seconds( ms(target_work_times) )
    
    d$return_at = sec_to_mm_ss(leave_time_sec + target_work_sec)
  }
  
  return(d)
  
}


# given average paces and duration for a series of intervals, calculate average pace
# courtesy of ChatGPT, which wrote incorrect comments and needed some human intervention...

calculate_average_pace <- function(paces, durations) {
  # Convert pace and duration strings to seconds
  # MM: pace_seconds is seconds/mile
  pace_seconds <- sapply(strsplit(paces, ":"), function(x) as.numeric(x[1]) * 60 + as.numeric(x[2]))
  duration_seconds <- sapply(strsplit(durations, ":"), function(x) as.numeric(x[1]) * 60 + as.numeric(x[2]))
  
  # this comment is totally wrong yet the fn works??
  # Calculate total distance in meters (assuming you're running at a constant pace)
  distance <- sum(duration_seconds / pace_seconds)
  
  # Calculate total duration in seconds
  total_time <- sum(duration_seconds)
  
  # Calculate average pace in seconds per meter
  average_pace <- total_time / distance
  
  # Convert average pace back to mm:ss format
  average_pace_minutes <- floor(average_pace / 60)
  average_pace_seconds <- round(average_pace - (average_pace_minutes * 60))
  average_pace_string <- sprintf("%02d:%02d", average_pace_minutes, average_pace_seconds)
  
  # Return the average pace
  return(average_pace_string)
}



# BASIC UTILITY FNS ---------------------------------------------

# convert sec to string "mm:ss"  
sec_to_mm_ss = function(t){
  paste(paste(formatC(t %/% 60 %% 60, width = 2, format = "d", flag = "0"),
              formatC(t %% 60, width = 2, format = "d", flag = "0")
              ,sep = ":"
  )
  )
}
# example
# sec_to_mm_ss(1305)

# add durations given as mm:ss
add_durations <- function(durations) {
  total_seconds <- sum(sapply(durations, function(x) {
    split_time <- strsplit(x, ":")
    as.numeric(split_time[[1]][1]) * 60 + as.numeric(split_time[[1]][2])
  }))
  
  total_minutes <- floor(total_seconds / 60)
  total_seconds_remaining <- total_seconds %% 60
  
  sprintf("%02d:%02d", total_minutes, total_seconds_remaining)
}

# example
# add_durations( c("01:58", "02:02", "03:20") )




