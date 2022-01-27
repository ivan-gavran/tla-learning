---- MODULE base ----

EXTENDS Integers, extensionA, extensionB
VARIABLES 
    \* @type: Int;
    x

CONSTANT 
    \* @type: Str;
    extension_type


Check(a) ==
    IF extension_type = "A"
    THEN CheckA(a)
    ELSE CheckB(a)
    




Next ==
    x' = IF Check(x) THEN x + 1 ELSE x

Init ==
    x = 2

GOAL == 
    x < 6
====