## Software para cálculo dos parâmetros de linhas de transmissão | Gabriel, Matheus e Vinícius | 06/12/23

clc
clear all
close all

##Array com o nome dos cabos
names = {"Waxwing";"Partridge";"Ostrich";"Merlin";"Linnet";"Oriole";
"Chickadee";"Pelican";"Flicker";"Hawk";"Osprey";"Parakeet";
"Dove";"Rook";"Grosbeak";"Drake";"Rail";"Cardinal";"Ortolan";
"Bluejay";"Finch";"Bittern";"Pheasant";"Bobolink";"Plover";
"Lapwing";"Falcon";"Bluebird"}

##Array com os parâmetros dos cabos
data = {
266.8	2	0.77343	0.603504	0.211942	0.216781	0.238098	;	#"Waxwing"
266.8	2	0.81534	0.661416	0.209974	0.214543	0.235674	;	#"Partridge"
300	2	0.8636	0.697992	0.18668	0.190802	0.209571	;	#"Ostrich"
336.4	2	0.86868	0.676656	0.167979	0.17197	0.188751	;	#"Merlin"
336.4	2	0.91567	0.740664	0.166339	0.170106	0.186824	;	#"Linnet"
336.4	2	0.94107	0.77724	0.165354	0.168987	0.185643	;	#"Oriole"
397.5	2	0.94361	0.734568	0.14206	0.145556	0.159851	;	#"Chickadee"
477	2	1.03378	0.804672	0.118438	0.121628	0.133499	;	#"Pelican"
477	2	1.07442	0.865632	0.117782	0.120758	0.132629	;	#"Flicker"
477	2	1.08966	0.880872	0.117126	0.120012	0.131759	;	#"Hawk"
556.5	2	1.11633	0.865632	0.101378	0.104351	0.114543	;	#"Osprey"
556.5	2	1.16078	0.932688	0.10105	0.103729	0.11386	;	#"Parakeet"
556.5	2	1.17729	0.957072	0.100722	0.103356	0.113487	;	#"Dove"
636	2	1.24079	0.996696	0.088255	0.090802	0.099627	;	#"Rook"
636	2	1.2573	1.02108	0.087927	0.090367	0.099192	;	#"Grosbeak"
795	2	1.40716	1.136904	0.070538	0.07284	0.079801	;	#"Drake"
954	3	1.47955	1.176528	0.059383	0.061964	0.067868	;	#"Rail"
954	3	1.51892	1.225296	0.059055	0.061405	0.067247	;	#"Cardinal"
1033.5	3	1.54051	1.225296	0.05479	0.057427	0.062834	;	#"Ortolan"
1113	3	1.59893	1.26492	0.050853	0.053511	0.058484	;	#"Bluejay"
1113	3	1.64211	1.328928	0.050853	0.053201	0.058235	;	#"Finch"
1272	3	1.70815	1.353312	0.044619	0.047359	0.051709	;	#"Bittern"
1272	3	1.75514	1.420368	0.044291	0.046675	0.051025	;	#"Pheasant"
1431	3	1.81229	1.43256	0.039698	0.042511	0.046364	;	#"Bobolink"
1431	3	1.86055	1.505712	0.03937	0.041827	0.045681	;	#"Plover"
1590	3	1.90754	1.517904	0.035761	0.03872	0.042138	;	#"Lapwing"
1590	3	1.96215	1.594104	0.035433	0.038036	0.041454	;	#"Falcon"
2156	4	2.23774	1.786128	0.026247	0.029584	0.032007		#"Bluebird"
}

##*****************************************************************************************************************************************
##Janela para entrada dos parâmetros
myinp = inputdlg({'Número de condutores:','Distância entre condutores (cm):','Distância entre fases (m):','Distância em relação ao solo (m):'},'Parâmetros da Linha',1,{4,40,12,30})

##Atribuição dos parâmtros
n_condutores = str2double([myinp{1,1}]);
dist_condutores = str2double([myinp{2,1}])/100;
dist_fases = str2double([myinp{3,1}]);
dist_solo = str2double([myinp{4,1}]);

