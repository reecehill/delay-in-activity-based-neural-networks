function ddex1
%DDEX1  Example 1 for DDE23.
%   This is a simple example of Wille' and Baker that illustrates the
%   straightforward formulation, computation, and plotting of the solution
%   of a system of delay differential equations (DDEs).
%
%   The differential equations
%
%        y'_1(t) = y_1(t-1)
%        y'_2(t) = y_1(t-1)+y_2(t-0.2)
%        y'_3(t) = y_2(t)
%
%   are solved on [0, 5] with history y_1(t) = 1, y_2(t) = 1, y_3(t) = 1 for
%   t <= 0.
%
%   The lags are specified as a vector [1, 0.2], the delay differential
%   equations are coded in the subfunction DDEX1DE, and the history is
%   evaluated by the function DDEX1HIST. Because the history is constant it
%   could be supplied as a vector:
%       sol = dde23(@ddex1de,[1, 0.2],ones(3,1),[0, 5]);
%
%   See also DDE23, FUNCTION_HANDLE.

%   Jacek Kierzenka, Lawrence F. Shampine and Skip Thompson
%   Copyright 1984-2014 The MathWorks, Inc.

sol = dde23(@ddex1de,[1, 0.2],@ddex1hist,[0, 5]);
figure;
plot(sol.x,sol.y)
title('An example of Wille'' and Baker.');
xlabel('time t');
ylabel('solution y');

% --------------------------------------------------------------------------

function s = ddex1hist(t)
% Constant history function for DDEX1.
s = ones(3,1);

% --------------------------------------------------------------------------

function dydt = ddex1de(t,y,Z)
% Differential equations function for DDEX1.
ylag1 = Z(:,1);
ylag2 = Z(:,2);
u = y(1);
uLagTau1 = ylag1(1);
uLagTau2 = ylag1(2); 
vLagTau1 = ylag2(1);
vLagTau2 = ylag2(2); 
v = y(2);
dydt = [ ylag1(1)
   uLagTau1 + vLagTau2
   y(2)               ];
