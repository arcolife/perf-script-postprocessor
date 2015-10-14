#!/bin/bash

test1=$(./bin/delta_processor -i ./tests/data/native/perf_data.csv \
		      -o ./tests/data/output/ \
		      -l ./tests/data/output/delta_output.log \
		      -t 0 -m 0 \
		      -c delta_processor.conf)
if [ $(cat ./tests/data/output/loop_diff.csv | wc -l) -eq 2 ]; then
    echo "SUCCESS"    
else
    echo "test1 failed.."
    exit 1
fi
