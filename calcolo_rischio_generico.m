%Calcolo rischio VPHOP
%lancio excel
%file='Results_TOT.pdrs';							%INPUT
filein=argv(){1}
fileout='total_risk.txt'
RF='RF.txt'
n_anni=10;

% [file, path] = uigetfile('.pdrs','name of file to open');
nomefile=[filein]
fid=fopen(nomefile);

nc = 99;   % nuber of rows to be read from the data structure contained in the text file
%L'utente deve digitare quante righe della matrice di CHA ha tirato fuori dal database
% prompt = {'Enter number of rows of CHA matrix'};
% answer = inputdlg(prompt,'nr')
% rows=str2double(answer)
% nr=rows     % number of columns to be read...

prima_colonna = nc-10; % first column to be stored in the 'data2' array
data = fgetl(fid)
data = fgetl(fid)

data = fscanf(fid,'%g ',inf)
w=size(data)
nr=w(1,1)/nc
data2=[];
for c=prima_colonna:nc
    data2 = [data2;data(c:nc:end)];
end
clear data;
fclose(fid); % closing the file just read

savefile=fileout;
save(savefile,'data2','-ascii');

risk_of_fracture=n_anni

%Preparazione dei dati per il successivo calcolo dei vari rischi
data3=data2(1:nr,1)
data4=data3'
data5=data2(1:2*nr,1)
dat6=data5'
data7=data2(1:3*nr,1)
data8=data7'
data9=data2(1:4*nr,1)
data10=data9'
data11=data2(1:5*nr,1)
data12=data11'
data13=data2(1:6*nr,1)
data14=data13'
data15=data2(1:7*nr,1)
data16=data15'
data17=data2(1:8*nr,1)
data18=data17'
data19=data2(1:9*nr,1)
data20=data19'
data21=data2(1:10*nr,1)
data22=data21'
data23=data2(1:11*nr,1)
data24=data23'

%Calcolo dei rischi ai vari anni

if risk_of_fracture==0
    %calcolo rischio attuale
    quanti_magg1_actual=0
for jj=data4
if (jj>=1)
    
    quanti_magg1_actual=quanti_magg1_actual+1
    
end
end

run_actual=nr
RF_actual=quanti_magg1_actual/run_actual
RF_actual_perc=RF_actual*100
rischio_finale=RF_actual_perc

    
elseif risk_of_fracture==1
    %calcolo rischio al primo anno    
    quanti_magg1_primo_anno=0
for kk=data6
if (kk>=1)
    
    quanti_magg1_primo_anno=quanti_magg1_primo_anno+1
    
end
end
run_primo_anno=2*nr
RF_1=quanti_magg1_primo_anno/run_primo_anno
RF_1_perc=RF_1*100
rischio_finale=RF_1_perc
       
    
    elseif risk_of_fracture==2
    %calcolo rischio al secondo anno
    
    quanti_magg1_secondo_anno=0
for hh=data8
if (hh>=1)
    
    quanti_magg1_secondo_anno=quanti_magg1_secondo_anno+1
    
end
end
run_secondo_anno=3*nr
RF_2=quanti_magg1_secondo_anno/run_secondo_anno
RF_2_perc=RF_2*100           
rischio_finale=RF_2_perc

    elseif risk_of_fracture==3
    %calcolo rischio al terzo anno
    
    quanti_magg1_terzo_anno=0
for z=data10
if (z>=1)
    
    quanti_magg1_terzo_anno=quanti_magg1_terzo_anno+1
    
end
end
run_terzo_anno=4*nr
RF_3=quanti_magg1_terzo_anno/run_terzo_anno
RF_3_perc=RF_3*100    
rischio_finale=RF_3_perc    
    
    
    elseif risk_of_fracture==4

    %calcolo rischio al quarto anno
    
    
    quanti_magg1_quarto_anno=0
for beta=data12
if (beta>=1)
    
    quanti_magg1_quarto_anno=quanti_magg1_quarto_anno+1
    
end
end
run_quarto_anno=5*nr
RF_4=quanti_magg1_quarto_anno/run_quarto_anno
RF_4_perc=RF_4*100    
rischio_finale=RF_4_perc
    
    elseif risk_of_fracture==5
    %calcolo rischio al quinto anno
    
    quanti_magg1_quinto_anno=0
for gamma=data14
if (gamma>=1)
    
    quanti_magg1_quinto_anno=quanti_magg1_quinto_anno+1
    
end
end
run_quinto_anno=6*nr
RF_5=quanti_magg1_quinto_anno/run_quinto_anno
RF_5_perc=RF_5*100       
rischio_finale=RF_5_perc
        
    elseif risk_of_fracture==6
    %calcolo rischio al sesto anno
    
    quanti_magg1_sesto_anno=0
for delta=data16
if (delta>=1)
    
    quanti_magg1_sesto_anno=quanti_magg1_sesto_anno+1
    
end
end
run_sesto_anno=7*nr
RF_6=quanti_magg1_sesto_anno/run_sesto_anno
RF_6_perc=RF_6*100
rischio_finale=RF_6_perc
    
                  
    elseif risk_of_fracture==7
    %calcolo rischio al settimo anno
    
    quanti_magg1_settimo_anno=0
for alpha=data18
if (alpha>=1)
    
    quanti_magg1_settimo_anno=quanti_magg1_settimo_anno+1
    
end
end
run_settimo_anno=8*nr
RF_7=quanti_magg1_settimo_anno/run_settimo_anno
RF_7_perc=RF_7*100                 
rischio_finale=RF_7_perc
    
    elseif risk_of_fracture==8
    %calcolo rischio all'ottavo anno
    
    quanti_magg1_ottavo_anno=0
for epsilon=data20
if (epsilon>=1)
    
    quanti_magg1_ottavo_anno=quanti_magg1_ottavo_anno+1
    
end
end
run_ottavo_anno=9*nr
RF_8=quanti_magg1_ottavo_anno/run_ottavo_anno
RF_8_perc=RF_8*100                 
rischio_finale=RF_8_perc
         
    
    elseif risk_of_fracture==9
    %calcolo rischio al nono anno
    
    quanti_magg1_nono_anno=0
for zeta=data22
if (zeta>=1)
    
    quanti_magg1_nono_anno=quanti_magg1_nono_anno+1
    
end
end
run_nono_anno=10*nr
RF_9=quanti_magg1_nono_anno/run_nono_anno
RF_9_perc=RF_9*100                
rischio_finale=RF_9_perc
       
    
    elseif risk_of_fracture==10
    %calcolo rischio al decimo anno

quanti_magg1_decimo_anno=0

for i=data24
if (i>=1)
    
    quanti_magg1_decimo_anno=quanti_magg1_decimo_anno+1
    
end
end

run_tot=nr*11
RF_10=quanti_magg1_decimo_anno/run_tot
RF_10_perc=RF_10*100
rischio_finale=RF_10_perc
    
end

save(RF,'rischio_finale','-ascii');

