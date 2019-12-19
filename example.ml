#load "Str.cma";;

#load "Search.cmo";;

open Search;;

let source = to_source (read_file "source.txt");;

let index = index source;;
