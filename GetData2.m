% Elson
%Need getrawdata,getrawdata2
clc
clear
close all
f='leaf';
str=".hdr";%ͷ�ļ��ĺ�׺
str2=".raw";%Enviԭʼ�ļ��ĺ�׺
fn =insertBefore(str,".",f);
fn2 =insertBefore(str2,".",f);
[Spectradata,samples,bands,lines]=GetEnviinf(fn,fn2);
clearvars -EXCEPT lines samples bands Spectradata

%%
imshow(Spectradata(:,:,100))
save testdata.mat Spectradata bands