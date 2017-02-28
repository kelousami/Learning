#!/bin/bash

source=("1" "2" "3" "4" "5")
echo $source
for i in $source
do
    echo $i
done

source=("1" "2" "3" "4" "5")
echo $source
for i in ${source[@]}
do
  echo $i
done

source=""a" "b" "c""
echo $source
for i in $source
    do echo $i
done

emails=( "me@example.com" "he@example.com" )

function sendmail1()
{
    for email in $emails
    do
      echo ${emails[$i]}
    done
}

function sendmail2()
{
    for ((i=0; i < ${#emails[@]}; i++))
    do
      echo ${emails[$i]}
    done
}

echo sendmail1
sendmail1

echo sendmail2
sendmail2
