function x = getUserValue_number(message, minValue, maxValue, defaultValue)
%GETUSERVALUE_NUMBER Let the user enter an numerical value.
%   X = GETUSERVALUE_NUMBER(MESSAGE, MINVALUE, MAXVALUE, DEFAULTVALUE)
%   shows a given message, and let the user enter a number which must be
%   within given bounds. If the user doesn't enter any value, the
%   specified default value is returned. If the entered value is outside
%   given bounds, an error is throwed.

%   Author: Damien Teney

x = input([message ' [' num2str(minValue) '..' num2str(maxValue) '; default: ' num2str(defaultValue) '] ']);
assert(isempty(x) || isscalar(x));

if isempty(x)
  x = defaultValue;
else
  if x < minValue || x > maxValue
    error('Value outside bounds.');
  end
end
