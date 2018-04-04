function x = getRandomInteger_uniform(min, max)
%GETRANDOMINTEGER_UNIFORM Random integers in uniform distribution.
%   X = GETRANDOMINTEGER_UNIFORM(MIN, MAX) returns one random number in
%   [min,max] interval.

%   Author: Damien Teney

x = round(getRandom_uniform(min, max));
