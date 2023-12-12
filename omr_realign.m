function [SRC_aligned, P, fval] = omr_realign(SRC, REF, TGT, XY)    

    % Set initial values for transformation
    %----------------------------------------------------
    % P0      = [0 0 0 1 1];          % with scaling
    P0      = [0 0 0];              % without scaling

    % Mask region outside target area
    nTGT = cast(~TGT, class(TGT));
    cREF = REF .* nTGT + TGT;
    cSRC = SRC .* nTGT + TGT;

    % Find transformation to align the image
    %----------------------------------------------------
    options = optimset('Display', 'iter', 'TolFun', 10^-3, 'TolX', 10^-3);
    [P, fval,e] = fminsearch('omr_transform', P0, options, cREF, cSRC, XY);

    % Realign image using optimized parameters
    %----------------------------------------------------
    A = omr_matrix(P);
    Tform = maketform('affine', A');
    SRC_aligned = omr_imtransform(SRC, Tform, XY);

end
