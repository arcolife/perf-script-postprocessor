## SCRIPT EXECUTION PROCESS

`perf_scirpt_processor` calls a python script `delta_processor` with options set to default as follows:

```
delta_processor -i ${DUMP_PATH%/}/perf_data.csv -o $DUMP_PATH -m 0 -c /etc/delta_processor.conf -t 0 -l ${DUMP_PATH%/}/delta_output.log
```

However if you wanna use the `delta_processor` script directly, to utilize more options, use it like this:

```
DUMP_PATH='/tmp/pp_results/'

delta_processor --input=$DUMP_PATH'/perf_data.csv' --output=$DUMP_PATH --conf=<conf path> --mode=<0,1>

```

* Either set an env var DUMP_PATH as you would like it to be 
  and use that throughout the session, or supply a custom path.. 
  Just ensure that script has write permssions to the folder.

* Generate delta of events for data from `perf script`[3]. 
  

* This script runs in 3 modes. Those being:

    - `Mode 0`: Produce `loop_diff.csv` with __all events together__ and the __loop statistics__[1].
    - `Mode 1`: breakup result into __per-event calculated delta csv files__.

* [1] Set event loop order in `/etc/delta_processor.conf`. For default, check the file `delta_processor.conf`.

* [2] Events are like this:
	
	```
		kvm___
		sched_switch
		sys__futex
		sys__io_getevents
		sys__io_submit
		sys__ppoll
		sys__pwrite64
		sys__pwritev
	```
	
	For detailed list, refer this [perf.txt](https://gist.githubusercontent.com/staticfloat/ad064cd6ae653f2afba7/raw/324a81a7423dd94226bd7ad3d1035a517612720f/perf.txt)	

* [3] Check more options for script through `$ delta_processor -h`

Note: 
perf_data.csv is produced by using the perf_script_processor command.
This is incase, one has already produced the csv file from a previous run
of postprocessor script.

## FAQs

* What's the Algo used to extract events?
    
    Currently Algo 2 is used. Algo 1 is included here, if you have events, 
    which you think are sequentially present in the loop. Eg: A->B->C->D . 
    This would then be faster than Algo 2. Switch to Algo 1 if you think 
    that might benefit your case and needs. 

	ALGO 2: Generic algo, gets latest n events in order of loop_order
	once loop_order[-1] is found.. CODE is included in `delta_processor.prepare_delta` module

	ALGO 1: Assumes events are sequential once loop_order[-1] is found. CODE:

```py
# NOTE: df1.set_index('entry')['tstamp'].to_dict() is slower 
# than zip()

indices = self.df[self.df.entry == self.loop_order[-1]].index
pat_len = len(self.loop_order)
for i in indices:
    df1 = self.df.ix[i-(pat_len-1):i]
    data.append(dict(zip(df1.entry, df1.tstamp)))
```

* Why are graphs not generated for the results?

	The flame graphs can be generated for such a dataset. Refer to [this blog](http://www.brendangregg.com/perf.html#FlameGraphs). But if one needs to see
	the y axis points, well they're really present in a huge amount, ofcourse,
	which could be handled through analytical methods later on. But for now,
	this doesn't support such analysis. (given the number of loops in resultant data). 
	Hence we leave it to only producing a delta in a csv file.

* How much time does it take for the tool to generate results?

	Depends on the size of your extracted data (plain text) from perf.data. 
	For a 1.5 Gb raw_perf, the script takes about 40-45 secs on an Intel model 
	`name	: Intel(R) Xeon(R) CPU X5365  @ 3.00GHz`. 

* How do I know the script isn't stuck and is actually running?

	The script at the beginning of the test, in a few sec, would produce an stdout like this
	```
	Unique metrics found:
	  sys__ppoll
	  sys__pread64
	  kvm___
	```
	
	This means the data has been loaded, and keys have been processed. It then calls
	the `prepare_delta()` method which processed loop deltas. The result of that would 
	add on to the stdout like this:
	
	```
	 **********************
	 delta:exit_ppoll__kvm_exit stats:
	  Standard Dev: xxx
	  Mean: xxx
	  Median: xxx
	 ======================
	 delta:enter_pread64__exit_ppoll stats:
	  Standard Dev: xxx
	  Mean: xxx
	  Median: xxx
	 ======================
	 delta:exit_pread64__enter_pread64 stats:
	  Standard Dev: xxx
	  Mean: xxx
	  Median: xxx
	 ======================
	 Script was executed with Mode option 3.
	 Results have been stored to: thread/
	 Time taken -- prepare_delta() -- 41.4485499859
	```
	In addition, it will produce a	`loop_diff.csv` and a `perf_data.csv` in the output dir.
	
	If it doesn't, Well :shit: . 
