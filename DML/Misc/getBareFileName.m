function fileName2 = getBareFileName(fileName)
%GETBAREFILENAME Remove the path/extension from a file name.
%   FILENAME2 = GETBAREFILENAME(FILENAME) takes a file name with (possibly)
%   a path, and (possibly) an extension, and returns the file name itself.

%   Author: Damien Teney

[trash fileName2 trash] = fileparts(fileName);
