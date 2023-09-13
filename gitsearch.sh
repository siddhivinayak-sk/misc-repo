DIR=$1
for d in $DIR/*/ ; do 
	echo "$d"
	cd $d
	git grep -e "$2"
done
