# data_inspect
A command line utility and Ruby gem for inspecting and interpreting the contents of binary files.

## Usage
`data_inspect` can be used as both a command line tool and a ruby class imported as a Ruby gem.


### Command Line Tool

```
$ data_inspect
```
returns help information for how to use the command-line tool.
  

```
$ data_inspect myfile
```
displays the byte value of every byte in the file.


```
$ data_inspect myfile -h
```
displays the byte values in hexadecimal


```
$ data_inspect myfile -b
```
displays the byte values in binary


```
$ data_inspect myfile -o 219
```
displays the byte values after an offset of 219 bytes.

```
$ data_inspect myfile -l 50
```


```
$ data_inspect myfile -c 2 -bo big_endian
```
display the byte values with every two bytes combined, interpreting the byte order as big endian. Use `little_endian` for little endian.

Usage of the combined bytes option (-c) requires the byte order option (-bo).


```
$ data_inspect myfile -f signed_int
```
interpret the data values as signed integers. Use `unsigned_int` for unsigned integers. 





```
$ data_inspect myfile -f ascii
```
(coming soon) interpret the data values as ascii. (coming soon) interpret the data values as UTF-8, using `utf8`.



### In Ruby

