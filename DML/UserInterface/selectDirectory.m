function directoryPath = selectDirectory(windowCaption, defaultPath)
%SELECTDIRECTORY Let the user select a directory.
%   DIRECTORYPATH = SELECTDIRECTORY(WINDOWCAPTION, DEFAULTPATH)
%   displays a window where the user can select a directory. The parameters
%   are self-explaining. If the user cancels without selecting a directory,
%   an error is throwed. The returned path ends with FILESEP.

%   Author: Damien Teney

directoryPath = uigetdir(defaultPath, windowCaption);
if directoryPath == 0
  error('No directory selected.');
end

directoryPath = [directoryPath filesep];
