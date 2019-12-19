# String search module

An OCaml module for efficient string searching from a provided source.
Idea behind is to supply the string source as an one line CSV list.
The source will be indexed based on first characters of the words which
will be used for searching.

Should not be used for anything serious, I am learning the language.

## Usage

In order to use the example script string source must be a single line
CSV file named `source.txt` and should be located next to the script.

First compile the sources and start the REPL.

``` powershell
# compile
.\search_compile.ps1

# start the REPL
ocaml
```

In REPL:
``` ocaml
#use "example.ml";;
```
At that point source will be imported as `val source` and indexes
will be created as `val index`. They can be used for searching:

``` ocaml
let result = find "any" source index;;

val result : string list =
  ["anywhere"; "anyway"; "anything"; "anyone"; "anybody"]
```

To import and index another source:
``` ocaml
let new_source = to_source (read_file "new_source.txt");;

let new_source_index = index new_source;;
```
