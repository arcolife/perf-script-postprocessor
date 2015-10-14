# perf-script-postprocessor

[![Build Status](https://travis-ci.org/arcolife/perf-script-postprocessor.svg?branch=master)](https://travis-ci.org/arcolife/perf-script-postprocessor)

This calculates delta (difference of timestamps from various
entry/exit points from events recorded) from the trace output,
which is produced by using the `perf script` command, which in turn,
uses the perf.data file produced by using the `perf record` command,
a set of utilities,which is provided under the package [perf-tools](https://github.com/brendangregg/perf-tools)

## INSTALLATION

Step 1: Install from pip: `$ pip2 install perf-script-postprocessor`

Step 2: Copy [this conf file](https://raw.githubusercontent.com/arcolife/perf-script-postprocessor/master/delta_processor.conf)
     	into /etc/

Step 3: Customize the conf file accordingly.

Optional: 
Step 4: Refer to docs/WIKI.md or [this page](https://github.com/arcolife/perf-script-postprocessor/wiki) for detailed usage.

For more, refer to `INSTALL` guide. 

## TESTS

`$ ./tests/run-tests.sh`

## USAGE

```$ perf_script_processor -p <dir path> -t <test type>```

Example: ```$ perf_script_processor -p . -t 0```

`-p` (defaults to `/tmp/pp_results`) is where one of the following exists:

- perf.data -- binary file. If you're running this tool on perf.data, make sure
		you're running it from the system where the binary was generated
- raw_perf -- plain text output when `perf script` is run on folder containing perf.data
- perf_data.csv -- generated in the process of generating results

`-t` (defaults to `0`) is either `0` or `1`. It's the type of test that generated `perf.data`.

- 0: Native
- 1: Threads

NOTE: The stats at the end of run, will be stored in `delta_output.log` in folder where you've generate the output.

## FAQs and Script exection process

Refer to docs/WIKI.md or [this page](https://github.com/arcolife/perf-script-postprocessor/wiki).

## LICENSE

GPL V3
