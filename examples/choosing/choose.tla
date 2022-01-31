---- MODULE choose ----
EXTENDS TLC

VARIABLE 
    \* @type: Int;
    x

GetNumber ==
    CHOOSE n \in {1,2}: TRUE

Init ==
    x = 0

Next ==
    x' = GetNumber

XNotOne ==
    x /= 1

XNotTwo ==
    x /= 2
====