function rating = omr_get_rating(data, labels)


% Pega os valores do Blobs
blobs_values = data.values( labels );

% Seleciona o Valor do blob
[y,i]  = sort(blobs_values,'descend');
% thresh = 0.5*(max(blobs_values)-min(blobs_values))+min(blobs_values);
thresh = 1/3;   % Assumindo que o valor do blob inteiro vale 1 
value  = i(y>thresh);

if isempty(value) || var(blobs_values)<10^-5
    % Se a escala esta vazia atribue o valor para blank 
    status = 'blank';
elseif numel(value) > 1
    % Se está marcada mais de um valor, atribui o valor para multiple 
    status = 'multiple';
else    
    status = 'single';    
end


rating.value  = value;
rating.status = status;

end