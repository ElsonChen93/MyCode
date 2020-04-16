function [imageda,samples,bands,lines]=GetEnviinf(fn,fn2)
% Designed by Elson Chen
% Get basic information of Envi data
% [imageda,samples,bands,lines]=GetEnviinf(fn,fn2)
% fn:��������ͷ�ļ����� eg:'1.hdr'
% fn2�����������ļ���
% imageda:��������, samples by lines by bands
% samples
% bands
% lines

%% ���samples��bands��lines
fid = fopen(fn,'r');
R = [];
while ~feof(fid)
    tl = fgetl(fid);
    id = findstr(tl,'samples');%If does not find the str then return 0
    if ~isempty(id)
        eval(tl)%ִ��tl�е�����
        %         break
    end
    id = findstr(tl,'lines');%If does not find the str then return 0
    if ~isempty(id)
        eval(tl)%ִ��tl�е�����
        %         break
    end
    id = findstr(tl,'bands');%If does not find the str then return 0
    if ~isempty(id)
        eval(tl)%ִ��tl�е�����
        break
    end
    %         id = findstr(tl,'data type');%If does not find the str then return 0
    %     if ~isempty(id)
    %         datatype=str2num(tl(isstrprop(tl,'digit')));
    %         break
    %     end;
end;
%% ���envi�洢����������
while ~feof(fid)
    tl = fgetl(fid);
    id = findstr(tl,'data type');%If does not find the str then return 0
    if ~isempty(id)
        datatype=str2num(tl(isstrprop(tl,'digit')));
        break
    end;
end

d={'bit8' 'int16' 'int32' 'float32' 'float64' 'uint16' 'uint32' 'int64' 'uint64'};

switch datatype
    case 1
        t=d(1);
    case 2
        t=d(2);
    case 3
        t=d(3);
    case 4
        t=d(4);
    case 5
        t=d(5);
    case 12
        t=d(6);
    case 13
        t=d(7);
    case 14
        t=d(8);
    case 15
        t=d(9);
    otherwise
        error('Unknown image data type');
end
data_type=char(t)

%% ��ù�������
f=fopen(fn2);
a=fread(f,data_type);%ʹ��freadд��ʱ��Ҫע��˳��
imageda = reshape(a,samples,bands,lines);%%
%ע��:��ͬ���������˳����ܲ�ͬ�����˳��,samples��lines��˳���в������bandsһ����ǰ
imageda=permute(imageda,[1 3 2]);
fclose('all')
clc
end