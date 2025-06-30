# Cronjob
00 17 * * 1-5 /../robot/exec.sh >> /../robot/logs/robot.log 2>&1`  
00 The minute when the job runs (at the 0th minute of the hour).  
17 The hour when the job runs (5:00 PM in 24-hour format).  
* (first `*`): Day of the month ("every" day of the month).  
* (second `*`): Month of the year ("every" month).  
1-5 Day of the week (Monday [1] to Friday [5]).  
/../robot/exec.sh`**: The full path to the script you want to execute.  
/../robot/logs/robot.log 2>&1`**: Redirects both standard output (`stdout`) and errors (`stderr`) to the log file.  
