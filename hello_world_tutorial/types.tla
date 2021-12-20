---- MODULE types ----

EXTENDS Sequences \* Import Sequences module from the standard library

VARIABLES
    \* @type: Set(Str);
    alices_outbox,
    
    \* @type: Set(Str);
    network,
    
    \* @type: Str;
    bobs_mood,
    
    \* @type: Seq(Str);
    bobs_inbox

Init ==
    /\ alices_outbox = {} \* Alice's memory of what she sent is the empty set
    /\ network = {} \* AND so is the network
    /\ bobs_mood = "neutral" \* AND Bob's mood is neutral
    /\ bobs_inbox = <<>> \* AND Bob'b inbox is an empty Sequence (list)

\* @type: (Str) => Bool;
AliceSend(m) == 
    /\ m \notin alices_outbox
    /\ alices_outbox' = alices_outbox \union {m}
    /\ network' = network \union {m}
    /\ UNCHANGED <<bobs_mood, bobs_inbox>>

NetworkLoss == 
    /\ \E e \in network: network' = network \ {e}
    /\ UNCHANGED <<bobs_mood, bobs_inbox, alices_outbox>>

NetworkDeliver == 
    /\ \E e \in network:
        /\ bobs_inbox' = bobs_inbox \o <<e>> 
        /\ network' = network \ {e}
    /\ UNCHANGED <<bobs_mood, alices_outbox>>

(* BobCheckInbox == 
    /\ bobs_mood' = IF bobs_inbox = <<"hello", "world">> THEN "happy" ELSE "neutral"
    /\ UNCHANGED <<network, bobs_inbox, alices_outbox>>
 *)

BobCheckInbox ==
    /\ (
        \/(
            /\ bobs_mood' = "happy" 
            /\ bobs_inbox = <<"hello", "world">>
            ) 
        \/ (
            /\ bobs_mood' = "neutral" 
            /\ bobs_inbox /= <<"hello", "world">>
            \*/\ bobs_inbox # <<"hello", "world">>
            )
        )
    /\ UNCHANGED <<network, bobs_inbox, alices_outbox>>




Next ==
    \/ AliceSend("hello")
    \/ AliceSend("world")
    \/ NetworkLoss
    \/ NetworkDeliver
    \/ BobCheckInbox

NothingUnexpectedInNetwork == \A e \in network: e \in alices_outbox

NotBobIsHappy == 
    LET BobIsHappy == bobs_mood = "happy"
    IN ~BobIsHappy

====