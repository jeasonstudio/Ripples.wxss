#!/bin/sh  
FILES=`ls ./source/*.css`  
  
for css in $FILES;do  
    wxss=`echo $css | sed "s/\.css/\.wxss/"`  
    echo $wxss > a.txt
    mv $css $wxss  
done 