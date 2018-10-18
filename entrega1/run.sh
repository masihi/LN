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

# transdutor extra para de barra se ler de
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  barra.txt | fstarcsort > barra.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait barra.fst | dot -Tpdf  > barra.pdf

# trasndutor numerico2texto
fstconcat dia.fst barra.fst  > numerico2texto1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait numerico2texto1.fst | dot -Tpdf  > numerico2texto1.pdf

fstconcat numerico2texto1.fst mes.fst  > numerico2texto2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait numerico2texto2.fst | dot -Tpdf  > numerico2texto2.pdf

fstconcat numerico2texto2.fst barra.fst  > numerico2texto3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait numerico2texto3.fst | dot -Tpdf  > numerico2texto3.pdf

fstconcat numerico2texto3.fst ano.fst  > numerico2texto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait numerico2texto.fst | dot -Tpdf  > numerico2texto.pdf

# transdutor misto2texto

fstconcat dia.fst barra.fst  > misto2texto1.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2texto1.fst | dot -Tpdf  > misto2texto1.pdf

# traduzir SET _setembro
fstcompose mmm2mm.fst mes.fst > closuremes.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait closuremes.fst | dot -Tpdf  > closuremes.pdf

fstconcat misto2texto1.fst closuremes.fst  > misto2texto2.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2texto2.fst | dot -Tpdf  > misto2texto2.pdf

fstconcat misto2texto2.fst barra.fst  > misto2texto3.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2texto3.fst | dot -Tpdf  > misto2texto3.pdf

fstconcat misto2texto2.fst ano.fst  > misto2texto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait misto2texto.fst | dot -Tpdf  > misto2texto.pdf

# transdutor data2texto
fstunion numerico2texto.fst misto2texto.fst > data2texto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait data2texto.fst | dot -Tpdf  > data2texto.pdf

# testar os transdutores
#fstproject --project_output misto2numerico.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt

# compilar testes

fstcompile --isymbols=syms.txt --osymbols=syms.txt  test/77917_misto.txt | fstarcsort > test/77917_misto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_misto.fst | dot -Tpdf > test/77917_misto.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  test/78042_misto.txt | fstarcsort > test/78042_misto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_misto.fst | dot -Tpdf > test/78042_misto.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  test/77917_pt.txt | fstarcsort > test/77917_pt.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_pt.fst | dot -Tpdf > test/77917_pt.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  test/78042_pt.txt | fstarcsort > test/78042_pt.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_pt.fst | dot -Tpdf > test/78042_pt.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  test/77917_numerico.txt | fstarcsort > test/77917_numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_numerico.fst | dot -Tpdf > test/77917_numerico.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  test/78042_numerico.txt | fstarcsort > test/78042_numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_numerico.fst | dot -Tpdf > test/78042_numerico.pdf

# Test

fstcompose test/77917_misto.fst misto2numerico.fst > test/77917_misto2numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_misto2numerico.fst | dot -Tpdf > test/77917_misto2numerico.pdf

fstcompose test/78042_misto.fst misto2numerico.fst > test/78042_misto2numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_misto2numerico.fst | dot -Tpdf > test/78042_misto2numerico.pdf

fstcompose test/77917_pt.fst pt2en.fst > test/77917_pt2en.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_pt2en.fst | dot -Tpdf > test/77917_pt2en.pdf

fstcompose test/78042_pt.fst pt2en.fst > test/78042_pt2en.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_pt2en.fst | dot -Tpdf > test/78042_pt2en.pdf

fstcompose test/77917_numerico.fst numerico2texto.fst > test/77917_numerico2texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_numerico2texto.fst | dot -Tpdf > test/77917_numerico2texto.pdf

fstcompose test/78042_numerico.fst numerico2texto.fst > test/78042_numerico2texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_numerico2texto.fst | dot -Tpdf > test/78042_numerico2texto.pdf

fstcompose test/77917_misto.fst misto2texto.fst > test/77917_misto2texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_misto2texto.fst | dot -Tpdf > test/77917_misto2texto.pdf

fstcompose test/78042_misto.fst misto2texto.fst > test/78042_misto2texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_misto2texto.fst | dot -Tpdf > test/78042_misto2texto.pdf

fstcompose test/77917_misto.fst data2texto.fst > test/77917_data2texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/77917_data2texto.fst | dot -Tpdf > test/77917_data2texto.pdf

fstcompose test/78042_numerico.fst data2texto.fst > test/78042_data2texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  test/78042_data2texto.fst | dot -Tpdf > test/78042_data2texto.pdf
