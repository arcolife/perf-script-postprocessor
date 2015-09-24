#!/bin/bash

# usage: $ ./perf_script_process.sh <dir where perf.data exists>

# $DUMP_PATH='/tmp/pp_results/'
DUMP_PATH=$1

# run perf script, grep for qemu-kvm (this can be adjusted)
# then get the timestamp and metric fields, clean them and
# dump the data in a csv file

if [[ ! -z $DUMP_PATH ]]; then 
	if [ -f $DUMP_PATH'perf.data' ]; then
		perf script | grep qemu-kvm | awk -F' ' '{print $4,$5}' | \
		    sed 's/sched://g' | sed 's/kvm://g' | sed 's/syscall://g' | \
		    sed 's/://g' | sed 's/ /,/g' > $DUMP_PATH'perf_data.csv'
		# add header to csv file
		sed -i '1s/^/tstamp,entry\n/' $DUMP_PATH'perf_data.csv'
	elif [ -f $DUMP_PATH'perf_data.csv' ]; then
	    # run postprocessor on that
	    ./delta_processor.py --input=$DUMP_PATH'perf_data.csv' --output=$DUMP_PATH #--per_metric=True
	# else
	# 	echo "ERROR! Failed to somehow write to intermediate result file perf_data.csv."
	# fi
	else
		echo "ERROR! This path doesn't contain 'perf.data'. I Quit.."
	fi
else
	echo "ERROR! You need to specify a dir path where perf.data resides"
	echo -e "Usage:\t$ ./perf_script_process.sh <dir where perf.data exists>"
fi
