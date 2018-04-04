function directory = getDmlDirectory()
%GETDMLDIRECTORY Path to the directory containing the DML.
%   DIRECTORY = GETDMLDIRECTORY() returns the path to the directory
%   containing the DML.

%   Author: Damien Teney

[directory trash trash] = fileparts(mfilename('fullpath'));
directory = [directory filesep];
