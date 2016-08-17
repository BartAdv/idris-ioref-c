IORef.o : IORef.h IORef.c
	$(CC) `idris --include` -c IORef.c -o IORef.o

.PHONY: clean
clean :
	-rm IORef.o
