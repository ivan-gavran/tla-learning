---- MODULE jugs ----

EXTENDS Integers

VARIABLES 
    \* @type: Int;
    three_jug,

    \* @type: Int;
    five_jug

Init ==
    /\ three_jug = 0
    /\ five_jug = 0

Empty_three_jug ==
    /\ three_jug' = 0
    /\ UNCHANGED <<five_jug>>

Fill_three_jug ==
    /\ three_jug' = 3
    /\ UNCHANGED <<five_jug>>

Empty_five_jug ==
    /\ five_jug' = 0
    /\ UNCHANGED <<three_jug>>

Fill_five_jug ==
    /\ five_jug' = 0
    /\ UNCHANGED <<three_jug>>

Five_to_three ==
    \/ 
        /\ five_jug + three_jug <= 3
        /\ three_jug' = five_jug + three_jug 
        /\ five_jug' = 0
    \/
        /\ five_jug + three_jug > 3
        /\ three_jug' = 3
        /\ five_jug' = five_jug - (3 - three_jug)

Three_to_five ==
    \/
        /\ five_jug + three_jug <= 5
        /\ five_jug' = five_jug + three_jug
        /\ three_jug' = 0
    \/
        /\ five_jug + three_jug > 5
        /\ five_jug' = 5    
        /\ three_jug' = three_jug - (5 - five_jug)

Next == 
    \/ Empty_five_jug
    \/ Empty_three_jug
    \/ Fill_five_jug
    \/ Fill_three_jug
    \/ Three_to_five
    \/ Five_to_three

NoFourLiters ==
    five_jug /= 4

====