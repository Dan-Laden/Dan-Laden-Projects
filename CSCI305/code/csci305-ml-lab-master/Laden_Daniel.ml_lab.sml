(***************************************************************
*
* CSCI 305 - ML Programming Lab
*
* <Daniel> <Laden>
* <dthomasladen@gmail.com>
*
*
* Assistance with this lab by Chris McCabe
* I couldn't think correctly about how to use sml he assisted me by drawing out ideas on a white board.
* Solutions here are back and forths between hime and me and getting bug fix ideas from him
***************************************************************)

(* Define your data type and functions here *)

datatype ''a Set = Empty | Set of ''a * ''a Set;

fun f [] = [] (* a *)
  | f (x::xs) = (x + 1) :: (f xs); (* b *)


(*Checks to see if a value is inside of a set*)
fun isMember value Empty = false
             |
             isMember value (Set(x, xs)) =
             if x = value then true
             else if xs = Empty then false
             else isMember value xs;

(*Converts a list into a set*)
fun list2Set [] = Empty
                   |
                   list2Set (x::xs) =
                   let
                     val left = list2Set xs
                   in
                     if not(isMember x left) then Set(x, left) else left
                   end;

(*Converts a set into a list*)
fun set2List Empty = []
       |
   set2List (Set(x, xs)) = x::set2List xs;

(*Combines two sets together using lists to easily complete the function*)
fun union set1 Empty = set1
         |
   union set1 set3 = (*convert the two into lists and push them together and then remove redundances with a function already defined*)
         list2Set((set2List set1)@(set2List set3));

(*Finds what values two sets have in common*)
fun intersect set1 Empty = Empty
          |
   intersect set1 (Set set3) = (*#1 is the left side of the set and #2 is the right. My solution using Set(x,xs) wasn't working at all for some reason*)
    if(isMember (#1 set3) set1) then Set((#1 set3), intersect set1 (#2 set3)) else intersect set1 (#2 set3);



(* Simple function to stringify the contents of a Set of characters *)
fun stringifyCharSet Empty = ""
  | stringifyCharSet (Set(y, ys)) = Char.toString(y) ^ " " ^ stringifyCharSet(ys);

(* Simple function to stringify the contents of a Set of ints *)
fun stringifyIntSet Empty = ""
  | stringifyIntSet (Set(w, ws)) = Int.toString(w) ^ " " ^ stringifyIntSet(ws);

(* Simple function to stringify the contents of a Set of strings *)
fun stringifyStringSet Empty = ""
  | stringifyStringSet (Set(z, zs)) = z ^ " " ^ stringifyStringSet(zs);

(* Simple function that prints a set of integers *)
fun print_int x = print ("{ " ^ stringifyIntSet(x) ^ "}\n");

(* Simple function that prints a set of strings *)
fun print_str x = print ("{ " ^ stringifyStringSet(x) ^ "}\n");

(* Simple function that prints a set of characters *)
fun print_chr x = print ("{ " ^ stringifyCharSet(x) ^ "}\n");

list2Set [1, 3, 2];
list2Set [#"a", #"b", #"c"];
list2Set [];
list2Set [6, 2, 2];
list2Set ["x", "y", "z", "x"];

(* Question 1*)
f [3, 1, 4, 1, 5, 9];

(* Question 5*)
val quest5 = isMember "one" (list2Set ["1", "2", "3", "4"]);
print ("\nQuestion 5: " ^ Bool.toString(quest5) ^ "\n");

(* Question 7 *)
val quest7 = list2Set ["it", "was", "the", "best", "of", "times,", "it", "was", "the", "worst", "of", "times"];
print "\nQuestion 7: ";
print_str quest7;
print "\n";

(* Question 9 *)
print "\nQuestion 9: ";
print_str (union (list2Set ["green", "eggs", "and"]) (list2Set ["ham"]));

(* Question 10 *)
print "\nQuestion 10: ";
print_str (intersect (list2Set ["stewed", "tomatoes", "and", "macaroni"]) (list2Set ["macaroni", "and", "cheese"]));
