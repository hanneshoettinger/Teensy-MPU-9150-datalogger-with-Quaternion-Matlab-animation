function filePathAndName = selectFileToOpen(windowCaption, extension, defaultPath)
%SELECTFILETOOPEN Let the user select a file to open.
%   FILENAME = SELECTFILETOOPEN(WINDOWCAPTION, EXTENSION, DEFAULTPATH)
%   displays a window where the user can select a file to open. The
%   parameters are self-explaining. If the user cancels without selecting
%   a file, an error is throwed.
%
%   Note: EXTENSION should be just 3 letters.

%   Author: Damien Teney

defaultFile = [defaultPath filesep '*.' extension];
[fileName path] = uigetfile({['*.' extension]; '*.*'}, ...
                            windowCaption, ...
                            defaultFile);
if fileName == 0
  error('No file selected.');
end

filePathAndName = fullfile(path, fileName);
