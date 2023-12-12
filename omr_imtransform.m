function Itrans = omr_imtransform(I, Tform, XY)

try 
    Itrans = imwarp(I, Tform, 'FillValues', 1, 'size', size(I), ...
                          'Udata', XY(2,:), 'Vdata', XY(1,:), ...
                          'Xdata', XY(2,:), 'Ydata', XY(1,:));
catch
    Itrans = imtransform(I, Tform, 'FillValues', 1, 'size', size(I), ...
                          'Udata', XY(2,:), 'Vdata', XY(1,:), ...
                          'Xdata', XY(2,:), 'Ydata', XY(1,:));
end

end