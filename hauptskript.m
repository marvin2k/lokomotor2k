%%
%
%
%
%
%
%%
function [] = hauptscript()

% Parameter laden
params;
% Benötigte Parameter in den lokalen Namensraum hohlen
n = param_n;
L = param_L;
alpha_max = param_alpha_max;
T = param_T;
f = param_f;
u = param_u;
% Das erste Skript aufrufen
[xJ_M yJ_M alpha_M] = fit_sequenz(f, u, T, n, L, alpha_max );

[c1 c2] = fit_emulation_coeffs( alpha_M );

coeffs = param_coeffs;

emulate_sequenz( c1*ones(1,T) c2*ones(1,T), n, L, alpha_max )
