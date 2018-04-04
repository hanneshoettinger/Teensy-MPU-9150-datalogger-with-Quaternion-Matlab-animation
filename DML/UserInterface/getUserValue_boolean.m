function x = getUserValue_boolean(message, defaultValue)
%GETUSERVALUE_BOOLEAN Let the user enter a yes/no value.
%   X = GETUSERVALUE_BOOLEAN(MESSAGE, DEFAULTVALUE) shows a given
%   message, and let the user enter a yes/no answer. If the user doesn't
%   enter any value, the specified default value is returned.

%   Author: Damien Teney

if defaultValue == true
  x = input([message ' [0=N / 1=Y; default: Y] ']);
else
  x = input([message ' [0=N / 1=Y; default: N] ']);
end

if isempty(x)
  x = defaultValue;
else
  if ~isequal(x, 0) && ~isequal(x, 1)
    error('Invalid value.');
  end
  x = logical(x);
end
