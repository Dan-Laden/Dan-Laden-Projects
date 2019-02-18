val x = 50 + 7;
val y = 40;
val z = x - y;
val z = [true, true];
val z = [(true, false), (true, true)];

datatype 'a Set = Empty | Set of 'a * 'a Set;

val thing = Set(5, Empty);
val thing2 = Set("cow", Empty);
val thing = Set(6, thing);

val kiki = "Bob"
val greg = "bob"

if ''kiki = ''greg then print ("True")
else print ("False")

val thing3 = Set(5, Empty);
fun isMember value Empty = false
             |
             isMember value (Set(x, xs)) =
             if x = value then true
             else if xs = Empty then false
             else isMember value xs;

val doug = isMember 10 thing;

fun list2Set [] = Empty
                    |
                    list2Set (x::xs) =
                    let
                      val left = list2Set xs
                    in
                      if not(isMember x left) then Set(x, left) else left
                    end;

val bob = list2Set [1, 2, 3, 4, 5];



fun set2List Empty = []
        |
    set2List (Set(x, xs)) = x::set2List xs;

val ted = set2List thing


fun union set1 Empty = set1
          |
    union set1 set3 =
          list2Set((set2List set1)@(set2List set3));

val chris = Set(2, Empty)
val john = Set(4, Empty)

val chrohn = union chris john

fun intersect set1 Empty = Empty
           |
    intersect set1 (Set set3) =
    if(isMember (#1 set3) set1) then Set((#1 set3), intersect set1 (#2 set3)) else intersect set1 (#2 set3);

val dan = Set(2, Set(4, Empty))
val bill = Set(2, Set(3, Empty))

val danill = intersect dan bill
