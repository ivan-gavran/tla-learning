------------------------------ MODULE altBit2 ------------------------------
EXTENDS Integers, Sequences

Remove(i, seq) == 
  [j \in 1..(Len(seq)-1) |-> IF j < i THEN seq[j] 
                                      ELSE seq[j+1]]


=============================================================================
\* Modification History
\* Last modified Tue Jan 04 12:10:52 CET 2022 by ivan
\* Created Tue Jan 04 12:09:53 CET 2022 by ivan
