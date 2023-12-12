clc, clear , close all

fref     = fullfile('.','teste','reference.jpg');
fmsk     = fullfile('.','teste','mask.jpg');
ftgt     = fullfile('.','teste','target.tif');
faws     = fullfile('.','teste','template.tif');
dsrc     = fullfile('.','teste','subjects','*.jpg');


%função de analizar a nota
RATINGS = @ratings;
tic
omr_job(fref, fmsk, ftgt, dsrc, RATINGS,faws);
toc
