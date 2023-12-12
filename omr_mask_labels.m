function BLOBS = omr_mask_labels(MSK, dispOK)

if nargin < 2
    dispOK = true;
end

% Se MSK for uma string, carrega a imagem
if ischar(MSK)
    [MSK map] = imread(MSK);            
    MSK = omr_adjust_image(MSK, map);  
end

%Localiza os blobs 
[BLOBS, N] = bwlabel(~MSK);   % N = numero de blobs achados
if dispOK
    figure
    imshow(BLOBS);
    for k = 1:N
        % Calcula o centro de gravidade do blob
        [i j] = find(BLOBS == k);
        cog   = mean([i j])';
        t     = text(cog(2), cog(1), num2str(k));
        set(t, 'Color', 'r', 'FontWeight', 'bold');
    end
end

end