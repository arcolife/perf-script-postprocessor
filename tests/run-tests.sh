#!/bin/sh

./bin/delta_processor -i ./tests/data/native/perf_data.csv \
		      -o ./tests/data/output/ \
		      -l ./tests/data/output/delta_output.log \
		      -t 0 -m 0
test1=$(diff ./tests/data/output/delta_output.log ./tests/data/native/delta_output.log)
test2=$(diff ./tests/data/output/loop_diff.csv ./tests/data/native/loop_diff.csv)

if [[ ! -z $test1 ]]; then
    echo "test1 failed.."
    exit 1
fi

if [[ ! -z $test2 ]]; then
    echo "test2 failed.."
    exit 1
fi

echo "SUCCESS"
