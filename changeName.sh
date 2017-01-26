#!/bin/sh  
FILES=`ls ./source/*/*.css`  
  
for css in $FILES;do  
    wxss=`echo $css | sed "s/\.css/\.wxss/"`  
    echo $wxss  
    mv $css $wxss  
done 