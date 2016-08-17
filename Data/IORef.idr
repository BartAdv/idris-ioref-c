module Data.IORef

%include C "IORef.h"
%link C "IORef.o"

%access private
%default covering

data Prim_IORef = Prim_MkIORef

prim_newIORef : IO (Prim_IORef)
prim_newIORef = do
  MkRaw ref <- foreign FFI_C "idris_newIORef" (IO (Raw Prim_IORef))
  pure ref

prim_readIORef : Prim_IORef -> IO a
prim_readIORef {a} ref = do
  MkRaw v <- foreign FFI_C "idris_readIORef" (Raw Prim_IORef -> IO (Raw a)) (MkRaw ref)
  pure v

prim_writeIORef : Prim_IORef -> a -> IO ()
prim_writeIORef {a} ref v =
  foreign FFI_C "idris_writeIORef" (Raw Prim_IORef -> Raw a -> IO ()) (MkRaw ref) (MkRaw v)

%access export

data IORef : Type -> Type where
  MkIORef : Prim_IORef -> IORef a

newIORef : a -> IO (IORef a)
newIORef v = do
  ref <- prim_newIORef
  prim_writeIORef ref v
  pure $ MkIORef ref

readIORef : IORef a -> IO a
readIORef (MkIORef ref) =
  prim_readIORef ref

writeIORef : IORef a -> a -> IO ()
writeIORef (MkIORef ref) v =
  prim_writeIORef ref v

modifyIORef : IORef a -> (a -> a) -> IO ()
modifyIORef (MkIORef ref) f = do
  v <- prim_readIORef ref
  prim_writeIORef ref (f v)
