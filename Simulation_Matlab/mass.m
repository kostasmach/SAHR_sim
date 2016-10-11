function M = mass(t,x)

%-------------------------------------------------------------------------%
% All solvers solve systems of equations in the form 
% y' = f(t,y) or problems that involve a mass matrix, 
% M(t,y)y' = f(t,y). The ode23s solver can solve only 
% equations with constant mass matrices. ode15s and 
% ode23t can solve problems with a mass matrix that is 
% singular, i.e., differential-algebraic equations (DAEs).
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% All solvers solve systems of equations in the form 
% y' = f(t,y) or problems that involve a mass matrix, 
% M(t,y)y' = f(t,y). The ode23s solver can solve only 
% equations with constant mass matrices. ode15s and 
% ode23t can solve problems with a mass matrix that is 
% singular, i.e., differential-algebraic equations (DAEs).
%-------------------------------------------------------------------------%

global mb ml Il g k Lspring  

%-------------------------------------------------------------------------%
% x(1) = xb 
% x(2) = xbdot 
% x(3) = yb
% x(4) = ybdot
% x(5) = thl
% x(6) = thldot
% x(7) = l
% x(8) = ldot
%-------------------------------------------------------------------------%

xb = x(1);
xbdot = x(2);
yb = x(3);
ybdot = x(4);
thl = x(5);
thldot = x(6);
l = x(7);
ldot = x(8);

%-------------------------------------------------------------------------%
% Mass matrix
%-------------------------------------------------------------------------%
M = zeros(8,8);

%-------------------------------------------------------------------------%
% from Mathematica we get

M(2,2)=mb+ml;
M(2,4)=0;
M(2,6)=(1/2).*l.*ml.*cos(thl);
M(2,8)=(1/2).*ml.*sin(thl);

M(4,4)=mb+ml;
M(4,6)=(1/2).*l.*ml.*sin(thl);
M(4,8)=(-1/2).*ml.*cos(thl);

M(6,6)=Il+(1/4).*l.^2.*ml;
M(6,8)=0;

M(8,8)=(1/4).*ml;

%-------------------------------------------------------------------------%
% We add the symmetric elements

M(4,2)=M(2,4);
M(6,2)=M(2,6);
M(8,2)=M(2,8);

M(6,4)=M(4,6);
M(8,4)=M(4,8);

M(8,6)=M(6,8);

%-------------------------------------------------------------------------%
% We add aces for diagonal odd elements

M(1,1) = 1;
M(3,3) = 1;
M(5,5) = 1;
M(7,7) = 1;


