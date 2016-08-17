module Main

import Data.IORef

main : IO ()
main = do
  ref <- newIORef 24
  printLn !(readIORef ref)
  writeIORef ref 25
  printLn !(readIORef ref)
  modifyIORef ref (+ 1)
  printLn !(readIORef ref)
