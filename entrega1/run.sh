#!/bin/bash

rm -f *.fst *.pdf

# Compila e gera a versão gráfica do transdutor que traduz SET -> 09
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  mmm2mm.txt | fstarcsort > mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait mmm2mm.fst | dot -Tpdf  > mmm2mm.pdf


# Compila e gera a versão gráfica do transdutor que processa a barra
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  slash.txt | fstarcsort > slash.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait slash.fst | dot -Tpdf  > slash.pdf
