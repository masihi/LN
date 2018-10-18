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
#fstproject --project_output misto2numerico1.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico1.fst | dot -Tpdf  > misto2numerico1.pdf

fstconcat misto2numerico1.fst mmm2mm.fst  > misto2numerico2.fst
#fstproject --project_output misto2numerico2.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico2.fst | dot -Tpdf  > misto2numerico2.pdf

fstconcat misto2numerico2.fst slash.fst  > misto2numerico3.fst
#fstproject --project_output misto2numerico3.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico3.fst | dot -Tpdf  > misto2numerico3.pdf

fstconcat misto2numerico3.fst years.fst > misto2numerico.fst
#fstproject --project_output misto2numerico.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2numerico.fst | dot -Tpdf  > misto2numerico.pdf


# Compila e gera a versão gráfica do transdutor que traduz os meses de ingles para portugues SEP -> SET
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  enmmmpor.txt | fstarcsort > enmmmpor.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait enmmmpor.fst | dot -Tpdf  > enmmmpor.pdf

#Concatena transdutores pare criar um transdutor capaz de traduzir converter uma data no formato condensado misto, de inglês
#para português: Exemplo: "20/SEP/2018" é convertida em "20/SET/2018";

fstconcat misto2numerico1.fst enmmmpor.fst  > en2pt1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait en2pt1.fst | dot -Tpdf  > en2pt1.pdf

fstconcat en2pt1.fst slash.fst  > en2pt2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait en2pt2.fst | dot -Tpdf  > en2pt2.pdf

fstconcat en2pt2.fst years.fst  > en2pt.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait en2pt.fst | dot -Tpdf  > en2pt.pdf

# Traduz de pt para en
fstinvert en2pt.fst pt2en.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait pt2en.fst | dot -Tpdf  > pt2en.pdf

# traduz dia para texto
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  dia.txt | fstarcsort > dia.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait dia.fst | dot -Tpdf  > dia.pdf

# traduz mes para texto
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  mes.txt | fstarcsort > mes.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait mes.fst | dot -Tpdf  > mes.pdf

# traduz ano para texto
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  ano.txt | fstarcsort > ano.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait ano.fst | dot -Tpdf  > ano.pdf
