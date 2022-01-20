---- MODULE MC ----
EXTENDS altBit2, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16412947993745000 == 
Remove(2, <<1,2,3,4,5>>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16412947993745000>>)
----

=============================================================================
\* Modification History
\* Created Tue Jan 04 12:13:19 CET 2022 by ivan
