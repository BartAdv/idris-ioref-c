#include "idris_rts.h"

VAL idris_newIORef();

VAL idris_readIORef(VAL ref);

void idris_writeIORef(VAL ref, VAL v);
