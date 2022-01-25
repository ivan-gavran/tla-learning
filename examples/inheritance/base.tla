---- MODULE base ----

EXTENDS Integers

VARIABLES 
    \* @type: Int;
    x

CONSTANT     
    IsXGood(_)

Update ==
    x' = 
    IF x < 4
    THEN x+1
    ELSE x


Init ==
    x = 2

Next == Update

GOAL == IsXGood(x)    

====