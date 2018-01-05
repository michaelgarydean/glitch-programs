% image to sonify
file = 'source/img04.jpg';

% extract filename for output naming
filename = symvar(file);
filename = filename(1);

% .wav file characteristics
rates = [800,4800,10000,22000,48000,100000];    % sample rates for exports
bitDepth = 16;                                  % bit depth

% convert from uint8 format to doubles [-1.0,1.0]
img = getimage(file);
img = img.*2.-1;

% reshape matrix to a 1 Dimensional one
output = reshape(img,1,[]);

% output .wav files of different sample rates
for sr=1:length(rates)
    outputName = char(strcat(filename,'_',num2str(rates(sr)),'Hz_',...
        num2str(bitDepth),'bit'));
    wavwrite(output,rates(sr),bitDepth,outputName);
end

