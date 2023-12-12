function err = omr_transform(P, REF, SRC, XY)
%  Function used by 'fminsearch' to align images 
%  Apply transformation and computes correlation between
%  aligned images
%  Inputs:
%       P  Alignement parameters (from 'fminsearch')
%       REF  reference image
%       SRC  source image (the one that will be matched to reference)
%       XY   image coordinates in world space
% Outputs:
%       Negative correlation between aligned images
%
%--------------------------------------------------------------------------
% adapted from Semmelow (2004) "Biosignal and Biomedical Image Processing"
%

% Define affine transformation matrix: A
A           = omr_matrix(P);

% Perform transformation
Tform       = maketform('affine', A');
SRC_aligned = omr_imtransform(SRC, Tform, XY);

% Cost function
err         =  -abs(corr2(SRC_aligned,REF));   % correlation
% err         =  -mi(SRC_aligned,REF);    % mutual information

end

function I = mi(A,B,varargin)
%MI Determines the mutual information of two images or signals
%
%   I=mi(A,B)
%
%   Assumption: 0*log(0)=0
%
%   See also WENTROPY.

%   jfd, 15-11-2006
%        01-09-2009, added case of non-double images

A  = double(A); 
B  = double(B); 
    
na = hist(A(:),256);
na = na/sum(na);

nb = hist(B(:),256);
nb = nb/sum(nb);

n2 = hist2(A,B,256);
n2 = n2/sum(n2(:));

I  = minf(n2,na'*nb);
I  = sum(I);

end

% -----------------------

function y = minf(pab,papb)

I = find(papb>1e-12); % function support

u = pab(I);
v = papb(I);
i = find(u<1e-12);

warning off
y = u.*log2(u./v);
warning on

% assumption: 0*log(0)=0
y(i) = 0;

end

function n = hist2(A,B,L)
%HIST2 Calculates the joint histogram of two images or signals
%
%   n=hist2(A,B,256) is the joint histogram of matrices A and B, using 256
%   bins for each matrix.
%
%   See also MI, HIST.

%   jfd, 15-11-2006, working
%        27-11-2006, memory usage reduced (sub2ind)
%        22-10-2008, added support for 1D matrices
%        01-09-2009, commented specific code for sensorimotor signals


ma = min(A(:));
MA = max(A(:));
mb = min(B(:));
MB = max(B(:));

% For sensorimotor variables, in [-pi,pi]
% ma=-pi;
% MA=pi;
% mb=-pi;
% MB=pi;

% Scale and round to fit in {0,...,L-1}
A = round((A-ma)*(L-1)/(MA-ma));
B = round((B-mb)*(L-1)/(MB-mb));

for i=0:L-1
    [x,y] = find(A==i);
    siz   = size(A);
    if(min(siz)>1)
        j = sub2ind(siz,x,y);
    else  % case in which A,B are vectors
        j = max(x,y);
    end
    
    n(i+1,:) = hist(B(j),0:L-1);
end

end