#include "IORef.h"

VAL idris_newIORef() {
  VAL ref;
  allocCon(ref, 0, 0, 1, 0);
  return ref;
}

VAL idris_readIORef(VAL ref) {
  return GETARG(ref, 0);
}

void idris_writeIORef(VAL ref, VAL v) {
  SETARG(ref, 0, v);
}
