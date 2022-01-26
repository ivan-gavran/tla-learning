---- MODULE extensionA ----

EXTENDS Integers

VARIABLES 
    \* @type: Int;
    x


\* @type: (Int) => Bool;
CheckOrig(a) ==
    a < 4

GOAL == 
    x < 5

BASE == INSTANCE base
Next ==
    x' = IF BASE!Check(x, CheckOrig) THEN x + 1 ELSE x
Init == BASE!Init

====