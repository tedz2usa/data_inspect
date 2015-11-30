# data_inspect
A command line utility and Ruby gem for inspecting and interpreting the contents of binary files.

## Usage
`data_inspect` can be used as both a command line tool and a ruby class imported as a Ruby gem.


### Command Line Tool

```
$ data_inspect
```
returns help information for how to use the command-line tool.
<br><br>

```
$ data_inspect myfile
```
displays the byte value of every byte in the file.
<br><br>

```
$ data_inspect myfile -h
```
displays the byte values in hexadecimal
<br><br>

```
$ data_inspect myfile -b
```
displays the byte values in binary
<br><br>

```
$ data_inspect myfile -o 219
```
displays the byte values after an offset of 219 bytes.

```
$ data_inspect myfile -l 50
```
<br><br>

```
$ data_inspect myfile -s 2 -bo big_endian
```
display the values of words with size 2, interpreting the byte order as big endian. Use `little_endian` for little endian.

Usage of the combined bytes option (-c) requires the byte order option (-bo).
<br><br>

```
$ data_inspect myfile -f signed_int
```
interpret the data values as signed integers. Use `unsigned_int` for unsigned integers. Use `float` for IEEE single-precision binary floating-point format. Use `double` for IEEE double-precision binary floating-point format. 

Formats where the word-size can be inferred (`float`, `double`), do not require the -c, attribute, but if they are multibyte (like `float` and `double`), they do require the -bo byte order attribute.

Formats where the word-size cannot be inferred will use the -c attribute.
<br><br>

```
$ data_inspect myfile -f ascii
```
(coming soon) interpret the data values as ascii. (coming soon) interpret the data values as UTF-8, using `utf8`.
<br><br>

```
$ data_inspect myfile -v
```
Verbose mode. It will echo back the version number, and the options hash it has interpreted from your command line options.
<br><br>


### In Ruby

