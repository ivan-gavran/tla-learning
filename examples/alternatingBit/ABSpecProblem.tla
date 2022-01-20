---- MODULE ABSpecProblem ----
 
EXTENDS Integers

CONSTANT Data  \* The set of all possible data values.

VARIABLES 
          AVar,   \* The last <<value, bit>> pair A decided to send.
          BVar    \* The last <<value, bit>> pair B received.
          
(***************************************************************************)
(* Type correctness means that AVar and BVar are tuples <<d, i>> where     *)
(* d \in Data and i \in {0, 1}.                                            *)
(***************************************************************************)
TypeOK == /\ AVar \in Data \X {0,1}
          /\ BVar \in Data \X {0,1}

(***************************************************************************)
(* It's useful to define vars to be the tuple of all variables, for        *)
(* example so we can write [Next]_vars instead of [Next]_<< ...  >>        *)
(***************************************************************************)
vars == << AVar, BVar >>


(***************************************************************************)
(* Initially AVar can equal <<d, 1>> for any Data value d, and BVar equals *)
(* AVar.                                                                   *)
(***************************************************************************)
Init == /\ AVar \in Data \X {1} 
        /\ BVar = AVar

(***************************************************************************)
(* When AVar = BVar, the sender can "send" an arbitrary data d item by     *)
(* setting AVar[1] to d and complementing AVar[2].  It then waits until    *)
(* the receiver "receives" the message by setting BVar to AVar before it   *)
(* can send its next message.  Sending is described by action A and        *)
(* receiving by action B.                                                  *)
(***************************************************************************)
A == /\ AVar = BVar
     /\ \E d \in Data: AVar' = <<d, 1 - AVar[2]>>
     /\ BVar' = BVar

B == /\ AVar # BVar
     /\ BVar' = AVar
     /\ AVar' = AVar

Next == A \/ B


 Alter == \A v \in Data \X {0,1} : (AVar = v) ~> (BVar = v)

FairSpec == Init /\ [][Next]_vars /\ WF_vars(Next)

Inv == (AVar[2] = BVar[2]) => (AVar = BVar)

====
