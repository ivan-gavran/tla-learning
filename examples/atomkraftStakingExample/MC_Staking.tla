--------------------------- MODULE MC_Staking ---------------------------------
\* an instance for model checking Staking.tla with Apalache
EXTENDS Sequences, Staking_typedefs

\* Use the set of three addresses.
UserAddrs == { "user2", "user3", "validator" }

VARIABLES
    \* Coin balance for every Cosmos account.
    \*
    \* @type: BALANCE;
    balanceOf,
    \* Balance of unbonded coins that cannot be used during the bonding period.
    \*
    \* @type: BALANCE;
    unbonded,
    \* Coins that are delegated to Validator.
    \*
    \* @type: BALANCE;
    delegated

\* Variables that model transactions, not the state machine.
VARIABLES    
    \* The last executed transaction.
    \*
    \* @type: TX;
    lastTx,
    \* A serial number to assign unique ids to transactions
    \* @type: Int;
    nextTxId,
    \* Whether at least one transaction has failed
    \* @type: Bool;
    failed

\* instantiate the spec
INSTANCE Staking

\* invariants to check and break the system

MAX_COSMOS_NUM == 2^(256-60)

\* a single-unit coin, 18 digits after the point
PRECISION == 10^18

\* a counterexample to this invariant will produce ten transactions,
\* which are all transfers
NoTenTransfers ==
    nextTxId < 10 \/ failed

\* a counterexample to this invariant produces a transaction
\* that carries a large amount
NoLargeNumbers ==
    lastTx.value < MAX_COSMOS_NUM

\* No delegation. Use it to produce a counterexample.
NoDelegate ==
    \/ lastTx.tag /= "delegate"
    \/ lastTx.value = 0

\* No unbonding. Use it to produce a counterexample.
NoUnbond ==
    \/ lastTx.tag /= "unbond"
    \/ lastTx.value = 0

\* No unbonding. Use it to produce a counterexample.
NoUnbondLarge ==
    LET Example ==
        /\ lastTx.tag = "unbond"
        /\ lastTx.sender = "user2"
        /\ lastTx.value > 100000 * PRECISION
    IN
    ~Example

\* No delegate and then transfer more.
NoDelegateAndTransfer ==
    LET Example ==
        /\ lastTx.tag = "delegate"
        /\ lastTx.sender = "validator"
        /\ lastTx.value = 10^9
        /\ ~lastTx.fail
        /\ lastTx'.tag = "transfer-cosmos"
        /\ lastTx'.sender = "validator"
        /\ lastTx'.value = 10^6 + balanceOf["validator"]
    IN
    ~Example

\* No delegate, unbond and then transfer more.
\* @type: Seq(STATE) => Bool;
NoUnbondAndTransferPickSteps(trace) ==
    \* trace[1] is the initial state
    \E i, j, k \in 2..5: 
        /\ i < j
        /\ j < k
        /\ 
            LET state1 == trace[i] IN
            LET state2 == trace[j] IN
            LET state3 == trace[k] IN
            LET Example ==            
                /\ Len(trace) > 4
                /\ state1.lastTx.tag = "delegate"
                /\ state1.lastTx.value = 10^12
                /\ state1.lastTx.sender = "user2"
                /\ state2.lastTx.tag = "unbond"
                /\ state2.lastTx.sender = "user2"
                /\ state2.lastTx.value = 1
                /\ ~state2.failed
                /\ state3.lastTx.tag = "transfer-cosmos"
                /\ state3.lastTx.sender = "user2"
                /\ state3.lastTx.value = 10^6 + state2.balanceOf["user2"]
            IN
            ~Example


\* @type: Seq(STATE) => Bool;
NoUnbondAndTransferPickStepsFake(trace) ==
    \* trace[1] is the initial state
    \E i, j, k \in 2..5: 
        /\ i = 2
        /\ j = 3
        /\ k = 4
        /\ 
            LET state1 == trace[i] IN
            LET state2 == trace[j] IN
            LET state3 == trace[k] IN
            LET Example ==            
                /\ Len(trace) > 4
                /\ state1.lastTx.tag = "delegate"
                /\ state1.lastTx.value = 10^12
                /\ state1.lastTx.sender = "user2"
                /\ state2.lastTx.tag = "unbond"
                /\ state2.lastTx.sender = "user2"
                /\ state2.lastTx.value = 1
                /\ ~state2.failed
                /\ state3.lastTx.tag = "transfer-cosmos"
                /\ state3.lastTx.sender = "user2"
                /\ state3.lastTx.value = 10^6 + state2.balanceOf["user2"]
            IN
            ~Example



\* @type: Seq(STATE) => Bool;
NoUnbondAndTransfer(trace) ==
    \* trace[1] is the initial state    
    LET state1 == trace[2] IN
    LET state2 == trace[3] IN
    LET state3 == trace[4] IN
    LET Example ==            
        /\ Len(trace) > 4
        /\ state1.lastTx.tag = "delegate"
        /\ state1.lastTx.value = 10^12
        /\ state1.lastTx.sender = "user2"
        /\ state2.lastTx.tag = "unbond"
        /\ state2.lastTx.sender = "user2"
        /\ state2.lastTx.value = 1
        /\ ~state2.failed
        /\ state3.lastTx.tag = "transfer-cosmos"
        /\ state3.lastTx.sender = "user2"
        /\ state3.lastTx.value = 10^6 + state2.balanceOf["user2"]
    IN
    ~Example


\* a transaction view that allows us to produce a variety of examples
TxView ==
    <<lastTx.tag, lastTx.sender, lastTx.toAddr,
      lastTx.value > 0, lastTx.value > 1000,
      lastTx.value > PRECISION, lastTx.value >= (MAX_COSMOS_NUM - 1)>>

===============================================================================
