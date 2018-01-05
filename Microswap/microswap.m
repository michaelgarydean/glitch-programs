dirName = 'Sources';                        % folder path
files = dir(fullfile(dirName) );            % list all files
files = {files.name}';                      % file names

% skip hidden files etc
files = files(4:length(files));

for i=1:length(files)
    fname = fullfile(dirName,files{i});     % full path to file

    % get file and copy samples to an array
    [soundfile,fs,nbits] = wavread(fname);
    soundfile = transpose(soundfile);

    % extract filename for output naming
    filename = symvar(fname);
    filename = filename(1);

    segLengths = [10, 100, 1000, 10000, 25000, 50000, 100000];
    swaps = [10, 100];

    for seg=1:length(segLengths)

        seglen = segLengths(seg);   % length of segments to swap (in samples)

        for swp=1:length(swaps)

            numSwaps = swaps(swp);  % number of swap procedures

            % perform swap procedure repeatedly
            for n=1:numSwaps;
                
                % copy segments
                [seg1,index1] = circSegCopy(seglen, soundfile);
                [seg2,index2] = circSegCopy(seglen, soundfile);

                % paste segments in opposite locations
                soundfile(index1:index1+seglen-1) = seg2;
                soundfile(index2:index2+seglen-1) = seg1;
            end

            % write to file
            outputName = char(strcat('ms_',filename,'_',num2str(seglen)...
                ,'seg_',num2str(numSwaps),'swaps'));
            wavwrite(soundfile,fs,nbits,outputName);
        end
    end
end
