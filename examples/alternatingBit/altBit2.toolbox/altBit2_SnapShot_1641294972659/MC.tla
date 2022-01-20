---- MODULE MC ----
EXTENDS altBit2, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16412949696009000 == 
(1..3) \X {"a", "b"}
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16412949696009000>>)
----

=============================================================================
\* Modification History
\* Created Tue Jan 04 12:16:09 CET 2022 by ivan