##*****************************************************************************************************************************************
##Janela com a lista dos condutores
[sel, ok] = listdlg ("ListString", {names{1}, names{2}, names{3}, names{4}, names{5}, names{6}, names{7}, names{8}, names{9}, names{10}, names{11}, names{12}, names{13}, names{14}, names{15}, names{16}, names{17}, names{18}, names{19}, names{20}, names{21}, names{22}, names{23}, names{24}, names{25}, names{26}, names{27}, names{28}}, "SelectionMode", "Single", "Name", "Condutor");

##Atribuição dos parâmetros do condutor escolhido
area = cell2mat(data(sel,1));
camadas = cell2mat(data(sel,2));
raio = cell2mat(data(sel,3));
rmg = cell2mat(data(sel,4));
r_cc_20 = cell2mat(data(sel,5));
r_ca_20 = cell2mat(data(sel,6));
r_ca_50 = cell2mat(data(sel,7));

##Fazendo os cáulculos de Indutância por fase, capacitância por fase, capacitância de sequência zero, impedância característica da linha

##*****************************************************************************************************************************************
## 1. Cálculo de Indutância por fase (assumindo até 4 condutores por fase e linha transposta)


##Calculando as distâncias com base na geometria dada
Dab = sqrt(dist_fases^2 + 5^2);
Dbc = Dab;
Dac = 2 * dist_fases;

GMD = (Dab * Dbc * Dac)^1/3;

switch n_condutores

case 1
  Ds = rmg;
  Rc = raio;

case 2
  Ds = (rmg * dist_condutores)^(1/2);
  Rc = (raio*dist_condutores)^(1/2);

case 3
  Ds = (rmg * (dist_condutores)^2)^(1/3);
  Rc = (raio*dist_condutores*dist_condutores*sqrt(2))^(1/3);
case 4
  Ds = 1.09*(rmg*dist_condutores^3)^(1/4);
  Rc = (raio*dist_condutores*dist_condutores*dist_condutores*sqrt(2))^(1/3);
otherwise
  msgbox ("Insira uma quantidade váida de condutores!", "Alerta");
end


##Aplicando na equação da pag. 40 da aula 15
ind_phase = 0.2*log(GMD/Ds);

##*****************************************************************************************************************************************
## 2. Cálculo de capacitância por fase (capacitâncioa de por fase)

##Aplicando na equação da página 8 aula 16
Cs = 1/(18000000*log(GMD/Rc));

##*****************************************************************************************************************************************
## 3. Cálculo da capacitância de sequência zero

##obtendo hm (altura média geométrica dos cabos sob o solo)
hm = (dist_solo*dist_solo*(dist_solo+ 5))^(1/3);
Aaa = (18000000*log(2*hm/Rc));

##Obtendo o Dmi (DMG entre os condutores de fase e as imagens dos vizinhos)
##Calculando as distnâncias das imagens de cada vizinho
Dab = sqrt((2*dist_solo)^2+dist_fases^2);
Dbc = sqrt(dist_fases^2+(2*dist_solo+5)^2);
Dac = sqrt((2*dist_solo)^2+(2*dist_fases)^2);

Dmi = (Dab*Dbc*Dac)^(1/3);
Aab = (18000000*log(2*Dmi/GMD));

##Aplicando na equalçao da pág 9 da aula 16
C0 = 1/(Aaa + 2 * Aab);

##*****************************************************************************************************************************************
## 4. impedância característica da linha

##considerando as equalçoies da página 13 e 14 da Aula_13_14
L = 2 *log(GMD/Rc)/10000;
C = 1000000*log(GMD/Rc)/18;

Z0 = sqrt(L/C);

##Mostrando os resultados na tela
msgbox ({cstrcat("Indutância por fase: ", num2str(ind_phase)," mH/km" ),cstrcat("Capacitância por fase: ", num2str(Cs) ," F/km"),cstrcat("Capacitância de sequência zero: ", num2str(C0) ," F/km"),cstrcat("Impedância característica da linha: ", num2str(Z0) ," Ω")}, "Resultado");













