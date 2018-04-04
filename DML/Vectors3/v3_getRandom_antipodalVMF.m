function v = v3_getRandom_antipodalVMF(mu, kappa)
%V3_GETRANDOM_ANTIPODALVMF Random unit 3-vector from pair of antipodal von Mises-Fisher distributions.
%   V = V3_GETRANDOM_ANTIPODALVMF(MU, KAPPA) returns a unit 3-vector,
%   distributed on the 2-sphere according to a pair of antipodal von
%   Mises-Fisher distributions, of parameters mu (1x3) and kappa (>= 0).

%   Author: Damien Teney

% Get a random sample
v = v3_getRandom_VMF(mu, kappa);

if rand(1) < 0.5 % 0.5 probability
  % Return the sample "from front to back"
  v = -v;
end
