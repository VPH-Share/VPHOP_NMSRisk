#! /usr/bin/octave -qf

if( nargin != 2 )
    printf( "Usage: octave fromSCRIPTCsamp_v2.m inputFile outputFile");
    return;
endif


%file='OUTPUT_FORCES.txt';							%INPUT
filein=argv(){1}
fileout=argv(){2}

fid=fopen(filein);

ans=fscanf(fid,'%s',87);
loop=1500;							%INPUT
a=zeros(loop,84);
b=zeros(loop,3);
b=b+1;
i=1;
while i<=loop
	ans=fscanf(fid,'%s',3);
	tmp=fscanf(fid,'%f',84)';
	a(i,:)=tmp;
	b(i,3)=i;
	i=i+1;
end
a=[b,a];
clear b;
fclose(fid);

titolo_campionamento='ipermodello_femori';
intestazioni='ITER	CYCL	LOOP	HJCX	HJCY	HJCZ	RGLUTMAX1X	RGLUTMAX1Y	RGLUTMAX1Z	RGLUTMAX2X	RGLUTMAX2Y	RGLUTMAX2Z	RGLUTMAX3X	RGLUTMAX3Y	RGLUTMAX3Z	RGLUTMED1X	RGLUTMED1Y	RGLUTMED1Z	RGLUTMED2X	RGLUTMED2Y	RGLUTMED2Z	RGLUTMED3X	RGLUTMED3Y	RGLUTMED3Z	RGLUTMIN1X	RGLUTMIN1Y	RGLUTMIN1Z	RGLUTMIN2X	RGLUTMIN2Y	RGLUTMIN2Z	RGLUTMIN3X	RGLUTMIN3Y	RGLUTMIN3Z	RADDMAG1X	RADDMAG1Y	RADDMAG1Z	RADDMAG2X	RADDMAG2Y	RADDMAG2Z	RADDMAG3X	RADDMAG3Y	RADDMAG3Z	RADDBREVX	RADDBREVY	RADDBREVZ	RADDLONGX	RADDLONGY	RADDLONGZ	RPECTX	RPECTY	RPECTZ	RILIACUSX	RILIACUSY	RILIACUSZ	RPERIX	RPERIY	RPERIZ	RQUADFEMX	RQUADFEMY	RQUADFEMZ	RGEMX	RGEMY	RGEMZ	RBIFEMSHX	RBIFEMSHY	RBIFEMSHZ	RVASINTX	RVASINTY	RVASINTZ	RVASLATX	RVASLATY	RVASLATZ	RVASMEDX	RVASMEDY	RVASMEDZ	RLATGASX	RLATGASY	RLATGASZ	RMEDGASX	RMEDGASY	RMEDGASZ	COORAPPLX	COORAPPLY	COORAPPLZ	TMSC	TSKC DN ';

%output_file='load_cases.txt';							%OUTPUT
%fid=fopen(output_file,'wt');

fid=fopen(fileout,'wt');
fprintf(fid,'%s',titolo_campionamento);
fprintf(fid,'\n');
fprintf(fid,'%s',intestazioni);
fprintf(fid,'\n');

for i=1:loop
	for j=1:87
		if j<=3
			fprintf(fid,'%i\t',a(i,j));
		else
			if j==87
				fprintf(fid,'%f',a(i,j)*10);
			else
				fprintf(fid,'%f\t',a(i,j)*10);
			end
		end
	end
	fprintf(fid,'\n');
end
fclose(fid);
