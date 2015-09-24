# perf-script-postprocessor

This calculates delta (difference of timestamps from various
entry/exit points from events recorded) from the trace output,
which is produced by using the `perf script` command, which in turn,
uses the perf.data file produced by using the `perf record` command,
a set of utilities,which is provided under the package [perf-tools](https://github.com/brendangregg/perf-tools)

## INSTALLATION

`$ sudo ./install`

## USAGE

```
$ perf_script_processor <dir path where either perf.data or perf_data.csv exists>
```

However if you wanna use the delta_processor script directly, to utilize more
options, use it like this:

```
DUMP_PATH='/tmp/pp_results/'
delta_processor --input=$DUMP_PATH'/perf_data.csv' --output=$DUMP_PATH
```

* Define DUMP_PATH as you would like it to be. Ensure, script has write permissions to
	the folder.

* use the `--per_metric=True` if you want the metric deltas to be dumped in separate 
  csv files, which might go like this:

	```
	kvm___.csv
	sched_switch.csv
	syscallssys__futex.csv
	syscallssys__io_getevents.csv
	syscallssys__io_submit.csv
	syscallssys__ppoll.csv
	syscallssys__pwrite64.csv
	syscallssys__pwritev.csv
	```

Note: 
perf_data.csv is produced by using the perf_script_processor command.
This is incase, one has already produced the csv file from a previous run
of postprocessor script.

## LICENSE

GPL V3
