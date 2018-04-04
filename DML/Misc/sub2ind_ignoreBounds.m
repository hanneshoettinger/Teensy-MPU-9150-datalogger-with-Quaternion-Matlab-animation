function ndx = sub2ind_ignoreBounds(siz,varargin)
%SUB2IND_IGNOREBOUNDS Linear index from multiple subscripts (out of bounds inputs generate indices equal to 1).
%   See SUB2IND.

%   Author: The MathWorks, Inc., modified by Damien Teney

siz = double(siz);
if length(siz)<2
        error(message('MATLAB:sub2ind:InvalidSize'));
end

if length(siz) ~= nargin-1
    %Adjust input
    if length(siz)<nargin-1
        %Adjust for trailing singleton dimensions
        siz = [siz ones(1,nargin-length(siz)-1)];
    else
        %Adjust for linear indexing on last element
        siz = [siz(1:nargin-2) prod(siz(nargin-1:end))];
    end
end

%Compute linear indices
k = [1 cumprod(siz(1:end-1))];
ndx = 1;
s = size(varargin{1}); %For size comparison
invalidIndices = false(1, length(siz - 1)); % Marks the elements of ndx which are invalid because of out of bound inputs
for i = 1:length(siz),
    v = varargin{i};
    %%Input checking
    if ~isequal(s,size(v))
        %Verify sizes of subscripts
        error(message('MATLAB:sub2ind:SubscriptVectorSize'));
    end

    % Correct out of range values
    invalidIndices((v(:) < 1) | (v(:) > siz(i))) = true;

    ndx = ndx + (v-1)*k(i);
end

ndx(invalidIndices) = 1; % Default value for invalid indices
