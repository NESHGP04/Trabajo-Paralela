# Makefile para los ejercicios de OpenMP
#
# Usa el clang de Apple + libomp de Homebrew, porque el gcc de Homebrew
# (gcc-16) no es compatible con los headers del SDK actual de macOS.
#
# Uso:
#   make            -> compila todos los ejercicios (ejercicioN.c -> ejercicioN)
#   make ejercicio1  -> compila solo ejercicio1
#   make run-ejercicio1 -> compila (si hace falta) y corre ejercicio1
#   make clean      -> borra los binarios compilados

CC := clang

# Prefijo de libomp: intenta detectarlo con brew (arm64 nativo primero,
# luego el brew que esté en el PATH); si no hay brew, usa la ruta típica
# de Apple Silicon como último recurso.
LIBOMP_PREFIX := $(shell /opt/homebrew/bin/brew --prefix libomp 2>/dev/null || brew --prefix libomp 2>/dev/null || echo /opt/homebrew/opt/libomp)

CFLAGS  := -Wall -O2 -Xpreprocessor -fopenmp -I$(LIBOMP_PREFIX)/include
LDFLAGS := -L$(LIBOMP_PREFIX)/lib -lomp

SRCS    := $(wildcard ejercicio*.c)
TARGETS := $(SRCS:.c=)

.PHONY: all clean $(addprefix run-,$(TARGETS))

all: $(TARGETS)

# Regla de patrón: cualquier ejercicioN se compila desde ejercicioN.c
ejercicio%: ejercicio%.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

run-%: %
	./$*

clean:
	rm -f $(TARGETS)
