#!/home/bourbaki/bin/ksh93

print $1
print $2
print $#
print $*
print ${@}
shift #elimina el primer argumento
print $1
print $2
print $#
print $*

