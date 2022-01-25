---- MODULE extensionA ----

EXTENDS Integers

VARIABLES 
    \* @type: Int;
    x

CONSTANTS 
    IsXGoodExtended(_)


INSTANCE base WITH IsXGood <- IsXGoodExtended


IsXGoodExtendedImpl(a) == 
    a = 2


====