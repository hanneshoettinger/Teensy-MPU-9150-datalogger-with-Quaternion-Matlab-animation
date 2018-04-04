function result = isAlmostEqual(number1, number2)
%ISALMOSTEQUAL True if arrays are numerically close.

%   Author: Damien Teney

if number2 == 0
  if number1 > 1e-8
    result = false;
  else
    result = true;
  end
else
  ratio = number1 ./ number2;

  slack = 0.001;

  if ~isempty(find(ratio < 1 - slack, 1)) || ~isempty(find(ratio > 1 + slack, 1))
    result = false;
  else
    result = true;
  end
end
