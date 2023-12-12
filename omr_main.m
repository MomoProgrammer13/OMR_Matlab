function [data,fsrc] = omr_main(fref, fmsk, ftgt, dsrc)

fimg  = dir(dsrc);
if isempty(fimg)
    disp('images not found in SRC folder.');
    return
end

imfmt = imformats;
imext = strcat('.',[imfmt.ext]);
Nimg  = length(fimg);
imgOK = false(1,Nimg);
for n = 1:Nimg
    [fpath,fname,fext] = fileparts(fimg(n).name);
    if ismember(fext,imext)
        imgOK(n) = true;
    end
end
fsrc = fimg(imgOK);             % images filename
if isdir(dsrc)
    psrc = dsrc;                % images path
else
    psrc = fileparts(dsrc);     
end

    
% Lê as imagens
[REF,map]  = imread(fref);                 % Imagem de Referencia
REF        = omr_adjust_image(REF, map);   % Converte a imagem para tons de cinza
[MSK,map]  = imread(fmsk);                 % Mask image
MSK        = omr_adjust_image(MSK, map);   % Converte a imagem para tons de cinza
[TGT,map]  = imread(ftgt);                 % Imagem de alinhamento
TGT        = omr_adjust_image(TGT, map);   % Converte a imagem para tons de cinza

% Redimensiona as imagens se elas forem muito grande
if numel(REF) > 1024*800
    gain   = 600/size(REF,1);
    REF = imresize(REF, gain);
end
MSK = imresize(MSK, size(REF));
TGT = imresize(TGT, size(REF));

% Representa as coordenadas espacias da imagem de refeencia no mundo
% Coordenadas centradas em (0,0)
% Normalizadas para garantir consistência nas dimensões
[M,N]      = size(REF);
XY(1,:) = [0 M] - M/2;
XY(2,:) = [0 N] - N/2;
XY      = XY / max(XY(:,2));

% Cria a mascara binaria
MSK(MSK<0.5)  = 0;
MSK(MSK>=0.5) = 1;

% Cria a imagem binaria de realinhamento
TGT(TGT<0.5)  = 0;
TGT(TGT>=0.5) = 1;

% Localiza os pontos na mascara e os rotula
BLOBS = omr_mask_labels(MSK);

% Inicializa a estrutura da saida dos dados
data = struct('values', {}, 'labels', {}, 'fval', {});

Nscr = numel(fsrc); % Número total de Folhas Respostas 

for n = 1:Nscr
    disp(['reading file: ' fsrc(n).name ' (' num2str(n) '/' num2str(Nscr) ')']);
    
    % Lê a imagem
    [SRC, map] = imread(fullfile(psrc, fsrc(n).name));
    
    th = graythresh(SRC);
    SRC = im2bw(SRC,th);

    % Converte a imagem para tons de cinza
    SRC = omr_adjust_image(SRC, map);
    
    % Redimensiona a imagem para o tamanho da imagem de referencia
    SRC = imresize(SRC, size(REF));
    
    % Realinha a fonte com  a imagem de referencia
    [aSRC, P, fval] = omr_realign(SRC, REF, TGT, XY);
    
    % Mascara a imagem 
    mSRC = ~MSK .* 1-Scale(aSRC);
    
    % Pega os valores das marcações na imagem fonte
    [values, labels] = omr_values(mSRC, BLOBS);
    
    % Salva os dados para data
    data(n).values = values;
    data(n).labels = labels;
    data(n).fval = fval;
    
    disp([fsrc(n).name ': concluded, fval = ' num2str(fval)]);
end

figure
ax = subplot(1,2,1); imagesc(~MSK .* 1-Scale(SRC)); axis image
title('Negative Source Masked');
ax(2) = subplot(1,2,2); imagesc(~MSK .* 1-Scale(aSRC)); axis image
title('Negative Source Realigned Masked');
linkaxes(ax);



% figure
% ax = subplot(1,3,1); imagesc(REF), axis image
% title('Reference');
% ax(2) = subplot(1,3,2); imagesc(SRC), axis image
% title('Source Native');
% ax(3) = subplot(1,3,3); imagesc(aSRC), axis image
% title('Source Realigned');
% linkaxes(ax);

end

function output = Scale(input)

minval = min(input(:));
maxval = max(input(:));
output = (input - minval) ./ (maxval-minval);

end
