function omr_job(fref, fmsk, ftgt, dsrc, OMR_RATINGS,fwas)

if exist('OCTAVE_VERSION', 'builtin') ~= 0
    try 
        pkg load image
    catch
        error('image toolbox needs to be installed.');
    end
end

% Processa o gabarito da imagem
template = omr_main(fref,fmsk,ftgt,fwas);

%Processa as imagens fornecidas
data = omr_main(fref, fmsk, ftgt, dsrc);
    

% Pega os valores do gabarito
templet = OMR_RATINGS(template,false);

% Pega as notas das imagens fornecidas
ratings = OMR_RATINGS(data,true,templet);


end
