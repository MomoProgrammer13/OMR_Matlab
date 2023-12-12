function [values,labels] = omr_values(mSRC, BLOBS)

% Calculate mean intensity within each blob
%----------------------------------------------------
labels = unique(BLOBS(BLOBS>0))';
n      = length(labels);
values = zeros(1,n);

for i = 1:n
    values(i) = mean(mSRC(BLOBS==labels(i)));
end

end