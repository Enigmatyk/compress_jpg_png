#!/bin/bash

RANDOM=$(((RANDOM % 999)+1))
STATIC=${RANDOM}
DATE=`date +%Y%m%d`
TMPDIR=/tmp
BLOGFILE=${TMPDIR}/`basename "$0"`-${STATIC}-${DATE}-BEFORE.log
ALOGFILE=${TMPDIR}/`basename "$0"`-${STATIC}-${DATE}-AFTER.log


[ ! -d $1 ] && echo "Please specify a valid directory" && exit 1

find $1 -type f \( -iname  '*.jpg' -o -iname '*.png' \) |
while read FILE;do
   case ${FILE} in 
	 *.jpg)
	du -h ${FILE} >> ${BLOGFILE} 
	jpegtran ${FILE} > ${FILE}.buffer.jpg
	mv ${FILE}.buffer.jpg ${FILE}
	du -h ${FILE} >> ${ALOGFILE} ;;
	 *.png)
	du -h ${FILE} >> ${BLOGFILE}
	pngcrush -rem allb -brute -reduce ${FILE} > ${FILE}.buffer.png 
	mv ${FILE}.buffer.png ${FILE}
	du -h ${FILE} >> ${ALOGFILE} ;;
   esac
done
