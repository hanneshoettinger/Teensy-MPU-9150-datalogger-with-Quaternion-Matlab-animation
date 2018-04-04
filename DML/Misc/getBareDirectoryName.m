function directoryName2 = getBareDirectoryName(directoryName)
%GETBAREDIRECTORYNAME Remove the path from a directory name.
%   DIRECTORYNAME2 = GETBAREDIRECTORYNAME(DIRECTORYNAME) takes a path to a
%   directory, and returns the name of the directory itself (without the
%   preceding path).

%   Author: Damien Teney

% Remove the slash/backslash at the end
if isequal(directoryName(end), filesep)
  directoryName2 = directoryName(1:(end - 1));
end

[trash directoryName2 trash] = fileparts(directoryName2);
