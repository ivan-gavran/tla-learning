---------------------------- MODULE counterexample ----------------------------

EXTENDS types

(* Constant initialization state *)
ConstInit == TRUE

(* Initial state *)
State0 ==
  alices_outbox = {}
    /\ bobs_inbox = <<>>
    /\ bobs_mood = "neutral"
    /\ network = {}

(* Transition 0 to State1 *)
State1 ==
  alices_outbox = {"hello"}
    /\ bobs_inbox = <<>>
    /\ bobs_mood = "neutral"
    /\ network = {"hello"}

(* Transition 3 to State2 *)
State2 ==
  alices_outbox = {"hello"}
    /\ bobs_inbox = <<"hello">>
    /\ bobs_mood = "neutral"
    /\ network = {}

(* Transition 1 to State3 *)
State3 ==
  alices_outbox = { "hello", "world" }
    /\ bobs_inbox = <<"hello">>
    /\ bobs_mood = "neutral"
    /\ network = {"world"}

(* Transition 3 to State4 *)
State4 ==
  alices_outbox = { "hello", "world" }
    /\ bobs_inbox = <<"hello", "world">>
    /\ bobs_mood = "neutral"
    /\ network = {}

(* Transition 4 to State5 *)
State5 ==
  alices_outbox = { "hello", "world" }
    /\ bobs_inbox = <<"hello", "world">>
    /\ bobs_mood = "happy"
    /\ network = {}

(* The following formula holds true in the last state and violates the invariant *)
InvariantViolation ==
  LET BobIsHappy_si_2_si__skolem == bobs_mood = "happy" IN
  BobIsHappy_si_2_si__skolem

================================================================================
(* Created by Apalache on Fri Dec 03 12:15:55 CET 2021 *)
(* https://github.com/informalsystems/apalache *)
