function I = omr_adjust_image(I, map)

if isempty(map) == 0            % If Indexed data:
    I = ind2gray(I,map);        % convert to Intensity image
else 
    if ndims(I) == 3            % If RGB data:
        I = I(:,:,1:3);         % ignore any alpha channel
        I = rgb2gray(I);        % convert to Intensity image
    end
    I = im2double(I);           % convert to double and scale
end

end
