#!/bin/bash

rm -f *.fst *.pdf

# Compila e gera a versão gráfica do transdutor que traduz SET -> 09
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  mmm2mm.txt | fstarcsort > mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait mmm2mm.fst | dot -Tpdf  > mmm2mm.pdf


# Compila e gera a versão gráfica do transdutor que processa a barra
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  slash.txt | fstarcsort > slash.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait slash.fst | dot -Tpdf  > slash.pdf

# Compila e gera a versão gráfica do transdutor que processa os dias 01 ou 1
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  days.txt | fstarcsort > days.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait days.fst | dot -Tpdf  > days.pdf

# Compila e gera a versão gráfica do transdutor que processa os anos de 2001...2099
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  years.txt | fstarcsort > years.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait years.fst | dot -Tpdf  > years.pdf

# Concatenate transducers to create a transducer capable of reading 1/SET/2001 1/09/2001

fstconcat days.fst slash.fst  > misto2numerico1.fst
fstproject --project_output misto2numerico1.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico1.fst | dot -Tpdf  > misto2numerico1.pdf

fstconcat misto2numerico1.fst mmm2mm.fst  > misto2numerico2.fst
fstproject --project_output misto2numerico2.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico2.fst | dot -Tpdf  > misto2numerico2.pdf

fstconcat misto2numerico2.fst slash.fst  > misto2numerico3.fst
fstproject --project_output misto2numerico3.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico3.fst | dot -Tpdf  > misto2numerico3.pdf

fstconcat misto2numerico3.fst years.fst > misto2numerico.fst
fstproject --project_output misto2numerico.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico.fst | dot -Tpdf  > misto2numerico.pdf
