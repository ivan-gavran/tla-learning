---------------------------- MODULE counterexample ----------------------------

EXTENDS jugs

(* Constant initialization state *)
ConstInit == TRUE

(* Initial state *)
State0 == five_jug = 0 /\ three_jug = 0

(* Transition 3 to State1 *)
State1 == five_jug = 0 /\ three_jug = 3

(* Transition 4 to State2 *)
State2 == five_jug = 3 /\ three_jug = 0

(* Transition 3 to State3 *)
State3 == five_jug = 3 /\ three_jug = 3

(* Transition 5 to State4 *)
State4 == five_jug = 5 /\ three_jug = 1

(* Transition 0 to State5 *)
State5 == five_jug = 0 /\ three_jug = 1

(* Transition 4 to State6 *)
State6 == five_jug = 1 /\ three_jug = 0

(* Transition 3 to State7 *)
State7 == five_jug = 1 /\ three_jug = 3

(* Transition 4 to State8 *)
State8 == five_jug = 4 /\ three_jug = 0

(* The following formula holds true in the last state and violates the invariant *)
InvariantViolation == five_jug = 4

================================================================================
(* Created by Apalache on Fri Dec 10 22:10:47 CET 2021 *)
(* https://github.com/informalsystems/apalache *)
