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

perf_data.csv is produced by using the perf_script_processor command.
This is incase, one has already produced the csv file from a previous run
of postprocessor script.

## LICENSE

GPL V3
