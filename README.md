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

* Generate delta of entry/exit points for data from `perf script`[3]. 
  
* This script runs in 3 modes. Those being:

    - `Mode 0`: Produce `delta_processed.csv` with __all events together__[2].
    - `Mode 1`: In addition to mode 0, this calculates __loop statistics__[1].
    - `Mode 2`: breakup result into __per-event calculated delta csv files__.
    
* [1] Loop order:

``` kvm_exit -> sys_exit_ppoll -> sys_enter_io_submit -> sys_exit_io_submit ```

* [2] Main events:
	
	```
		kvm___
		sched_switch
		syscallssys__futex
		syscallssys__io_getevents
		syscallssys__io_submit
		syscallssys__ppoll
		syscallssys__pwrite64
		syscallssys__pwritev
	```
* [3] Check more options for script through `$ delta_processor -h`

Note: 
perf_data.csv is produced by using the perf_script_processor command.
This is incase, one has already produced the csv file from a previous run
of postprocessor script.

## LICENSE

GPL V3
