function compileMexCode(fileNames, debugEnabled)
%COMPILEMEXCODE Compile specified (user's) MEX files.
%   COMPILEMEXCODE(FILENAMES, DEBUGENABLED) compiles the MEX files
%   identified by their name. If DEBUGENABLED is set to TRUE, all compiler
%   warnings are enabled, and the files are compiled with the debugging
%   flag on; otherwise, the files are compiled with the optimization flag
%   on.
%
%   FILENAMES is a cell array of strings.

%   Author: Damien Teney

if ~iscellstr(fileNames)
  error('The file names must be in a cell array of strings !');
end

printf('Compiling C code...\n');

dmlDirectory = getDmlDirectory(); % Get the path of the DML library

% Clear previous MEX-related stuff
clear mexcpp;
clear functions;

if nargin > 1 && debugEnabled
  % Enable all warnings, and the check of the assertions
  % Warning: include Visual Studio specific flags
  commandPrefix = ['mex -I''' dmlDirectory ''' -v COMPFLAGS="$COMPFLAGS /Za /W4 /Wall /wd4820 /wd4001" -g '];
else
  commandPrefix = ['mex -I''' dmlDirectory ''' -O COMPFLAGS="$COMPFLAGS /Za /Wall /wd4820 /wd4001" '];
end

for i = 1:numel(fileNames)
  fileName = fileNames{i};
  [directory trash trash] = fileparts(fileName);

  printf('\t%s\n', fileName);

  command = [commandPrefix '-outdir ''' directory ''' ''' fileName '''']
  eval(command);
end
