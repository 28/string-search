let first (a, _) = a

let second (_, b) = b

let index_tuple_has_char c = function
    (x, y) when y = c -> true
    | _ -> false

let string_split sep s =
    let r = ref [] in
    let j = ref (String.length s) in
    for i = String.length s - 1 downto 0 do
        if s.[i] = sep then
            begin
                r := String.sub s (i + 1) (!j - i - 1) :: !r;
                j := i
            end
    done;
    String.sub s 0 !j :: !r

let read_file file_name =
    let ch = open_in file_name in
    let content = really_input_string ch (in_channel_length ch) in
    close_in ch;
    content

let to_source source_string =
    let l = string_split ',' source_string in
    let a = Array.of_list l in
    Array.sort compare a;
    a

let list_not_exists f a =
    let m = List.map f a in
    let res = List.fold_left (||) false m in
    res = false

let index source =
    let indexes = ref [] in
    let updater i e = 
        let c = e.[0] in
        if (list_not_exists (index_tuple_has_char c) !indexes) then
            indexes := (i, c) :: !indexes
    in
    Array.iteri updater source;
    List.rev !indexes

let find_search_range c indexes =
    let first_i = ref (-1) in
    let second_i = ref (-1) in
    let max_index = ((List.length indexes) - 1) in
    for i = 0 to max_index do
        let t = List.nth indexes i in
        if (!first_i = -1) || (!second_i = -1) then 
            if (!first_i <> -1) && (second t <> c) then
                second_i := (first t)
            else
                if (!first_i = -1) && (second t = c) then
                    first_i := (first t)
    done;
    (!first_i, !second_i)

let find st source indexes =
    let first_c = st.[0] in
    let (start_index, end_index) = find_search_range first_c indexes in
    let end_index = if (end_index = -1) then (Array.length source) - 1 else end_index in
    let search_domain = Array.sub source start_index (end_index - start_index) in
    let res = ref [] in
    let f s =
        if (Str.string_match (Str.regexp (st ^ ".+")) s 0) then
            res := s :: !res
    in
    Array.iter f search_domain;
    !res
