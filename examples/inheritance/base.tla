---- MODULE base ----

EXTENDS Integers
VARIABLES 
    \* @type: Int;
    x


\* @type: (Int) => Bool;
FF(a) == TRUE

\* @type: ( Int, (Int) => Bool ) => Bool;
Check(a, func(_)) == func(a)



Next ==
    x' = IF Check(x, FF) THEN x + 1 ELSE x

Init ==
    x = 2

GOAL == 
    x < 3
====