function q = q_mult(q2, q1)
%Q_MULT Multiplication of two quaternions.
%   Q = Q_MULT(Q2, Q1) returns Q so that Q = Q2 * Q1. This corresponds to
%   the concatenation of the rotations represented by Q1 (applied first)
%   and Q1 (applied second).

%   Author: Damien Teney

q = zeros(1, 4);

q(1) = q2(1)*q1(1) - q2(2)*q1(2) - q2(3)*q1(3) - q2(4)*q1(4);
q(2) = q2(1)*q1(2) + q2(2)*q1(1) + q2(3)*q1(4) - q2(4)*q1(3);
q(3) = q2(1)*q1(3) - q2(2)*q1(4) + q2(3)*q1(1) + q2(4)*q1(2);
q(4) = q2(1)*q1(4) + q2(2)*q1(3) - q2(3)*q1(2) + q2(4)*q1(1);
