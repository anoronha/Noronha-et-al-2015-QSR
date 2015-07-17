function [c, ceq] = nonlcon(x)

global Aeq beq A b

Aeq = [1 1 1 1 0 0 0 0];
beq = 1;

%equality matrices require that the first three values in the guesses in x
%add up to 1

A = [-1 0 0 0 0 0 0 0;...
     0 -1 0 0 0 0 0 0;...
     0 0 -1 0 0 0 0 0;...
     0 0 0 -1 0 0 0 0;...
     0 0 0 0 -1 0 0 0;...
     0 0 0 0 0 -1 0 0;...
     0 0 0 0 0 0 -1 0;...
     0 0 0 0 0 0 0 -1];

b = [0; 0; 0; 0; 0; 0; 0; 0];



ceq = (Aeq*x)-beq;
c = (A*x)-b;