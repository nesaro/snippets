cut -d : -f 1,4 group | sort -k 1 -t : > group2
cut -d : -f 1,4 group |grep -e ":root\|,root,\|root$" | sort -k 1 -t :
