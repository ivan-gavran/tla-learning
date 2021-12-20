---------------------------- MODULE counterexample ----------------------------

EXTENDS multiple_traces

(* Constant initialization state *)
ConstInit == TRUE

(* Initial state *)
State0 == auxiliary_str = "foo" /\ important_int = 0

(* Transition 1 to State1 *)
State1 == auxiliary_str = "foo" /\ important_int = 2

(* Transition 1 to State2 *)
State2 == auxiliary_str = "foo" /\ important_int = 6

(* The following formula holds true in the last state and violates the invariant *)
InvariantViolation ==
  LET Behavior_si_2_si__skolem == important_int = 6 IN Behavior_si_2_si__skolem

================================================================================
(* Created by Apalache on Fri Dec 03 15:55:02 CET 2021 *)
(* https://github.com/informalsystems/apalache *)
