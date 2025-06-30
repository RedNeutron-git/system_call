#!/bin/bash

user='metal.zero.one%40kingslanding.com'
pass='put_your_key'

dates=$(date +%Y-%m-%d)
cl=$(date +%H:%M:%S)

echo "Action=Login&RequestedURL=&Lang=en&TimeZoneOffset=-420&User=$user&Password=$pass" > post_data.am
response_login=$(curl -i -s -k -X POST -H "Host: alpha.kingslanding.com" -d @post_data.am "https://alpha.kingslanding.com/otrs/index.pl")
rm -rf post_data.am
echo $response_login > save_loginz.am
sessionz=$(cat save_loginz.am | awk -F'=' '{print $NF}' | awk -F'>' '{print $1}' | sed 's/"//g')

#---------------------------------------------------------------#
# Uncomment for debug
#echo $sessionz > sessionz.junk
#---------------------------------------------------------------#

rm -rf save_loginz.am

# Lists
data=("Key-1%0D%0A" "Key-2%0D%0A")

qnt_dsp=3
txt_dsp=()
sqnc_num=1

while [ ${#txt_dsp[@]} -lt $qnt_dsp ]
do
  jml_dt=${#data[@]}
  if [ $jml_dt -gt 0 ]; then
    dt_num=$((RANDOM % jml_dt))
    tx_data2=${data[$dt_num]}
    unset 'data[$dt_num]'
    if [ -n "$tx_data2" ] && ! [[ "${txt_dsp[@]}" =~ "$tx_data2" ]]; then
      printf ">> Report $sqnc_num: %s\n" "$tx_data2"
      txt_dsp+=("$tx_data2")
      ((sqnc_num++))
    fi
  fi
done > data2.am
data2z=$(cat data2.am)
pr=$(printf "%s\n")

#---------------------------------------------------------------#
# Uncomment for debug
#echo $pr > data2.junk
#---------------------------------------------------------------#

echo "opnumber=0000&sitename=CrossTekIn&epm=leader.squad%40kingslanding.com&asgdate1=$dates&asgdate2=$dates&asgproject%5B%5D=5&actdeploy=&asgjob%5B%5D=16&asgjob%5B%5D=24&actstatus=1&techissue=NO&troubleticket=&summary=Sign: $cl - $dates%0D%0A$pr$data2z&session=$sessionz" > data1.am
Refererz=$(echo https://alpha.kingslanding.com/daily_report/input.php?Session=$sessionz)
rspns_abs=$(curl -i -s -k -X POST -H $'Host: alpha.kingslanding.com' -H $'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/117.0' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/x-www-form-urlencoded' -H $'Origin: https://alpha.kingslanding.com' -H $'Connection: close' -H $'Referer: $Refererz' -H $'Upgrade-Insecure-Requests: 1' -H $'Sec-Fetch-Dest: document' -H $'Sec-Fetch-Mode: navigate' -H $'Sec-Fetch-Site: same-origin' -H $'Sec-Fetch-User: ?1' -d @data1.am "https://alpha.kingslanding.com/daily_report/input.php" | tr -d '\0')

rm -rf data1.am data2.am

#---------------------------------------------------------------#
# Uncomment for debug
#echo $rspns_abs > respon_absen.junk
#---------------------------------------------------------------#

# Cronjob
# 00 17 * * 1-5 /../robot/exec.sh >> /../robot/logs/robot.log 2>&1`  
# 00 The minute when the job runs (at the 0th minute of the hour).  
# 17 The hour when the job runs (5:00 PM in 24-hour format).  
# * (first `*`): Day of the month ("every" day of the month).  
# * (second `*`): Month of the year ("every" month).  
# 1-5 Day of the week (Monday [1] to Friday [5]).  
# /../robot/exec.sh`**: The full path to the script you want to execute.  
# /../robot/logs/robot.log 2>&1`**: Redirects both standard output (`stdout`) and errors (`stderr`) to the log file.  
