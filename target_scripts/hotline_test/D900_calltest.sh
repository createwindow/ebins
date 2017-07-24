#!/system/bin/sh
#set -x
if [ -f /tmp/autocall.lock ]; then
 exit 0
fi
touch /tmp/autocall.lock
echo $1

if [ -f /tmp/autocnt ]; then
. /tmp/autocnt
else
 calltimes=0
fi
#counter=0
while true 
do 
#sleeptime=`awk 'BEGIN{srand();sum=rand()*6;printf("%d\n",sum+1)}'`
#echo "The random num =$sleeptime" 

let calltimes=$calltimes+1
echo $calltimes
echo calltimes=$calltimes > /tmp/autocnt

let counter=$counter+1
#if [ $counter -eq 20 ]; then
#debug=1
#setprop debug.fanvil.malloc ok
#counter=0
#fi

cat handsfree.key > /dev/input/event1 &

#sleep $sleeptime
sleep 5
#cat /proc/ept/perfsum

#sleeptime=`awk 'BEGIN{srand();sum=rand()*8;printf("%d\n",sum+1)}'`
#sleep $sleeptime
sleep 3

cat handsfree.key > /dev/input/event1 &

#sleeptime=`awk 'BEGIN{srand();sum=rand()*5;printf("%d\n",sum+1)}'`
#sleep $sleeptime
sleep 5

#if [ $debug -eq 1 ]; then
#debug=0
#setprop debug.fanvil.malloc no
#fi

done
exit 0








cat handsfree.key > /dev/input/event0 &


path=`pwd`
echo $path
rm /tmp/autocall.lock
$path/test.sh $1 &
