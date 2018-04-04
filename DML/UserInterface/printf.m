function printf(varargin)
%PRINTF Same as fprintf, but outputs to stdout.

%   Author: Damien Teney

fprintf(1, varargin{:});
