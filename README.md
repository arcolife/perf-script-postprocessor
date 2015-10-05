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

delta_processor --input=$DUMP_PATH'/perf_data.csv' --output=$DUMP_PATH --conf=<conf path> --mode=<0,1,2,3>
```

* Either set an env var DUMP_PATH as you would like it to be 
  and use that throughout the session, or supply a custom path.. 
  Just ensure that script has write permssions to the folder.

* Generate delta of events for data from `perf script`[3]. 
  

* This script runs in 3 modes. Those being:

    - `Mode 0`: Produce `delta_processed.csv` with __all events together__[2].
    - `Mode 1`: In addition to mode 0, this calculates __loop statistics__[1].
    - `Mode 2`: breakup result into __per-event calculated delta csv files__.
    - `Mode 3`: only calculates __loop statistics__ (from perf_data.csv).

* [1] Set this in `/etc/delta_processor.conf`. Default is as below:

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

## FAQ

* Why are graphs not generated for the results?

	The no of x-axis points would be be large enough, given the length of 
	all kvm entries and size of entry/exit points. Even if this is plotted 
	in nvd3, I don't think one would be able to make out the differences 
	that minute.. Hence we leave it to only producing a delta in a huge csv file.


## LICENSE

GPL V3


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/arcolife/perf-script-postprocessor/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

