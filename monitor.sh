#!/bin/bash
oldCursor=$(head -1 /var/webserver_monitor/counter.txt)
echo $oldCursor
newCursor=$(wc -l < /var/webserver_monitor/unauthorized.log)
newLines=`expr $newCursor - $oldCursor`
if ((newLines > 0))
then
        tail -n $newLines  /var/webserver_monitor/unauthorized.log | mail -s "New entries" m7684123@gmail.com
else
        echo "No unauthorized access" | mail -s "New entries" m7684123@gmail.com
fi
echo $newLines > /var/webserver_monitor/counter.txt
