function [ tmpseg, index ] = circSegCopy(seglength,soundfile)

% allocate space for temporary segment
tmpseg = zeros(1,seglength);

% randomly generate an index
index = ceil(rand(1,1)*length(soundfile));

% if the index is too close to the end of the soundfile, make sure the copy
%   procedure wraps around to the beginning of the soundfile
% otherwise, just copy a segment of the soundfile
% return copied segment
if index > (length(soundfile)-seglength+1)
    tmpseg_p1 = soundfile(index:length(soundfile));
    tmpseg_p2 = soundfile(1:seglength-length(tmpseg_p1));
    tmpseg(1:length(tmpseg_p1)) = tmpseg_p1;
    tmpseg((length(tmpseg_p1)+1):seglength) = tmpseg_p2;
else
    tmpseg(1:seglength) = soundfile(index:(index+seglength-1));
end
end % return tmpseg and uniformly distributed generated index

