function p = v3_getPdf_antipodalVMF(v, mu, kappa)
%V3_GETPDF_ANTIPODALVMF  Probability in pair of antipodal von Mises-Fisher distributions (2-sphere).
%   P = V3_GETPDF_ANTIPODALVMF(V, MU,KAPPA) returns the probability density
%   of a unit 3-vector (1x3 vector) in an pair of antipodal von Mises-
%   Fisher distributions, of parameters mu (1x3 vector) and kappa (scalar).
%
%   V can contain several quaternions (Nx2), P is then of dimension 1xN.
%
%   V and MU must be of unit-length.

%   Author: Damien Teney

p1 = v3_getPdf_VMF(v, mu, kappa);
p2 = v3_getPdf_VMF(v, -mu, kappa);

p = (p1 + p2) / 2;
