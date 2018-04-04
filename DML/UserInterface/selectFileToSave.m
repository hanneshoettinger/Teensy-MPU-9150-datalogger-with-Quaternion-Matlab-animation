function filePathAndName = selectFileToSave(windowCaption, extension, defaultPath)
%SELECTFILETOSAVE Let the user select a file to save.
%   FILENAME = SELECTFILETOSAVE(WINDOWCAPTION, EXTENSION, DEFAULTPATH)
%   displays a window where the user can select a file to save. The
%   parameters are self-explaining. If the user cancels without selecting
%   a file, an error is throwed.
%
%   Note: EXTENSION should be just 3 letters.

%   Author: Damien Teney

defaultFile = [defaultPath filesep '*.' extension];
[fileName path] = uiputfile({['*.' extension]; '*.*'}, ...
                            windowCaption, ...
                            defaultFile);
if fileName == 0
  error('No file selected.');
end

filePathAndName = fullfile(path, fileName);
