---------------------------- MODULE counterexample ----------------------------

EXTENDS multiple_traces

(* Constant initialization state *)
ConstInit == TRUE

(* Initial state *)
State0 == auxiliary_str = "foo" /\ important_int = 0

(* Transition 1 to State1 *)
State1 == auxiliary_str = "foo" /\ important_int = 1

(* Transition 0 to State2 *)
State2 == auxiliary_str = "foo" /\ important_int = 1

(* Transition 1 to State3 *)
State3 == auxiliary_str = "foo" /\ important_int = 3

(* Transition 1 to State4 *)
State4 == auxiliary_str = "foo" /\ important_int = 6

(* The following formula holds true in the last state and violates the invariant *)
InvariantViolation ==
  LET Call_trace ==
    <<
      [important_int |-> $C$7, auxiliary_str |-> $C$6], [important_int |-> $C$28,
        auxiliary_str |-> $C$29], [important_int |-> $C$41,
        auxiliary_str |-> $C$42], [important_int |-> $C$54,
        auxiliary_str |-> $C$55], [important_int |-> $C$67,
        auxiliary_str |-> $C$68]
    >>
  IN
  LET last_state_si_2 == (Call_trace)[(Len((Call_trace)))] IN
  LET Behavior_si_2_si__skolem ==
    (last_state_si_2)["important_int"] = 6
      /\ (\A i$2 \in DOMAIN Call_trace:
        (i$2 = 1 \/ i$2 = Len((Call_trace)))
          \/ (Call_trace)[i$2]["important_int"] % 2 = 1)
  IN
  Behavior_si_2_si__skolem

================================================================================
(* Created by Apalache on Fri Dec 03 16:03:14 CET 2021 *)
(* https://github.com/informalsystems/apalache *)
