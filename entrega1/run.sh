#!/bin/bash

rm -f *.fst *.pdf

# Compila e gera a versão gráfica do transdutor que traduz SET -> 09
#fstcompile --isymbols=letras.sym --osymbols=numeros.sym  mmm2mm.txt | fstarcsort > mmm2mm.fst
#fstdraw    --isymbols=letras.sym --osymbols=numeros.sym --portrait mmm2mm.fst | dot -Tpdf  > mmm2mm.pdf

# Compila e gera a versão gráfica do transdutor que traduz SET -> 09
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  mmm2mm.txt | fstarcsort > mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait mmm2mm.fst | dot -Tpdf  > mmm2mm.pdf
