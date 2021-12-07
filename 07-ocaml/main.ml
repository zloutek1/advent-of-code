
let sum l = List.fold_right (fun x acc -> acc + x) l 0;;
let avg l = (sum l) / (List.length l);;
let range n = List.init n succ;;    

let max_list = function
    []    -> invalid_arg "empty list"
  | x::xs -> List.fold_left max x xs

let min_list = function
    []    -> invalid_arg "empty list"
  | x::xs -> List.fold_left min x xs

let part1 data = 
    let attempt goal = data |> List.map (fun x -> abs (x - goal)) |> sum in
    let maxi = max_list data in
    let mini = min_list data in
    range (maxi - mini) |> 
    List.map (fun x -> mini + x) |> 
    List.map attempt |> 
    min_list;;

let part2 data = 
    let attempt goal = data |> List.map (fun x -> let n = abs(x - goal) in n*(n+1)/2) |> sum in
    let maxi = max_list data in
    let mini = min_list data in
    range (maxi - mini) 
    |> List.map (fun x -> mini + x) 
    |> List.map attempt 
    |> min_list;;

let parse_line line = String.split_on_char ',' line
                    |> List.map int_of_string;;

let print_l l = l |> List.map string_of_int |> String.concat "," |> print_string;;


let line = open_in "input.txt" |> input_line |> parse_line;;
part1 line |> Printf.printf "[Part1] %d\n";;
part2 line |> Printf.printf "[Part2] %d\n";;


