

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


# swim interval chart
swimterval_chart = function(n_sets,  # number of intervals
                            leave_every_mm_ss  # quoted string "mm:ss" for how long each interval, including rest, lasts
                            ){
  
  require(lubridate)
  
  leave_every_sec = period_to_seconds( ms(leave_every_mm_ss) )
  
  # last time I should leave the wall
  leave_time_sec = ( 0 : (n_sets-1) ) * leave_every_sec 
  
  
  data.frame( set = 1:n_sets,
                  leave_at = sec_to_mm_ss(leave_time_sec) )

}

