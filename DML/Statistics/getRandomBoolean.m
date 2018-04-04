function x = getRandomBoolean()
%GETRANDOMBOOLEAN Random boolean value.
%   X = GETRANDOMBOOLEAN() returns a random boolean value.

%   Author: Damien Teney

% Method 1: alternating true/false at each call
persistent currentState;
if isempty(currentState)
  currentState = true;
end
x = currentState;
currentState = ~currentState;

% Method 2: really random
%x = rand() > 0.5;
