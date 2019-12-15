#!/bin/bash
echo Press CTRL-C to exit.  may need to do it twice
nAnyNVidia=0
if [ ! -e '/bin/nvidia-smi' ] ; then
	nAnyNVidia=`nvidia-smi -L | grep -c GPU`
fi

nAnyATI=`sensors | grep -c amd`

if [ $nAnyATI -gt 0 ] && [  $nAnyNVidia -gt 0 ] ; then
  echo cannot at current time have both ATI and NVIDIA
  echo this script will choose the one with the most boards
  if [ $nAnyAti -gt $nNVidia ] ; then
   nAnyNVidia = 0
  else
   nAnyATI = 0
  fi
fi

bRun=1

function ctrl_c() {
	bRun=0
}

#  if any nvidia boards, the FetchTemps script will assume no ATI boards
# and vice versa until I figure out how to put both in

while [ $bRun -eq 1 ];
do
	rtncod=`./FetchTemps.py "$nAnyNVidia" "$nAnyATI"`
	if [ $? -eq 1 ]; then
		 break
	fi
	sleep 10
done
